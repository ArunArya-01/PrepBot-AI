# PrepBoat: Smart AI Interview Preparation Platform

PrepBoat is a comprehensive platform where users can prepare for interviews. It features an advanced AI mock interview system that evaluates descriptive answers, a live interview module, video analysis, and robust user tracking.

## ✨ Features

* **AI Mock Interview:**
    * Practice with descriptive (non-MCQ) questions.
    * Select topics like Cloud Computing, Java, CSS, Full Stack, etc.
    * Choose difficulty levels (Basic, Intermediate, Advanced) which adjust the number of questions, time limit, and scoring.
    * Answers are evaluated by an AI using the SentenceBERT algorithm to provide a detailed score.
* **Live Interview Practice:** Admins can schedule and assign live interviews to users.
* **Video Analysis:** Users can upload a video of themselves, which an admin can review and provide feedback on.
* **User Dashboard:** Track scores, review history, and submit feedback.
* **(In Progress):** Resume Builder feature is planned for a future release.

---

## 🚀 How to Run This Project

This project uses a Python (Flask) backend and a MySQL database.

### Prerequisites

* [**XAMPP**](https://www.apachefriends.org/index.html) (or any MySQL server)
* [**Python 3.8+**](https://www.python.org/)

### Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone [your-repo-url]
    ```

2.  **Move the project:**
    Move the cloned folder (named `Final`) to your desired location.

3.  **Start MySQL:**
    Open your XAMPP control panel and start the **MySQL** service. (You *do not* need Apache).

4.  **Import the Database:**
    * Go to `http://localhost/phpmyadmin`.
    * Create a new database. Name it **`ai_qna`**.
    * Click on the new `ai_qna` database you just created.
    * Click the **"Import"** tab.
    * Choose the **`ai_qna.sql`** file (included in this repository) and click "Go".

5.  **Create a Virtual Environment:**
    Open a terminal in the `Final` project folder and run:
    ```bash
    # Create the virtual environment
    python -m venv venv
    
    # Activate the environment
    # On Windows:
    .\venv\Scripts\activate
    # On macOS/Linux:
    source venv/bin/activate
    ```

6.  **Install Dependencies:**
    With your virtual environment active, install all required packages:
    ```bash
    pip install -r requirements.txt
    ```

7.  **Run the project:**
    Run the main Flask application:
    ```bash
    python app.py
    ```

8.  **View the App:**
    Open your browser and go to:
    **`http://127.0.0.1:5000/`**