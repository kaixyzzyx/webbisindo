from flask import Flask, render_template, request, jsonify, session, redirect, url_for, Response
import cv2
from ultralytics import YOLO
import mysql.connector
from mysql.connector import Error
import hashlib
import os
from datetime import datetime
import json
import base64
import numpy as np
from config import Config
from functools import wraps
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__, template_folder='app/templates', static_folder='app/static')
app.secret_key = Config.SECRET_KEY

# Decorators for role-based access
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('landing'))
        return f(*args, **kwargs)
    return decorated_function

def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('landing'))
        if session.get('role') != 'admin':
            return redirect(url_for('index'))
        return f(*args, **kwargs)
    return decorated_function

# Load YOLO Models
model_huruf = YOLO("besthuruf.pt")
model_kata = YOLO("bestkata.pt")

# Database connection
def get_db_connection():
    try:
        connection = mysql.connector.connect(**Config.get_db_config())
        return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

# Database initialization
def init_db():
    try:
        connection = get_db_connection()
        if connection is None:
            return False
            
        cursor = connection.cursor()
        
        # Create database if not exists
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS {Config.MYSQL_DB}")
        cursor.execute(f"USE {Config.MYSQL_DB}")
        
        # Users table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS users (
                id INT AUTO_INCREMENT PRIMARY KEY,
                username VARCHAR(50) UNIQUE NOT NULL,
                email VARCHAR(100) UNIQUE NOT NULL,
                password VARCHAR(255) NOT NULL,
                role VARCHAR(20) DEFAULT 'user',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Learning materials table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS materials (
                id INT AUTO_INCREMENT PRIMARY KEY,
                type VARCHAR(50) NOT NULL,
                title VARCHAR(200) NOT NULL,
                content TEXT,
                image_path VARCHAR(255),
                video_path VARCHAR(255),
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Practice results table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS practice_results (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT,
                practice_type VARCHAR(50) NOT NULL,
                target_gesture VARCHAR(100) NOT NULL,
                accuracy DECIMAL(5,2),
                completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
            )
        ''')
        
        # Quiz questions table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS quiz_questions (
                id INT AUTO_INCREMENT PRIMARY KEY,
                type VARCHAR(50) NOT NULL,
                question TEXT NOT NULL,
                answer TEXT NOT NULL,
                difficulty VARCHAR(20) DEFAULT 'mudah',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Quiz results table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS quiz_results (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT,
                quiz_id INT,
                user_answer TEXT,
                is_correct BOOLEAN,
                time_taken INT,
                completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
                FOREIGN KEY (quiz_id) REFERENCES quiz_questions (id) ON DELETE CASCADE
            )
        ''')
        
        connection.commit()
        cursor.close()
        connection.close()
        return True
        
    except Error as e:
        print(f"Error initializing database: {e}")
        return False

# Routes
@app.route('/')
def landing():
    return render_template('landing.html')

@app.route('/home')
@login_required
def index():
    return render_template('index.html')

@app.route('/test-db')
def test_db():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('SELECT 1')
            result = cursor.fetchone()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Database connected'})
        else:
            return jsonify({'success': False, 'message': 'Cannot connect to database'})
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = hashlib.md5(request.form['password'].encode()).hexdigest()
    
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM users WHERE username = %s AND password = %s', (username, password))
            user = cursor.fetchone()
            cursor.close()
            connection.close()
            
            if user:
                session['user_id'] = user[0]
                session['username'] = user[1]
                session['role'] = user[4]
                
                redirect_url = url_for('dashboard') if user[4] == 'admin' else url_for('index')
                return jsonify({
                    'success': True,
                    'message': 'Login berhasil',
                    'redirect': redirect_url
                })
            else:
                return jsonify({
                    'success': False,
                    'message': 'Username atau password salah'
                })
        else:
            return jsonify({
                'success': False,
                'message': 'Database connection error'
            })
    except Error as e:
        return jsonify({
            'success': False,
            'message': f'Login error: {str(e)}'
        })

