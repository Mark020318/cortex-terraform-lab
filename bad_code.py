import os
import sqlite3
from flask import Flask, request

app = Flask(__name__)

@app.route('/ping')
def ping():
    # 觸發 Code Weaknesses: OS Command Injection
    target = request.args.get('target')
    os.system("ping -c 1 " + target) 
    return "Ping executed"

@app.route('/user')
def get_user():
    # 觸發 Code Weaknesses: SQL Injection
    user_id = request.args.get('id')
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE id = '" + user_id + "'")
    return str(cursor.fetchall())
