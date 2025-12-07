# BISINDO Learning Platform

Platform edukasi interaktif untuk pembelajaran Bahasa Isyarat Indonesia (BISINDO) dengan teknologi YOLOv11 untuk deteksi gerakan tangan real-time.

## Fitur Utama

### 🎓 Modul Pembelajaran
- **Abjad A-Z BISINDO**: Materi pembelajaran untuk setiap huruf dalam bahasa isyarat Indonesia
- **Kosakata Dasar BISINDO**: Kosakata sehari-hari dengan visual dan penjelasan makna

### 🏋️ Modul Latihan
- **Latihan Abjad A-Z**: Berlatih mengisyaratkan huruf yang telah dipelajari
- **Latihan Kosakata Dasar**: Latihan mengenali dan menirukan kosakata dasar
- **Deteksi Kamera Real-time**: Fitur utama dengan YOLOv11 untuk mendeteksi dan menilai gerakan tangan

### 👥 Sistem Pengguna
- **User**: Akses materi, latihan real-time, riwayat progress, login/register
- **Admin**: Kelola materi pembelajaran, latihan, dan data pengguna

## Teknologi yang Digunakan

- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5
- **Backend**: Flask (Python)
- **AI Model**: YOLOv11 untuk deteksi gerakan tangan
- **Database**: MySQL
- **Computer Vision**: OpenCV
- **Deep Learning**: PyTorch, Ultralytics

## Instalasi dan Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd "Bisindo Program"
```

### 2. Install Dependencies
```bash
pip install -r requirements.txt
```

### 3. Setup MySQL Database
```bash
# Login ke MySQL
mysql -u root -p

# Jalankan script setup
source database_setup.sql
```

Atau import file `database_setup.sql` melalui phpMyAdmin atau MySQL Workbench.

### 4. Konfigurasi Database
Buat file `.env` atau set environment variables:
```bash
MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_PASSWORD=your_password
MYSQL_DB=db_bisindo
MYSQL_PORT=3306
```

### 5. Setup Model YOLOv11
Pastikan file `best.pt` (model YOLOv11 yang sudah dilatih) ada di direktori root project.

### 6. Jalankan Aplikasi
```bash
python app.py
```

Aplikasi akan berjalan di `http://localhost:5000`

## Struktur Project

```
Bisindo Program/
├── app.py                 # Main Flask application
├── best.pt               # YOLOv11 trained model
├── requirements.txt      # Python dependencies
├── README.md            # Project documentation
├── app/
│   ├── templates/       # HTML templates
│   │   ├── base.html
│   │   ├── index.html
│   │   ├── login.html
│   │   ├── register.html
│   │   ├── dashboard.html
│   │   ├── learning_alphabet.html
│   │   ├── learning_vocabulary.html
│   │   ├── practice_alphabet.html
│   │   └── practice_camera.html
│   ├── static/         # Static files
│   │   ├── css/
│   │   │   └── style.css
│   │   ├── js/
│   │   │   └── main.js
│   │   └── images/
│   └── images/         # Image assets
```

## Penggunaan

### Untuk Pengguna (User)

1. **Registrasi/Login**
   - Buat akun baru atau login dengan akun existing
   - Akses dashboard untuk melihat progress

2. **Pembelajaran**
   - Pilih "Pembelajaran" → "Abjad A-Z" untuk belajar huruf
   - Pilih "Pembelajaran" → "Kosakata Dasar" untuk belajar kata

3. **Latihan**
   - Pilih "Latihan" → "Latihan Abjad" untuk berlatih huruf
   - Pilih "Latihan" → "Deteksi Kamera" untuk latihan real-time

4. **Deteksi Real-time**
   - Klik "Mulai Kamera" untuk mengaktifkan webcam
   - Posisikan tangan di depan kamera
   - Lakukan gerakan BISINDO
   - Sistem akan mendeteksi dan memberikan feedback

### Untuk Admin

1. **Login sebagai Admin**
   - Gunakan akun admin untuk mengakses fitur pengelolaan

2. **Kelola Konten**
   - Tambah, edit, atau hapus materi pembelajaran
   - Kelola soal dan latihan
   - Monitor progress pengguna

## API Endpoints

### Authentication
- `GET /` - Halaman beranda
- `GET /login` - Halaman login
- `POST /login` - Proses login
- `GET /register` - Halaman registrasi
- `POST /register` - Proses registrasi
- `GET /logout` - Logout

### Learning
- `GET /learning/alphabet` - Pembelajaran abjad
- `GET /learning/vocabulary` - Pembelajaran kosakata

### Practice
- `GET /practice/alphabet` - Latihan abjad
- `GET /practice/vocabulary` - Latihan kosakata
- `GET /practice/camera` - Deteksi kamera

### API
- `GET /video_feed` - Stream video real-time
- `POST /detect_gesture` - Deteksi gerakan dari gambar

## Database Schema

### Users Table
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Materials Table
```sql
CREATE TABLE materials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    image_path VARCHAR(255),
    video_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Practice Results Table
```sql
CREATE TABLE practice_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    practice_type VARCHAR(50) NOT NULL,
    target_gesture VARCHAR(100) NOT NULL,
    accuracy DECIMAL(5,2),
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);
```

## Konfigurasi YOLOv11

Model YOLOv11 digunakan untuk mendeteksi gerakan tangan BISINDO. Pastikan:

1. File `best.pt` adalah model yang sudah dilatih dengan dataset BISINDO
2. Model mendukung deteksi untuk:
   - Abjad A-Z BISINDO
   - Kosakata dasar BISINDO
3. Confidence threshold default: 0.25

## Troubleshooting

### Kamera tidak berfungsi
- Pastikan browser memiliki akses ke kamera
- Cek apakah kamera tidak digunakan aplikasi lain
- Gunakan HTTPS untuk akses kamera di production

### Model tidak terdeteksi
- Pastikan file `best.pt` ada di direktori root
- Cek kompatibilitas versi ultralytics
- Pastikan PyTorch terinstall dengan benar

### Database error
- Pastikan MySQL server berjalan
- Cek konfigurasi koneksi database di `config.py`
- Jalankan script `database_setup.sql` untuk membuat database

## Kontribusi

1. Fork repository
2. Buat branch fitur (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

## Lisensi

Project ini menggunakan lisensi MIT. Lihat file `LICENSE` untuk detail.

## Tim Pengembang

- **Frontend Developer**: Pengembangan antarmuka pengguna
- **Backend Developer**: Pengembangan server dan API
- **AI/ML Engineer**: Integrasi model YOLOv11
- **UI/UX Designer**: Desain pengalaman pengguna

## Roadmap

### Version 1.1
- [ ] Tambah lebih banyak kosakata
- [ ] Implementasi gamifikasi
- [ ] Fitur leaderboard
- [ ] Export progress report

### Version 1.2
- [ ] Mobile app (React Native)
- [ ] Offline mode
- [ ] Advanced analytics
- [ ] Multi-language support

## Support

Untuk bantuan dan pertanyaan:
- Email: support@bisindo-platform.com
- Documentation: [Wiki](link-to-wiki)
- Issues: [GitHub Issues](link-to-issues)

---

**BISINDO Learning Platform** - Membangun komunikasi inklusif melalui teknologi 🤟