@app.route('/register', methods=['POST'])
def register():
    username = request.form['username']
    email = request.form['email']
    password = hashlib.md5(request.form['password'].encode()).hexdigest()
    
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('INSERT INTO users (username, email, password) VALUES (%s, %s, %s)', 
                         (username, email, password))
            connection.commit()
            cursor.close()
            connection.close()
            
            return jsonify({
                'success': True,
                'message': 'Registrasi berhasil'
            })
    except mysql.connector.IntegrityError:
        return jsonify({
            'success': False,
            'message': 'Username atau email sudah terdaftar'
        })
    except Error as e:
        return jsonify({
            'success': False,
            'message': f'Registration error: {str(e)}'
        })

@app.route('/dashboard')
@login_required
def dashboard():
    if session.get('role') == 'admin':
        return render_template('admin_dashboard.html')
    else:
        return redirect(url_for('index'))

@app.route('/admin/dashboard')
@admin_required
def admin_dashboard():
    return render_template('admin_dashboard.html')

@app.route('/admin/materials')
@admin_required
def admin_materials():
    return render_template('admin_materials.html')

@app.route('/admin/materials/alphabet')
@admin_required
def admin_materials_alphabet():
    return render_template('admin_materials_alphabet.html')

@app.route('/admin/materials/vocabulary')
@admin_required
def admin_materials_vocabulary():
    return render_template('admin_materials_vocabulary.html')

@app.route('/admin/quiz')
@admin_required
def admin_quiz():
    return render_template('admin_quiz.html')

@app.route('/admin/quiz/alphabet')
@admin_required
def admin_quiz_alphabet():
    return render_template('admin_quiz_alphabet.html')

@app.route('/admin/quiz/vocabulary')
@admin_required
def admin_quiz_vocabulary():
    return render_template('admin_quiz_vocabulary.html')



@app.route('/history')
@login_required
def history():
    return render_template('dashboard.html')

@app.route('/learning/alphabet')
@login_required
def learning_alphabet():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM materials WHERE type = 'alphabet' ORDER BY title")
            materials = cursor.fetchall()
            cursor.close()
            connection.close()
            return render_template('learning_alphabet.html', materials=materials)
    except Error as e:
        print(f"Error: {e}")
    return render_template('learning_alphabet.html', materials=[])

@app.route('/learning/vocabulary')
@login_required
def learning_vocabulary():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM materials WHERE type = 'vocabulary' ORDER BY title")
            materials = cursor.fetchall()
            cursor.close()
            connection.close()
            return render_template('learning_vocabulary.html', materials=materials)
    except Error as e:
        print(f"Error: {e}")
    return render_template('learning_vocabulary.html', materials=[])

@app.route('/practice/alphabet')
@login_required
def practice_alphabet():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM materials WHERE type = 'alphabet' ORDER BY title")
            materials = cursor.fetchall()
            cursor.close()
            connection.close()
            return render_template('practice_alphabet.html', materials=materials)
    except Error as e:
        print(f"Error: {e}")
    return render_template('practice_alphabet.html', materials=[])

@app.route('/practice/vocabulary')
def practice_vocabulary():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM materials WHERE type = 'vocabulary' ORDER BY title")
            materials = cursor.fetchall()
            cursor.close()
            connection.close()
            return render_template('practice_vocabulary.html', materials=materials)
    except Error as e:
        print(f"Error: {e}")
    return render_template('practice_vocabulary.html', materials=[])



@app.route('/practice/quiz/alphabet')
@login_required
def practice_quiz_alphabet():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM quiz_questions WHERE type = 'alphabet' ORDER BY difficulty, question")
            questions = cursor.fetchall()
            
            # Get completed quiz IDs for current user
            cursor.execute("SELECT DISTINCT quiz_id FROM quiz_results WHERE user_id = %s", (session['user_id'],))
            completed = [row[0] for row in cursor.fetchall()]
            
            cursor.close()
            connection.close()
            return render_template('practice_quiz_alphabet_select.html', questions=questions, completed=completed)
    except Error as e:
        print(f"Error: {e}")
    return render_template('practice_quiz_alphabet_select.html', questions=[], completed=[])

@app.route('/practice/quiz/alphabet/start', methods=['POST'])
@login_required
def practice_quiz_alphabet_start():
    selected_ids = request.form.getlist('quiz_ids')
    if not selected_ids:
        return redirect(url_for('practice_quiz_alphabet'))
    
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            placeholders = ','.join(['%s'] * len(selected_ids))
            cursor.execute(f"SELECT * FROM quiz_questions WHERE id IN ({placeholders})", selected_ids)
            questions = cursor.fetchall()
            cursor.close()
            connection.close()
            return render_template('practice_quiz_alphabet.html', questions=questions)
    except Error as e:
        print(f"Error: {e}")
    return redirect(url_for('practice_quiz_alphabet'))

