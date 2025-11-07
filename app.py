from flask import Flask, render_template, request, redirect, url_for, flash, session, send_from_directory, jsonify
import mysql.connector
import random
from sentence_transformers import SentenceTransformer, util
from flask_bcrypt import Bcrypt
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from fpdf import FPDF
from transformers import pipeline
import os
import time

app = Flask(__name__)
app.secret_key = "supersecretkey"

# MySQL Database Config
db_config = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "ai_qna"
}

# Load the trained SBERT model
model_path = "sbert_finetuned"  # Update this if your model is saved elsewhere
sbert_model = SentenceTransformer(model_path)

bcrypt = Bcrypt(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "login"

class User(UserMixin):
    def __init__(self, id, username, email):
        self.id = id
        self.username = username
        self.email = email

@login_manager.user_loader
def load_user(user_id):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.execute("SELECT id, username, email FROM users WHERE id = %s", (user_id,))
    user_data = cursor.fetchone()
    conn.close()
    return User(user_data[0], user_data[1], user_data[2]) if user_data else None

# Home Route
@app.route("/")
def home():
    return render_template("index.html")

# Signup Route
@app.route("/signup", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        username = request.form["username"]
        email = request.form["email"]
        password = request.form["password"]
        hashed_password = bcrypt.generate_password_hash(password).decode("utf-8")

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        try:
            cursor.execute("INSERT INTO users (username, email, password) VALUES (%s, %s, %s)",
                           (username, email, hashed_password))
            conn.commit()
            flash("Signup successful! You can now login.", "success")
            return redirect(url_for("login"))
        except mysql.connector.IntegrityError:
            flash("Email already exists!", "danger")
        finally:
            conn.close()

    return render_template("signup.html")

# User Login Route
@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute("SELECT id, username, email, password FROM users WHERE email = %s", (email,))
        user_data = cursor.fetchone()
        conn.close()

        if user_data and bcrypt.check_password_hash(user_data[3], password):
            session["user_id"] = user_data[0]   # Store user ID in session
            session["username"] = user_data[1]  # Store username in session
            flash("Login successful!", "success")
            return redirect(url_for("dashboard"))
        else:
            flash("Invalid email or password!", "danger")

    return render_template("login.html")

# Dashboard Route
@app.route("/dashboard")
def dashboard():
    if "user_id" not in session:
        flash("Unauthorized access!", "danger")
        return redirect(url_for("login"))

    user_id = session["user_id"]

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch total score for each test attempt
    cursor.execute("""
        SELECT SUM(score) AS total_score, DATE(test_date) 
        FROM mock_tests 
        WHERE user_id = %s 
        GROUP BY DATE(test_date) 
        ORDER BY test_date DESC
    """, (user_id,))

    scores = cursor.fetchall()  # Fetch results as a list of tuples
    conn.close()

    return render_template("dashboard.html", username=session["username"], scores=scores)


# Logout Route
@app.route("/logout")
def user_logout():
    session.pop("user_id", None)
    session.pop("username", None)
    flash("User logged out successfully!", "success")
    return redirect(url_for("login"))

# Route to start the mock test setup
@app.route("/mock_test", methods=["GET", "POST"])
def mock_test():
    # Ensure user is logged in
    if "user_id" not in session:
        flash("Unauthorized access! Please log in.", "danger")
        return redirect(url_for("login"))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Get available categories
    cursor.execute("SELECT DISTINCT category FROM questions")
    categories = [row[0] for row in cursor.fetchall()]
    conn.close()

    if request.method == "POST":
        selected_categories = request.form.getlist("categories")
        num_questions = int(request.form["num_questions"])

        # Store selections in session
        session["mock_test_categories"] = selected_categories
        session["mock_test_num_questions"] = num_questions

        return redirect(url_for("start_mock_test"))

    return render_template("mock_test.html", categories=categories)


# Route to start the mock test
@app.route("/start_mock_test")
def start_mock_test():
    # Ensure user is logged in
    if "user_id" not in session:
        flash("Unauthorized access! Please log in.", "danger")
        return redirect(url_for("login"))
    
    selected_categories = session.get("mock_test_categories", [])
    num_questions = session.get("mock_test_num_questions", 10)

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch random questions based on category selection
    placeholders = ", ".join(["%s"] * len(selected_categories))
    cursor.execute(f"""
        SELECT id, question, answer FROM questions 
        WHERE category IN ({placeholders}) 
        ORDER BY RAND() 
        LIMIT %s
    """, (*selected_categories, num_questions))

    questions = cursor.fetchall()
    conn.close()

    # Store questions in session
    session["mock_test_questions"] = [{"id": q[0], "question": q[1], "answer": q[2]} for q in questions]

    return render_template("start_mock_test.html", questions=session["mock_test_questions"])

# Route to submit the mock test
@app.route("/submit_mock_test", methods=["POST"])
def submit_mock_test():
    # Ensure user is logged in
    if "user_id" not in session:
        flash("Unauthorized access! Please log in.", "danger")
        return redirect(url_for("login"))

    user_id = session["user_id"]
    user_answers = request.form

    # Ensure mock test session data exists
    if "mock_test_questions" not in session or "mock_test_categories" not in session:
        flash("Mock test session expired. Please restart the test.", "warning")
        return redirect(url_for("mock_test"))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    total_score = 0

    for q_id, user_answer in user_answers.items():
        question = next(q for q in session["mock_test_questions"] if str(q["id"]) == q_id)
        correct_answer = question["answer"]

        # Compute similarity score using SBERT
        user_embedding = sbert_model.encode(user_answer, convert_to_tensor=True)
        correct_embedding = sbert_model.encode(correct_answer, convert_to_tensor=True)
        similarity_score = util.pytorch_cos_sim(user_embedding, correct_embedding).item()  # Cosine similarity

        # Normalize similarity score (0 to 1)
        score = round(similarity_score, 2)
        total_score += score

        # Store results in database
        cursor.execute("""
            INSERT INTO mock_tests (user_id, category, question, answer, user_answer, score, test_date)
            VALUES (%s, %s, %s, %s, %s, %s, NOW())
        """, (user_id, session["mock_test_categories"][0], question["question"], correct_answer, user_answer, score))

    conn.commit()
    conn.close()

    flash(f"Mock test submitted! Your score: {total_score}/{len(user_answers)}", "success")
    return redirect(url_for("dashboard"))

@app.route("/history")
def history():
    # Ensure user is logged in
    if "user_id" not in session:
        flash("Unauthorized access! Please log in.", "danger")
        return redirect(url_for("login"))

    user_id = session["user_id"]
    username = session.get("username", "User")  # Default to "User" if not found

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch detailed history of all test attempts
    cursor.execute("""
        SELECT category, question, answer, user_answer, score, test_date
        FROM mock_tests
        WHERE user_id = %s
        ORDER BY test_date DESC
    """, (user_id,))

    history_data = cursor.fetchall()
    conn.close()

    return render_template("history.html", username=username, history_data=history_data)

@app.route("/marks_history")
def markshistory():
    # Ensure user is logged in
    if "user_id" not in session:
        flash("Unauthorized access! Please log in.", "danger")
        return redirect(url_for("login"))

    user_id = session["user_id"]
    username = session.get("username", "User")  # Default to "User" if not found

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch history grouped by test date
    cursor.execute("""
        SELECT 
            DATE(test_date) AS test_date, 
            COALESCE(SUM(score), 0) AS total_score
        FROM 
            mock_tests
        WHERE 
            user_id = %s
        GROUP BY 
            DATE(test_date)
        ORDER BY 
            test_date DESC
    """, (user_id,))

    history_data = cursor.fetchall()
    conn.close()

    # Format the data for rendering
    formatted_history = [
        {"test_date": row[0].strftime("%Y-%m-%d"), "total_score": row[1] or 0} 
        for row in history_data
    ]

    return render_template("marks_history.html", username=username, history_data=formatted_history)


@app.route('/resume_1')
def resume_1():
    return render_template("resume_1.html")

@app.route('/resume_2')
def resume_2():
    return render_template("resume_2.html")

@app.route('/resume_template')
def resume_template():
    return render_template("resume_template.html")


##########################################

bcrypt = Bcrypt(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "admin_login"

class Admin(UserMixin):
    def __init__(self, id, username, email):
        self.id = id
        self.username = username
        self.email = email

@login_manager.user_loader
def load_user(user_id):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Check if the user is an admin
    cursor.execute("SELECT id, username, email FROM admins WHERE id = %s", (user_id,))
    admin_data = cursor.fetchone()

    if admin_data:
        conn.close()
        return Admin(admin_data[0], admin_data[1], admin_data[2])

    # If not an admin, check if it's a regular user
    cursor.execute("SELECT id, username, email FROM users WHERE id = %s", (user_id,))
    user_data = cursor.fetchone()
    conn.close()

    if user_data:
        return User(user_data[0], user_data[1], user_data[2])

    return None


# Admin Signup Route
@app.route("/admin/signup", methods=["GET", "POST"])
def admin_signup():
    if request.method == "POST":
        username = request.form["username"]
        email = request.form["email"]
        password = request.form["password"]
        hashed_password = bcrypt.generate_password_hash(password).decode("utf-8")

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        try:
            cursor.execute("INSERT INTO admins (username, email, password) VALUES (%s, %s, %s)",
                           (username, email, hashed_password))
            conn.commit()
            flash("Admin signup successful! You can now login.", "success")
            return redirect(url_for("admin_login"))
        except mysql.connector.IntegrityError:
            flash("Email already exists!", "danger")
        finally:
            conn.close()

    return render_template("admin_signup.html")

# Admin Login Route
from flask import session  # Import session module

@app.route("/admin/login", methods=["GET", "POST"])
def admin_login():
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute("SELECT id, username, email, password FROM admins WHERE email = %s", (email,))
        admin_data = cursor.fetchone()
        conn.close()

        if admin_data and bcrypt.check_password_hash(admin_data[3], password):
            session["admin_id"] = admin_data[0]  # Store separate admin session
            session["admin_username"] = admin_data[1]  # Store admin name
            flash("Admin login successful!", "success")
            return redirect(url_for("admin_dashboard"))
        else:
            flash("Invalid email or password!", "danger")

    return render_template("admin_login.html")


# Admin Dashboard Route
@app.route("/admin/dashboard")
def admin_dashboard():
    if "admin_id" not in session:
        flash("Unauthorized access!", "danger")
        return redirect(url_for("admin_login"))

    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Fetch total count of users
        cursor.execute("SELECT COUNT(*) FROM users")
        total_users = cursor.fetchone()

        if total_users is None:
            flash("Error fetching total users count!", "danger")
            return redirect(url_for("admin_dashboard"))

        total_users = total_users[0]

        print("Total Users:", total_users)

        conn.close()

        return render_template("admin_dashboard.html", username=session["admin_username"], total_users=total_users)

    except mysql.connector.Error as err:
        flash("Error connecting to database: {}".format(err), "danger")
        return redirect(url_for("admin_dashboard"))
# Admin Logout
@app.route("/admin/logout")
def admin_logout():
    session.pop("admin_id", None)
    session.pop("admin_username", None)
    flash("Admin logged out successfully!", "success")
    return redirect(url_for("admin_login"))


#################################################

@app.route("/admin/assign_meeting", methods=["GET", "POST"])
def assign_meeting():
    # Ensure only admin can access
    if "admin_id" not in session:
        flash("Unauthorized access!", "danger")
        return redirect(url_for("admin_login"))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch all users
    cursor.execute("SELECT id, username FROM users")
    users = cursor.fetchall()

    if request.method == "POST":
        user_ids = request.form.getlist("user_ids")  # List of selected user IDs
        meet_link = request.form["meet_link"]
        meet_date = request.form["meet_date"]
        meet_time = request.form["meet_time"]

        # Insert meeting for each selected user
        for user_id in user_ids:
            cursor.execute(
                "INSERT INTO meetings (user_id, meet_link, meet_date, meet_time) VALUES (%s, %s, %s, %s)",
                (user_id, meet_link, meet_date, meet_time)
            )

        conn.commit()
        conn.close()

        flash("Meeting assigned successfully!", "success")
        return redirect(url_for("admin_dashboard"))

    conn.close()
    return render_template("assign_meeting.html", users=users)

@app.route("/meetings")
def user_meetings():
    # Ensure user is logged in
    if "user_id" not in session:
        flash("Unauthorized access! Please log in.", "danger")
        return redirect(url_for("login"))

    user_id = session["user_id"]
    username = session.get("username", "User")  # Fetch username from session

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch meetings assigned to the logged-in user
    cursor.execute("""
        SELECT meet_link, meet_date, meet_time FROM meetings WHERE user_id = %s ORDER BY meet_date DESC
    """, (user_id,))

    meetings = cursor.fetchall()
    conn.close()

    return render_template("user_meetings.html", username=username, meetings=meetings)


@app.route("/admin/scheduled_meetings")
def scheduled_meetings():
    # Ensure only admin can access
    if "admin_id" not in session:
        flash("Unauthorized access!", "danger")
        return redirect(url_for("admin_login"))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch all scheduled meetings with user details
    cursor.execute("""
        SELECT u.username, m.meet_link, m.meet_date, m.meet_time 
        FROM meetings m
        JOIN users u ON m.user_id = u.id
        ORDER BY m.meet_date DESC
    """)

    meetings = cursor.fetchall()
    conn.close()

    return render_template("scheduled_meetings.html", meetings=meetings)

############################################################

UPLOAD_FOLDER = "uploads/videos"
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

# Ensure the upload folder exists
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# Serve uploaded videos
@app.route("/uploads/videos/<filename>")
def uploaded_video(filename):
    return send_from_directory(app.config["UPLOAD_FOLDER"], filename)

# User Video Submission Route
@app.route("/record_video", methods=["GET", "POST"])
def record_video():
    if "user_id" not in session:
        flash("Unauthorized access! Please log in.", "danger")
        return redirect(url_for("login"))

    if request.method == "POST":
        if "video" not in request.files:
            flash("No video uploaded!", "danger")
            return redirect(request.url)

        video_file = request.files["video"]
        if video_file.filename == "":
            flash("No selected file!", "danger")
            return redirect(request.url)

        if video_file:
            user_id = session["user_id"]
            filename = f"{user_id}_{int(time.time())}.webm"
            video_path = os.path.join(app.config["UPLOAD_FOLDER"], filename)
            video_file.save(video_path)

            # Save the video info in the database
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()
            cursor.execute(
                "INSERT INTO user_videos (user_id, video_path, upload_time) VALUES (%s, %s, NOW())",
                (user_id, filename),
            )
            conn.commit()
            conn.close()

            flash("Video uploaded successfully!", "success")
            return redirect(url_for("user_meetings"))

    return render_template("record_video.html")

@app.route("/admin/videos")
def admin_videos():
    if "admin_id" not in session:
        flash("Unauthorized access! Please log in as admin.", "danger")
        return redirect(url_for("admin_login"))

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    # Fetch all uploaded videos
    cursor.execute("""
        SELECT user_videos.id, users.username, user_videos.video_path, user_videos.upload_time
        FROM user_videos 
        JOIN users ON user_videos.user_id = users.id
        ORDER BY user_videos.upload_time DESC
    """)
    
    videos = cursor.fetchall()
    conn.close()

    return render_template("admin_videos.html", videos=videos)




if __name__ == "__main__":
    app.run(debug=True)
