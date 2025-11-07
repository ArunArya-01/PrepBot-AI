import mysql.connector
import csv

# Database connection
db_config = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "ai_qna"
}

def insert_questions():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    with open("ml_trainingques.csv", "r") as file:
        reader = csv.reader(file)
        next(reader)  # Skip header

        for row in reader:
            category, question, answer, score = row
            cursor.execute("""
                INSERT INTO questions (category, question, answer, score)
                VALUES (%s, %s, %s, %s)
            """, (category, question, answer, float(score)))

    conn.commit()
    conn.close()
    print("Data inserted successfully!")

if __name__ == "__main__":
    insert_questions()