@app.route('/practice/quiz/vocabulary')
@login_required
def practice_quiz_vocabulary():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM quiz_questions WHERE type = 'vocabulary' ORDER BY difficulty, question")
            questions = cursor.fetchall()
            
            # Get completed quiz IDs for current user
            cursor.execute("SELECT DISTINCT quiz_id FROM quiz_results WHERE user_id = %s", (session['user_id'],))
            completed = [row[0] for row in cursor.fetchall()]
            
            cursor.close()
            connection.close()
            return render_template('practice_quiz_vocabulary_select.html', questions=questions, completed=completed)
    except Error as e:
        print(f"Error: {e}")
    return render_template('practice_quiz_vocabulary_select.html', questions=[], completed=[])

@app.route('/practice/quiz/vocabulary/start', methods=['POST'])
@login_required
def practice_quiz_vocabulary_start():
    selected_ids = request.form.getlist('quiz_ids')
    if not selected_ids:
        return redirect(url_for('practice_quiz_vocabulary'))
    
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            placeholders = ','.join(['%s'] * len(selected_ids))
            cursor.execute(f"SELECT * FROM quiz_questions WHERE id IN ({placeholders})", selected_ids)
            questions = cursor.fetchall()
            cursor.close()
            connection.close()
            return render_template('practice_quiz_vocabulary.html', questions=questions)
    except Error as e:
        print(f"Error: {e}")
    return redirect(url_for('practice_quiz_vocabulary'))

@app.route('/video_feed')
def video_feed():
    return Response(generate_frames_realtime(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/video_feed_vocabulary')
def video_feed_vocabulary():
    return Response(generate_frames_vocabulary(), mimetype='multipart/x-mixed-replace; boundary=frame')

def generate_frames_realtime():
    cap = cv2.VideoCapture(0)
    
    while True:
        ret, frame = cap.read()
        if not ret:
            break
        
        # YOLO prediction using huruf model
        results = model_huruf.predict(source=frame, conf=0.25, imgsz=640, verbose=False)
        annotated_frame = results[0].plot()
        
        # Extract detection info and add to frame
        detections = []
        if len(results[0].boxes) > 0:
            for box in results[0].boxes:
                class_id = int(box.cls[0])
                confidence = float(box.conf[0])
                class_name = model_huruf.names[class_id]
                detections.append({'class': class_name, 'confidence': confidence})
        
        # Encode frame with detection data
        ret, buffer = cv2.imencode('.jpg', annotated_frame)
        frame_bytes = buffer.tobytes()
        
        # Send frame with detection metadata
        detection_json = json.dumps(detections)
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n'
               b'X-Detections: ' + detection_json.encode() + b'\r\n\r\n' + frame_bytes + b'\r\n')

def generate_frames_vocabulary():
    cap = cv2.VideoCapture(0)
    
    while True:
        ret, frame = cap.read()
        if not ret:
            break
        
        # YOLO prediction using kata model
        results = model_kata.predict(source=frame, conf=0.25, imgsz=640, verbose=False)
        annotated_frame = results[0].plot()
        
        # Extract detection info and add to frame
        detections = []
        if len(results[0].boxes) > 0:
            for box in results[0].boxes:
                class_id = int(box.cls[0])
                confidence = float(box.conf[0])
                class_name = model_kata.names[class_id]
                detections.append({'class': class_name, 'confidence': confidence})
        
        # Encode frame with detection data
        ret, buffer = cv2.imencode('.jpg', annotated_frame)
        frame_bytes = buffer.tobytes()
        
        # Send frame with detection metadata
        detection_json = json.dumps(detections)
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n'
               b'X-Detections: ' + detection_json.encode() + b'\r\n\r\n' + frame_bytes + b'\r\n')

