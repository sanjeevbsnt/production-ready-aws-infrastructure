from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def home():
    # Demonstrating secret retrieval from environment (injected via ECS)
    db_pass = os.getenv('DB_PASSWORD', 'NOT_SET')
    return {
        "status": "healthy",
        "secret_loaded": db_pass != 'NOT_SET'
    }

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)