@app.route('/detect_gesture', methods=['POST'])
def detect_gesture():
    try:
        # Get image data and detection type from request
        image_data = request.json['image']
        detection_type = request.json.get('type', 'alphabet')  # default to alphabet
        
        # Decode base64 image
        image_data = image_data.split(',')[1]
        image_bytes = base64.b64decode(image_data)
        nparr = np.frombuffer(image_bytes, np.uint8)
        frame = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        
        # Select model based on type
        model = model_huruf if detection_type == 'alphabet' else model_kata
        
        # YOLO prediction
        results = model.predict(source=frame, conf=0.25, imgsz=640, verbose=False)
        
        # Extract detection results
        detections = []
        if len(results[0].boxes) > 0:
            for box in results[0].boxes:
                class_id = int(box.cls[0])
                confidence = float(box.conf[0])
                class_name = model.names[class_id]
                
                detections.append({
                    'class': class_name,
                    'confidence': confidence
                })
        
        return jsonify({
            'success': True,
            'detections': detections
        })
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        })

# Admin API Endpoints
@app.route('/api/admin/materials', methods=['GET'])
@admin_required
def get_materials():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            
            # Check if type filter is provided
            material_type = request.args.get('type')
            if material_type:
                cursor.execute('SELECT * FROM materials WHERE type = %s ORDER BY created_at DESC', (material_type,))
            else:
                cursor.execute('SELECT * FROM materials ORDER BY created_at DESC')
                
            materials = cursor.fetchall()
            cursor.close()
            connection.close()
            
            materials_list = []
            for m in materials:
                materials_list.append({
                    'id': m[0],
                    'type': m[1],
                    'title': m[2],
                    'content': m[3],
                    'image_path': m[4],
                    'video_path': m[5],
                    'created_at': str(m[6])
                })
            
            return jsonify({'success': True, 'materials': materials_list})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/materials', methods=['POST'])
@admin_required
def add_material():
    try:
        data = request.json
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute(
                'INSERT INTO materials (type, title, content, image_path, video_path) VALUES (%s, %s, %s, %s, %s)',
                (data['type'], data['title'], data.get('content', ''), data.get('image_path', ''), data.get('video_path', ''))
            )
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Material added successfully'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/materials/<int:material_id>', methods=['PUT'])
@admin_required
def update_material(material_id):
    try:
        data = request.json
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute(
                'UPDATE materials SET type=%s, title=%s, content=%s, image_path=%s, video_path=%s WHERE id=%s',
                (data['type'], data['title'], data.get('content', ''), data.get('image_path', ''), data.get('video_path', ''), material_id)
            )
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Material updated successfully'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/materials/<int:material_id>', methods=['GET'])
@admin_required
def get_material(material_id):
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM materials WHERE id=%s', (material_id,))
            material = cursor.fetchone()
            cursor.close()
            connection.close()
            
            if material:
                return jsonify({
                    'success': True,
                    'material': {
                        'id': material[0],
                        'type': material[1],
                        'title': material[2],
                        'content': material[3],
                        'image_path': material[4],
                        'video_path': material[5]
                    }
                })
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/upload_image', methods=['POST'])
@admin_required
def upload_image():
    try:
        if 'image' not in request.files:
            return jsonify({'success': False, 'error': 'No image file'})
        
        file = request.files['image']
        if file.filename == '':
            return jsonify({'success': False, 'error': 'No selected file'})
        
        # Create uploads directory if not exists
        upload_folder = 'app/static/uploads'
        if not os.path.exists(upload_folder):
            os.makedirs(upload_folder)
        
        # Save file with unique name
        filename = f"{datetime.now().strftime('%Y%m%d%H%M%S')}_{file.filename}"
        filepath = os.path.join(upload_folder, filename)
        file.save(filepath)
        
        # Return relative path for database
        return jsonify({
            'success': True,
            'image_path': f'/static/uploads/{filename}'
        })
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/materials/<int:material_id>', methods=['DELETE'])
@admin_required
def delete_material(material_id):
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('DELETE FROM materials WHERE id=%s', (material_id,))
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Material deleted successfully'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/users', methods=['POST'])
@admin_required
def add_user():
    try:
        data = request.json
        password = hashlib.md5(data['password'].encode()).hexdigest()
        
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute(
                'INSERT INTO users (username, email, password, role) VALUES (%s, %s, %s, %s)',
                (data['username'], data['email'], password, data['role'])
            )
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'User added successfully'})
    except mysql.connector.IntegrityError:
        return jsonify({'success': False, 'error': 'Username atau email sudah terdaftar'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/users', methods=['GET'])
@admin_required
def get_users():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('SELECT id, username, email, role, created_at FROM users ORDER BY created_at DESC')
            users = cursor.fetchall()
            cursor.close()
            connection.close()
            
            users_list = []
            for u in users:
                users_list.append({
                    'id': u[0],
                    'username': u[1],
                    'email': u[2],
                    'role': u[3],
                    'created_at': str(u[4])
                })
            
            return jsonify({'success': True, 'users': users_list})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/users/<int:user_id>', methods=['GET'])
@admin_required
def get_user(user_id):
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('SELECT id, username, email, role FROM users WHERE id=%s', (user_id,))
            user = cursor.fetchone()
            cursor.close()
            connection.close()
            
            if user:
                return jsonify({
                    'success': True,
                    'user': {
                        'id': user[0],
                        'username': user[1],
                        'email': user[2],
                        'role': user[3]
                    }
                })
            else:
                return jsonify({'success': False, 'error': 'User not found'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/users/<int:user_id>', methods=['PUT'])
@admin_required
def update_user(user_id):
    try:
        data = request.json
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            
            # Check if updating password
            if 'password' in data and data['password']:
                password = hashlib.md5(data['password'].encode()).hexdigest()
                cursor.execute(
                    'UPDATE users SET username=%s, email=%s, password=%s, role=%s WHERE id=%s',
                    (data['username'], data['email'], password, data['role'], user_id)
                )
            else:
                cursor.execute(
                    'UPDATE users SET username=%s, email=%s, role=%s WHERE id=%s',
                    (data['username'], data['email'], data['role'], user_id)
                )
            
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'User updated successfully'})
    except mysql.connector.IntegrityError:
        return jsonify({'success': False, 'error': 'Username atau email sudah terdaftar'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/users/<int:user_id>', methods=['DELETE'])
@admin_required
def delete_user(user_id):
    try:
        # Prevent admin from deleting themselves
        if user_id == session['user_id']:
            return jsonify({'success': False, 'error': 'Tidak dapat menghapus akun sendiri'})
            
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('DELETE FROM users WHERE id=%s', (user_id,))
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'User deleted successfully'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/quiz', methods=['GET'])
@admin_required
def get_quiz_questions():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            
            # Check if type filter is provided
            quiz_type = request.args.get('type')
            if quiz_type:
                cursor.execute('SELECT * FROM quiz_questions WHERE type = %s ORDER BY created_at DESC', (quiz_type,))
            else:
                cursor.execute('SELECT * FROM quiz_questions ORDER BY created_at DESC')
                
            questions = cursor.fetchall()
            cursor.close()
            connection.close()
            
            questions_list = []
            for q in questions:
                questions_list.append({
                    'id': q[0],
                    'type': q[1],
                    'question': q[2],
                    'answer': q[3],
                    'difficulty': q[4],
                    'created_at': str(q[5])
                })
            
            return jsonify({'success': True, 'quiz': questions_list})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/quiz', methods=['POST'])
@admin_required
def add_quiz_question():
    try:
        data = request.json
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute(
                'INSERT INTO quiz_questions (type, question, answer, difficulty) VALUES (%s, %s, %s, %s)',
                (data['type'], data['question'], data['answer'], data.get('difficulty', 'mudah'))
            )
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Question added successfully'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/quiz/<int:quiz_id>', methods=['GET'])
@admin_required
def get_quiz_question(quiz_id):
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM quiz_questions WHERE id=%s', (quiz_id,))
            question = cursor.fetchone()
            cursor.close()
            connection.close()
            
            if question:
                return jsonify({
                    'success': True,
                    'quiz': {
                        'id': question[0],
                        'type': question[1],
                        'question': question[2],
                        'answer': question[3],
                        'difficulty': question[4]
                    }
                })
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/quiz/<int:quiz_id>', methods=['PUT'])
@admin_required
def update_quiz_question(quiz_id):
    try:
        data = request.json
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute(
                'UPDATE quiz_questions SET type=%s, question=%s, answer=%s, difficulty=%s WHERE id=%s',
                (data['type'], data['question'], data['answer'], data.get('difficulty', 'mudah'), quiz_id)
            )
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Question updated successfully'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/quiz/<int:quiz_id>', methods=['DELETE'])
@admin_required
def delete_quiz_question(quiz_id):
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute('DELETE FROM quiz_questions WHERE id=%s', (quiz_id,))
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Question deleted successfully'})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/quiz/submit', methods=['POST'])
@login_required
def submit_quiz_answer():
    try:
        data = request.json
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute(
                'INSERT INTO quiz_results (user_id, quiz_id, user_answer, is_correct, time_taken) VALUES (%s, %s, %s, %s, %s)',
                (session['user_id'], data['quiz_id'], data['user_answer'], data['is_correct'], data['time_taken'])
            )
            connection.commit()
            cursor.close()
            connection.close()
            return jsonify({'success': True})
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/practice/save', methods=['POST'])
@login_required
def save_practice_result():
    try:
        data = request.json
        print(f"Saving practice result: {data}")  # Debug log
        print(f"User ID: {session['user_id']}")  # Debug log
        
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute(
                'INSERT INTO practice_results (user_id, practice_type, target_gesture, accuracy) VALUES (%s, %s, %s, %s)',
                (session['user_id'], data['practice_type'], data['target_gesture'], data['accuracy'])
            )
            connection.commit()
            print(f"Practice result saved successfully")  # Debug log
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Practice result saved'})
        else:
            print("Database connection failed")  # Debug log
            return jsonify({'success': False, 'error': 'Database connection failed'})
    except Error as e:
        print(f"Error saving practice result: {e}")  # Debug log
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/admin/stats', methods=['GET'])
@admin_required
def get_admin_stats():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            
            cursor.execute('SELECT COUNT(*) FROM users')
            total_users = cursor.fetchone()[0]
            
            cursor.execute('SELECT COUNT(*) FROM materials')
            total_materials = cursor.fetchone()[0]
            
            cursor.execute('SELECT COUNT(*) FROM quiz_questions')
            total_practice = cursor.fetchone()[0]
            
            cursor.execute('SELECT COUNT(DISTINCT user_id) FROM practice_results WHERE DATE(completed_at) = CURDATE()')
            active_today = cursor.fetchone()[0]
            
            cursor.close()
            connection.close()
            
            return jsonify({
                'success': True,
                'stats': {
                    'totalUsers': total_users,
                    'totalMaterials': total_materials,
                    'totalPractice': total_practice,
                    'activeToday': active_today
                }
            })
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/user/learning-status', methods=['GET'])
@login_required
def get_learning_status():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            user_id = session['user_id']
            
            # Get learned items (accuracy >= 70)
            cursor.execute('''
                SELECT target_gesture, practice_type, MAX(accuracy) as max_accuracy
                FROM practice_results 
                WHERE user_id = %s AND accuracy >= 70
                GROUP BY target_gesture, practice_type
            ''', (user_id,))
            learned_items = cursor.fetchall()
            
            cursor.close()
            connection.close()
            
            learned_dict = {}
            for item in learned_items:
                key = f"{item[1]}_{item[0]}"  # practice_type_target_gesture
                learned_dict[key] = item[2]  # accuracy
            
            return jsonify({
                'success': True,
                'learned': learned_dict
            })
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/user/stats', methods=['GET'])
@login_required
def get_user_stats():
    try:
        connection = get_db_connection()
        if connection:
            cursor = connection.cursor()
            user_id = session['user_id']
            print(f"Getting stats for user ID: {user_id}")  # Debug log
            
            # Total latihan
            cursor.execute('SELECT COUNT(*) FROM practice_results WHERE user_id = %s', (user_id,))
            total_practice = cursor.fetchone()[0]
            
            # Akurasi rata-rata
            cursor.execute('SELECT AVG(accuracy) FROM practice_results WHERE user_id = %s', (user_id,))
            avg_accuracy = cursor.fetchone()[0] or 0
            
            # Huruf dikuasai (accuracy >= 80, ambil yang terbaru per huruf)
            cursor.execute('''
                SELECT COUNT(DISTINCT target_gesture) 
                FROM (
                    SELECT target_gesture, MAX(accuracy) as max_accuracy
                    FROM practice_results 
                    WHERE user_id = %s AND practice_type = "alphabet"
                    GROUP BY target_gesture
                    HAVING max_accuracy >= 80
                ) as mastered
            ''', (user_id,))
            mastered_letters = cursor.fetchone()[0]
            
            # Kosakata dikuasai (accuracy >= 80)
            cursor.execute('SELECT COUNT(DISTINCT target_gesture) FROM practice_results WHERE user_id = %s AND practice_type = "vocabulary" AND accuracy >= 80', (user_id,))
            mastered_vocab = cursor.fetchone()[0]
            
            # Progress 7 hari terakhir
            cursor.execute('''
                SELECT DATE(completed_at) as date, AVG(accuracy) as avg_acc 
                FROM practice_results 
                WHERE user_id = %s AND completed_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
                GROUP BY DATE(completed_at)
                ORDER BY date
            ''', (user_id,))
            daily_progress = cursor.fetchall()
            
            # Riwayat latihan terbaru (10 terakhir)
            cursor.execute('''
                SELECT CASE 
                    WHEN DATE(completed_at) = CURDATE() THEN 'Hari ini'
                    WHEN DATE(completed_at) = DATE_SUB(CURDATE(), INTERVAL 1 DAY) THEN 'Kemarin'
                    ELSE CONCAT(
                        CASE DAYOFWEEK(completed_at)
                            WHEN 1 THEN 'Minggu'
                            WHEN 2 THEN 'Senin'
                            WHEN 3 THEN 'Selasa'
                            WHEN 4 THEN 'Rabu'
                            WHEN 5 THEN 'Kamis'
                            WHEN 6 THEN 'Jumat'
                            WHEN 7 THEN 'Sabtu'
                        END,
                        ', ', DAY(completed_at), ' ',
                        CASE MONTH(completed_at)
                            WHEN 1 THEN 'Januari'
                            WHEN 2 THEN 'Februari'
                            WHEN 3 THEN 'Maret'
                            WHEN 4 THEN 'April'
                            WHEN 5 THEN 'Mei'
                            WHEN 6 THEN 'Juni'
                            WHEN 7 THEN 'Juli'
                            WHEN 8 THEN 'Agustus'
                            WHEN 9 THEN 'September'
                            WHEN 10 THEN 'Oktober'
                            WHEN 11 THEN 'November'
                            WHEN 12 THEN 'Desember'
                        END,
                        ' ', YEAR(completed_at)
                    )
                END as date,
                practice_type, target_gesture, accuracy, completed_at
                FROM practice_results 
                WHERE user_id = %s 
                ORDER BY completed_at DESC 
                LIMIT 10
            ''', (user_id,))
            recent_history = cursor.fetchall()
            print(f"Recent history found: {len(recent_history)} records")  # Debug log
            print(f"History data: {recent_history}")  # Debug log
            
            cursor.close()
            connection.close()
            
            # Format data untuk chart
            chart_data = [0] * 7
            chart_labels = []
            
            from datetime import datetime, timedelta
            for i in range(7):
                date = datetime.now() - timedelta(days=6-i)
                chart_labels.append(date.strftime('%a'))
                
                for progress in daily_progress:
                    if str(progress[0]) == date.strftime('%Y-%m-%d'):
                        chart_data[i] = round(float(progress[1]), 1)
            
            # Format riwayat
            history_list = []
            for h in recent_history:
                status = 'Berhasil' if h[3] >= 80 else 'Perlu Latihan' if h[3] >= 60 else 'Kurang'
                history_list.append({
                    'date': h[0],
                    'type': 'Abjad' if h[1] == 'alphabet' else 'Kosakata',
                    'target': h[2],
                    'accuracy': float(h[3]),
                    'status': status
                })
            
            return jsonify({
                'success': True,
                'stats': {
                    'totalPractice': total_practice,
                    'avgAccuracy': round(float(avg_accuracy), 1),
                    'masteredLetters': mastered_letters,
                    'masteredVocab': mastered_vocab,
                    'chartData': chart_data,
                    'chartLabels': chart_labels,
                    'recentHistory': history_list
                }
            })
    except Error as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('landing'))

if __name__ == '__main__':
    init_db()
    app.run(debug=True, host='0.0.0.0', port=5000)