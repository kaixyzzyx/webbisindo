-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Des 2025 pada 07.44
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_bisindo`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `materials`
--

CREATE TABLE `materials` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `materials`
--

INSERT INTO `materials` (`id`, `type`, `title`, `content`, `image_path`, `video_path`, `created_at`) VALUES
(1, 'alphabet', 'A', 'Posisikan tangan dengan jari mengepal, ibu jari di samping', '/static/uploads/20251201162145_A--66-_jpg.rf.1d6de66463e8078c3d2646d03b80e8cf.jpg', NULL, '2025-11-25 09:48:51'),
(2, 'alphabet', 'B', 'Tangan terbuka dengan jari rapat, ibu jari melipat ke dalam', '/static/uploads/20251201162130_B--41-_jpg.rf.c04123f620e060b780c15de790634914.jpg', NULL, '2025-11-25 09:48:51'),
(3, 'alphabet', 'C', 'Bentuk tangan seperti huruf C', '/static/uploads/20251201162209_scene00945_jpg.rf.66c14472614db28f66954d8b8b6e3a40.jpg', NULL, '2025-11-25 09:48:51'),
(4, 'alphabet', 'D', 'Telunjuk tegak, jari lain mengepal, ibu jari menyentuh jari tengah', '/static/uploads/20251201162234_D--56-_jpg.rf.89d61a2446deafcb99046e97c15e0960.jpg', NULL, '2025-11-25 09:48:51'),
(5, 'alphabet', 'E', 'Semua jari menekuk ke dalam telapak tangan', '/static/uploads/20251201162305_E--67-_jpg.rf.8045d00ddd8c7d0110f6782ffa0ca0a6.jpg', NULL, '2025-11-25 09:48:51'),
(6, 'alphabet', 'F', 'Telunjuk dan ibu jari membentuk lingkaran, jari lain tegak', '/static/uploads/20251201162334_F--180-_jpg.rf.23dd967e5ed2aee85c403175b373818e.jpg', NULL, '2025-11-25 09:48:51'),
(7, 'alphabet', 'G', 'Telunjuk dan ibu jari horizontal, jari lain mengepal', '/static/uploads/20251201162624_G--2-_jpg.rf.f8b859891279fef0e7c860ff1a7aa364.jpg', NULL, '2025-11-25 09:48:51'),
(8, 'alphabet', 'H', 'Telunjuk dan jari tengah horizontal, jari lain mengepal', '/static/uploads/20251201162656_H--2-_jpg.rf.7411bd07862156dd562eda6cd9b8e73f.jpg', NULL, '2025-11-25 09:48:51'),
(9, 'alphabet', 'I', 'Kelingking tegak, jari lain mengepal', '/static/uploads/20251201162719_I--252-_jpg.rf.5db957d6de26a2cad51cfe1d703a5ca8.jpg', NULL, '2025-11-25 09:48:51'),
(10, 'alphabet', 'J', 'Kelingking tegak dan bergerak membentuk huruf J', '/static/uploads/20251201162743_j--277-_jpg.rf.0f143b3dcc0da14049f93fab2ba86058.jpg', NULL, '2025-11-25 09:48:51'),
(11, 'alphabet', 'K', 'Telunjuk tegak, jari tengah menyentuh ibu jari', '/static/uploads/20251201162803_K--317-_jpg.rf.1475f8902a09c2427f770da0494ff1a1.jpg', NULL, '2025-11-25 09:48:51'),
(12, 'alphabet', 'L', 'Telunjuk dan ibu jari membentuk huruf L', '/static/uploads/20251201162825_l--283-_jpg.rf.ac2531856f34a88de2369a27e46cdb4c.jpg', NULL, '2025-11-25 09:48:51'),
(13, 'alphabet', 'M', 'Ibu jari di bawah tiga jari yang menekuk', '/static/uploads/20251201162841_M--7-_jpg.rf.bcbd3bfdc37d8e5655946aa1c85157e5.jpg', NULL, '2025-11-25 09:48:51'),
(14, 'alphabet', 'N', 'Ibu jari di bawah dua jari yang menekuk', '/static/uploads/20251201162859_N--92-_jpg.rf.388ac47c6e1cfa2c5d07664573d215b5.jpg', NULL, '2025-11-25 09:48:51'),
(15, 'alphabet', 'O', 'Semua jari membentuk lingkaran', '/static/uploads/20251201162921_O--149-_jpg.rf.624ca5701940b8f303522923e376d566.jpg', NULL, '2025-11-25 09:48:51'),
(16, 'alphabet', 'P', 'Seperti K tapi menghadap ke bawah', '/static/uploads/20251201163022_P--10-_jpg.rf.333f37d0fa29e1a7f588b6a36abfc4f2.jpg', NULL, '2025-11-25 09:48:51'),
(17, 'alphabet', 'Q', 'Telunjuk dan ibu jari menunjuk ke bawah', '/static/uploads/20251201163040_Q--12-_jpg.rf.79291d0fb60057528e9089e298465ac6.jpg', NULL, '2025-11-25 09:48:51'),
(18, 'alphabet', 'R', 'Telunjuk dan jari tengah menyilang', '/static/uploads/20251201163101_R--235-_jpg.rf.3be08a6db6dca0f9cc068b29a64c140d.jpg', NULL, '2025-11-25 09:48:51'),
(19, 'alphabet', 'S', 'Tangan mengepal dengan ibu jari di depan jari', '/static/uploads/20251201163122_S--65-_jpg.rf.6111024254235bedde0a3423f5ee67ee.jpg', NULL, '2025-11-25 09:48:51'),
(20, 'alphabet', 'T', 'Ibu jari di antara telunjuk dan jari tengah', '/static/uploads/20251201163141_T--327-_jpg.rf.3124d9d349031c31490ba6dce06a7ae3.jpg', NULL, '2025-11-25 09:48:51'),
(21, 'alphabet', 'U', 'Telunjuk dan jari tengah tegak rapat', '/static/uploads/20251201163208_U--247-_jpg.rf.cf4a78e17f2db24235c55fd4c925201a.jpg', NULL, '2025-11-25 09:48:51'),
(22, 'alphabet', 'V', 'Telunjuk dan jari tengah tegak membentuk V', '/static/uploads/20251201163235_V--2-_jpg.rf.dbe4582cc80d206cb61333536f86d160.jpg', NULL, '2025-11-25 09:48:51'),
(23, 'alphabet', 'W', 'Telunjuk, jari tengah, dan jari manis tegak', '/static/uploads/20251201163252_W--188-_jpg.rf.7b661cfd6db63b33753bb5c0c263dd1e.jpg', NULL, '2025-11-25 09:48:51'),
(24, 'alphabet', 'X', 'Telunjuk menekuk membentuk kait', '/static/uploads/20251201163305_X--106-_jpg.rf.26d742383b7e30d45c163ece9b57a5e9.jpg', NULL, '2025-11-25 09:48:51'),
(25, 'alphabet', 'Y', 'Ibu jari dan kelingking tegak, jari lain menekup', '/static/uploads/20251201163500_Y--237-_jpg.rf.75db841050fba0488548f270839df704.jpg', NULL, '2025-11-25 09:48:51'),
(26, 'alphabet', 'Z', 'Telunjuk bergerak membentuk huruf Z di udara', '/static/uploads/20251201163519_Z--389-_jpg.rf.65bdb60f8a82081cab40eaaec2f235bd.jpg', NULL, '2025-11-25 09:48:51'),
(27, 'vocabulary', 'ambil', 'Gerakan mengambil sesuatu', '/static/uploads/20251205153614_ambil.png', NULL, '2025-11-25 09:48:51'),
(29, 'vocabulary', 'bantu', 'Memberikan bantuan', '/static/uploads/20251205153750_Screenshot 2025-12-05 153731.png', NULL, '2025-11-25 09:48:51'),
(30, 'vocabulary', 'berdoa', 'Aktivitas berdoa', '/static/uploads/20251205153829_Screenshot 2025-12-05 153813.png', NULL, '2025-11-25 09:48:51'),
(31, 'vocabulary', 'berhenti', 'Menghentikan aktivitas', '/static/uploads/20251205153924_Screenshot 2025-12-05 153908.png', NULL, '2025-11-25 09:48:51'),
(32, 'vocabulary', 'berjalan', 'Aktivitas berjalan', '/static/uploads/20251205154233_Screenshot 2025-12-05 154212.png', NULL, '2025-11-25 09:48:51'),
(33, 'vocabulary', 'berpikir', 'Aktivitas berpikir', '/static/uploads/20251205154350_Screenshot 2025-12-05 154338.png', NULL, '2025-11-25 09:48:51'),
(34, 'vocabulary', 'betul', 'Menyatakan kebenaran', '/static/uploads/20251205154634_Screenshot 2025-12-05 154616.png', NULL, '2025-11-25 09:48:51'),
(35, 'vocabulary', 'bisindo', 'Bahasa Isyarat Indonesia', '/static/uploads/20251205154908_Screenshot 2025-12-05 154854.png', NULL, '2025-11-25 09:48:51'),
(36, 'vocabulary', 'buat', 'Membuat sesuatu', '/static/uploads/20251205155001_Screenshot 2025-12-05 154949.png', NULL, '2025-11-25 09:48:51'),
(37, 'vocabulary', 'hati-hati', 'Peringatan untuk berhati-hati', '/static/uploads/20251205155059_Screenshot 2025-12-05 155047.png', NULL, '2025-11-25 09:48:51'),
(38, 'vocabulary', 'ingat', 'Mengingat sesuatu', '/static/uploads/20251205155235_Screenshot 2025-12-05 155222.png', NULL, '2025-11-25 09:48:51'),
(39, 'vocabulary', 'jangan', 'Larangan', '/static/uploads/20251205155442_Screenshot 2025-12-05 155426.png', NULL, '2025-11-25 09:48:51'),
(40, 'vocabulary', 'janji', 'Membuat janji', '/static/uploads/20251205160205_Screenshot 2025-12-05 160155.png', NULL, '2025-11-25 09:48:51'),
(41, 'vocabulary', 'kamu', 'Kata ganti orang kedua', '/static/uploads/20251205160231_Screenshot 2025-12-05 160220.png', NULL, '2025-11-25 09:48:51'),
(42, 'vocabulary', 'keren', 'Ungkapan kekaguman', '/static/uploads/20251205160612_Screenshot 2025-12-05 160601.png', NULL, '2025-11-25 09:48:51'),
(43, 'vocabulary', 'maaf', 'Permintaan maaf', '/static/uploads/20251205160726_Screenshot 2025-12-05 160705.png', NULL, '2025-11-25 09:48:51'),
(44, 'vocabulary', 'melihat', 'Aktivitas melihat', '/static/uploads/20251205160801_Screenshot 2025-12-05 160752.png', NULL, '2025-11-25 09:48:51'),
(45, 'vocabulary', 'membaca', 'Aktivitas membaca', '/static/uploads/20251205161034_Screenshot 2025-12-05 161006.png', NULL, '2025-11-25 09:48:51'),
(46, 'vocabulary', 'menggambar', 'Aktivitas menggambar', '/static/uploads/20251205161124_Screenshot 2025-12-05 161113.png', NULL, '2025-11-25 09:48:51'),
(47, 'vocabulary', 'menulis', 'Aktivitas menulis', '/static/uploads/20251205180435_Screenshot 2025-12-05 180424.png', NULL, '2025-11-25 09:48:51'),
(48, 'vocabulary', 'minta', 'Meminta sesuatu', '/static/uploads/20251205180530_Screenshot 2025-12-05 180510.png', NULL, '2025-11-25 09:48:51'),
(49, 'vocabulary', 'mulai', 'Memulai sesuatu', '/static/uploads/20251205180617_Screenshot 2025-12-05 180608.png', NULL, '2025-11-25 09:48:51'),
(50, 'vocabulary', 'nama', 'Identitas seseorang', '/static/uploads/20251205180722_Screenshot 2025-12-05 180710.png', NULL, '2025-11-25 09:48:51'),
(51, 'vocabulary', 'paham', 'Mengerti sesuatu', '/static/uploads/20251205175940_Screenshot 2025-12-05 175926.png', NULL, '2025-11-25 09:48:51'),
(52, 'vocabulary', 'perkenalkan', 'Memperkenalkan diri', '/static/uploads/20251205161837_Screenshot 2025-12-05 161821.png', NULL, '2025-11-25 09:48:51'),
(53, 'vocabulary', 'sabar', 'Bersikap sabar', '/static/uploads/20251205162005_Screenshot 2025-12-05 161930.png', NULL, '2025-11-25 09:48:51'),
(54, 'vocabulary', 'salah', 'Menyatakan kesalahan', '/static/uploads/20251205175236_Screenshot 2025-12-05 175222.png', NULL, '2025-11-25 09:48:51'),
(55, 'vocabulary', 'sama-sama', 'Ungkapan balasan terima kasih', '/static/uploads/20251205175434_Screenshot 2025-12-05 175422.png', NULL, '2025-11-25 09:48:51'),
(56, 'vocabulary', 'saya', 'Kata ganti orang pertama', '/static/uploads/20251205180910_Screenshot 2025-12-05 180858.png', NULL, '2025-11-25 09:48:51'),
(57, 'vocabulary', 'semangat', 'Ungkapan penyemangat', '/static/uploads/20251205181026_Screenshot 2025-12-05 181016.png', NULL, '2025-11-25 09:48:51'),
(58, 'vocabulary', 'siapa', 'Pertanyaan menanyakan identitas', '/static/uploads/20251205175556_Screenshot 2025-12-05 175543.png', NULL, '2025-11-25 09:48:51'),
(59, 'vocabulary', 'terima kasih', 'Ungkapan rasa syukur', '/static/uploads/20251205180116_Screenshot 2025-12-05 180102.png', NULL, '2025-11-25 09:48:51'),
(60, 'vocabulary', 'terlambat', 'Datang tidak tepat waktu', '/static/uploads/20251205175759_Screenshot 2025-12-05 175745.png', NULL, '2025-11-25 09:48:51'),
(61, 'vocabulary', 'tolong', 'Meminta bantuan', '/static/uploads/20251205181125_Screenshot 2025-12-05 181113.png', NULL, '2025-11-25 09:48:51'),
(62, 'vocabulary', 'tunggu', 'Menunggu sesuatu', '/static/uploads/20251205162246_Screenshot 2025-12-05 162229.png', NULL, '2025-11-25 09:48:51'),
(63, 'vocabulary', 'waktu', 'Konsep waktu', '/static/uploads/20251205162412_Screenshot 2025-12-05 162358.png', NULL, '2025-11-25 09:48:51'),
(64, 'vocabulary', 'ya', 'Persetujuan', '/static/uploads/20251205181205_Screenshot 2025-12-05 181157.png', NULL, '2025-11-25 09:48:51');

-- --------------------------------------------------------

--
-- Struktur dari tabel `practice_results`
--

CREATE TABLE `practice_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `practice_type` varchar(50) NOT NULL,
  `target_gesture` varchar(100) NOT NULL,
  `accuracy` decimal(5,2) DEFAULT NULL,
  `completed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `practice_results`
--

INSERT INTO `practice_results` (`id`, `user_id`, `practice_type`, `target_gesture`, `accuracy`, `completed_at`) VALUES
(1, 2, 'alphabet', 'A', 86.88, '2025-11-25 15:55:04'),
(2, 2, 'alphabet', 'A', 86.61, '2025-11-25 15:55:05'),
(3, 2, 'alphabet', 'A', 86.95, '2025-11-25 15:55:05'),
(4, 2, 'alphabet', 'A', 87.48, '2025-11-25 15:55:06'),
(5, 2, 'alphabet', 'B', 86.49, '2025-11-26 10:04:40'),
(6, 2, 'alphabet', 'B', 85.93, '2025-11-26 10:04:40'),
(7, 2, 'alphabet', 'B', 86.10, '2025-11-26 10:04:40'),
(8, 2, 'alphabet', 'B', 86.30, '2025-11-26 10:04:41'),
(9, 2, 'alphabet', 'A', 85.50, '2025-11-26 10:27:14'),
(10, 2, 'alphabet', 'A', 85.50, '2025-11-26 10:27:15'),
(11, 2, 'alphabet', 'A', 85.50, '2025-11-26 10:27:33'),
(12, 2, 'alphabet', 'A', 83.71, '2025-11-26 10:29:28'),
(13, 2, 'alphabet', 'A', 85.50, '2025-11-26 10:29:31'),
(14, 2, 'alphabet', 'A', 86.29, '2025-11-26 10:58:07'),
(15, 3, 'alphabet', 'A', 89.13, '2025-11-27 06:48:30'),
(16, 3, 'alphabet', 'B', 85.57, '2025-11-27 06:52:40'),
(17, 7, 'alphabet', 'A', 82.99, '2025-12-01 14:20:22'),
(18, 7, 'alphabet', 'B', 90.99, '2025-12-01 14:20:36'),
(19, 7, 'alphabet', 'A', 87.39, '2025-12-03 06:30:26'),
(20, 7, 'alphabet', 'B', 86.76, '2025-12-03 06:30:36'),
(21, 7, 'vocabulary', 'ambil', 79.64, '2025-12-03 06:41:18'),
(22, 7, 'vocabulary', 'ambil', 85.52, '2025-12-03 06:41:18'),
(23, 7, 'vocabulary', 'ambil', 88.53, '2025-12-03 06:41:19'),
(24, 7, 'vocabulary', 'ambil', 88.02, '2025-12-03 06:41:19'),
(25, 7, 'vocabulary', 'berhenti', 53.56, '2025-12-03 06:41:37'),
(26, 7, 'vocabulary', 'berhenti', 90.07, '2025-12-03 06:41:37'),
(27, 7, 'vocabulary', 'berhenti', 90.51, '2025-12-03 06:41:38'),
(28, 7, 'vocabulary', 'berhenti', 89.26, '2025-12-03 06:41:38'),
(29, 7, 'vocabulary', 'bisindo', 90.00, '2025-12-03 06:41:47'),
(30, 7, 'vocabulary', 'bisindo', 91.30, '2025-12-03 06:41:48'),
(31, 7, 'vocabulary', 'bisindo', 88.05, '2025-12-03 06:41:48'),
(32, 7, 'vocabulary', 'bisindo', 84.11, '2025-12-03 06:41:49'),
(33, 7, 'vocabulary', 'bantu', 90.43, '2025-12-03 06:42:40'),
(34, 7, 'vocabulary', 'bantu', 90.64, '2025-12-03 06:42:40'),
(35, 7, 'vocabulary', 'bantu', 89.73, '2025-12-03 06:42:41'),
(36, 7, 'vocabulary', 'bantu', 90.58, '2025-12-03 06:42:41'),
(37, 7, 'vocabulary', 'berdoa', 89.81, '2025-12-03 06:42:51'),
(38, 7, 'vocabulary', 'berdoa', 91.65, '2025-12-03 06:42:52'),
(39, 7, 'vocabulary', 'berdoa', 77.54, '2025-12-03 06:42:52'),
(40, 7, 'vocabulary', 'berdoa', 76.51, '2025-12-03 06:42:53'),
(41, 7, 'vocabulary', 'betul', 87.38, '2025-12-03 06:42:59'),
(42, 7, 'vocabulary', 'betul', 91.29, '2025-12-03 06:42:59'),
(43, 7, 'vocabulary', 'betul', 91.51, '2025-12-03 06:43:00'),
(44, 7, 'vocabulary', 'betul', 92.38, '2025-12-03 06:43:00'),
(45, 7, 'alphabet', 'D', 85.34, '2025-12-03 06:44:52'),
(46, 7, 'alphabet', 'A', 87.93, '2025-12-03 06:49:28'),
(47, 3, 'alphabet', 'A', 92.39, '2025-12-03 06:58:06'),
(48, 3, 'alphabet', 'A', 88.13, '2025-12-04 06:38:11'),
(49, 3, 'alphabet', 'B', 85.29, '2025-12-04 06:38:38'),
(50, 3, 'alphabet', 'A', 87.62, '2025-12-04 13:54:58'),
(51, 3, 'alphabet', 'A', 87.95, '2025-12-04 13:54:59'),
(52, 3, 'alphabet', 'A', 87.95, '2025-12-04 13:55:03'),
(53, 3, 'alphabet', 'A', 88.54, '2025-12-04 13:55:03'),
(54, 3, 'vocabulary', 'berdoa', 82.67, '2025-12-04 13:59:44'),
(55, 3, 'vocabulary', 'berdoa', 77.32, '2025-12-04 13:59:47'),
(56, 3, 'vocabulary', 'berdoa', 67.24, '2025-12-04 13:59:50'),
(57, 3, 'vocabulary', 'berdoa', 82.07, '2025-12-04 13:59:51'),
(58, 3, 'vocabulary', 'berdoa', 82.36, '2025-12-04 13:59:51'),
(59, 3, 'vocabulary', 'berdoa', 80.75, '2025-12-04 13:59:52'),
(60, 3, 'vocabulary', 'berdoa', 81.29, '2025-12-04 13:59:52'),
(61, 3, 'vocabulary', 'berdoa', 81.16, '2025-12-04 13:59:53'),
(62, 3, 'vocabulary', 'berdoa', 87.22, '2025-12-04 13:59:53'),
(63, 3, 'vocabulary', 'berjalan', 51.54, '2025-12-04 14:00:15'),
(64, 3, 'vocabulary', 'berjalan', 64.72, '2025-12-04 14:00:19'),
(65, 3, 'vocabulary', 'berjalan', 75.61, '2025-12-04 14:00:22'),
(66, 3, 'vocabulary', 'berjalan', 75.77, '2025-12-04 14:00:23'),
(67, 3, 'vocabulary', 'berjalan', 78.20, '2025-12-04 14:00:36'),
(68, 3, 'vocabulary', 'berjalan', 64.37, '2025-12-04 14:00:37'),
(69, 3, 'vocabulary', 'berjalan', 63.56, '2025-12-04 14:00:37'),
(70, 3, 'vocabulary', 'berjalan', 51.99, '2025-12-04 14:00:39'),
(71, 3, 'vocabulary', 'berjalan', 59.38, '2025-12-04 14:00:39'),
(72, 3, 'vocabulary', 'betul', 89.17, '2025-12-04 14:00:52'),
(73, 3, 'vocabulary', 'betul', 87.56, '2025-12-04 14:00:53'),
(74, 3, 'vocabulary', 'betul', 90.94, '2025-12-04 14:00:54'),
(75, 3, 'vocabulary', 'betul', 91.98, '2025-12-04 14:00:54'),
(76, 3, 'vocabulary', 'betul', 90.91, '2025-12-04 14:00:55'),
(77, 3, 'vocabulary', 'betul', 91.85, '2025-12-04 14:00:56'),
(78, 3, 'vocabulary', 'bisindo', 89.08, '2025-12-04 14:01:03'),
(79, 3, 'vocabulary', 'bisindo', 89.53, '2025-12-04 14:01:04'),
(80, 3, 'vocabulary', 'bisindo', 87.88, '2025-12-04 14:01:05'),
(81, 3, 'vocabulary', 'bisindo', 87.70, '2025-12-04 14:01:05'),
(82, 3, 'vocabulary', 'bisindo', 87.64, '2025-12-04 14:01:06'),
(83, 3, 'vocabulary', 'bisindo', 88.11, '2025-12-04 14:01:06'),
(84, 3, 'alphabet', 'A', 91.16, '2025-12-04 14:13:10'),
(85, 3, 'alphabet', 'A', 78.86, '2025-12-04 14:13:11'),
(86, 3, 'alphabet', 'B', 62.15, '2025-12-04 14:13:40'),
(87, 3, 'alphabet', 'B', 66.58, '2025-12-04 14:14:25'),
(88, 3, 'alphabet', 'C', 50.55, '2025-12-04 14:14:51'),
(89, 3, 'alphabet', 'C', 60.74, '2025-12-04 14:15:04'),
(90, 3, 'alphabet', 'C', 56.87, '2025-12-04 14:15:16'),
(91, 3, 'alphabet', 'C', 52.17, '2025-12-04 14:15:16'),
(92, 3, 'alphabet', 'D', 68.13, '2025-12-04 14:15:37'),
(93, 3, 'alphabet', 'D', 73.64, '2025-12-04 14:15:37'),
(94, 3, 'alphabet', 'E', 70.10, '2025-12-04 14:15:56'),
(95, 3, 'alphabet', 'E', 76.15, '2025-12-04 14:15:57'),
(96, 3, 'alphabet', 'B', 66.33, '2025-12-05 08:11:24'),
(97, 3, 'alphabet', 'B', 81.14, '2025-12-05 08:11:25'),
(98, 3, 'alphabet', 'B', 66.16, '2025-12-05 08:11:26'),
(99, 3, 'alphabet', 'B', 51.64, '2025-12-05 08:11:28'),
(100, 3, 'alphabet', 'B', 68.87, '2025-12-05 08:11:29'),
(101, 3, 'alphabet', 'B', 68.38, '2025-12-05 08:11:30'),
(102, 3, 'alphabet', 'B', 78.41, '2025-12-05 08:11:31'),
(103, 3, 'alphabet', 'B', 74.24, '2025-12-05 08:11:32'),
(104, 3, 'alphabet', 'B', 61.21, '2025-12-05 08:11:33'),
(105, 3, 'alphabet', 'A', 55.63, '2025-12-06 14:39:03'),
(106, 3, 'alphabet', 'A', 51.31, '2025-12-06 14:39:04'),
(107, 3, 'alphabet', 'A', 66.24, '2025-12-06 14:39:06'),
(108, 3, 'alphabet', 'A', 73.83, '2025-12-06 14:39:06'),
(109, 3, 'alphabet', 'A', 77.33, '2025-12-06 14:39:07'),
(110, 3, 'alphabet', 'A', 72.85, '2025-12-06 14:45:55'),
(111, 3, 'alphabet', 'A', 75.10, '2025-12-06 14:45:57'),
(112, 3, 'alphabet', 'A', 75.37, '2025-12-06 14:45:58'),
(113, 3, 'alphabet', 'A', 82.42, '2025-12-06 14:45:58'),
(114, 3, 'alphabet', 'B', 57.10, '2025-12-06 14:48:12'),
(115, 3, 'alphabet', 'B', 75.60, '2025-12-06 14:48:14'),
(116, 3, 'alphabet', 'B', 72.33, '2025-12-06 14:48:18'),
(117, 3, 'alphabet', 'B', 73.26, '2025-12-06 14:48:20'),
(118, 3, 'alphabet', 'C', 73.50, '2025-12-06 14:49:20'),
(119, 3, 'alphabet', 'C', 68.18, '2025-12-06 14:49:26'),
(120, 3, 'alphabet', 'C', 71.95, '2025-12-06 14:49:28'),
(121, 3, 'alphabet', 'C', 67.29, '2025-12-06 14:49:29'),
(122, 3, 'vocabulary', 'ambil', 84.54, '2025-12-06 14:50:15'),
(123, 3, 'vocabulary', 'ambil', 90.94, '2025-12-06 14:50:17'),
(124, 3, 'vocabulary', 'ambil', 91.49, '2025-12-06 14:50:18'),
(125, 3, 'vocabulary', 'ambil', 90.28, '2025-12-06 14:50:24'),
(126, 3, 'alphabet', 'A', 78.88, '2025-12-06 15:37:59'),
(127, 3, 'alphabet', 'B', 74.06, '2025-12-06 15:38:07'),
(128, 3, 'alphabet', 'C', 81.27, '2025-12-06 15:38:18'),
(129, 3, 'alphabet', 'D', 50.10, '2025-12-06 15:38:23'),
(130, 3, 'alphabet', 'E', 59.60, '2025-12-06 15:38:27'),
(131, 3, 'alphabet', 'F', 56.41, '2025-12-06 15:38:36'),
(132, 3, 'alphabet', 'G', 83.28, '2025-12-06 15:38:40'),
(133, 3, 'alphabet', 'H', 82.19, '2025-12-06 15:38:44'),
(134, 3, 'alphabet', 'I', 65.69, '2025-12-06 15:38:48'),
(135, 3, 'alphabet', 'J', 57.85, '2025-12-06 15:39:15'),
(136, 3, 'alphabet', 'K', 82.03, '2025-12-06 15:39:19'),
(137, 3, 'alphabet', 'L', 82.09, '2025-12-06 15:39:23'),
(138, 3, 'alphabet', 'M', 80.96, '2025-12-06 15:39:26'),
(139, 3, 'alphabet', 'N', 86.70, '2025-12-06 15:39:30'),
(140, 3, 'vocabulary', 'bantu', 93.11, '2025-12-06 15:42:19'),
(141, 3, 'vocabulary', 'bantu', 93.21, '2025-12-06 15:42:20'),
(142, 3, 'vocabulary', 'berdoa', 90.77, '2025-12-06 15:42:23'),
(143, 3, 'vocabulary', 'berdoa', 90.00, '2025-12-06 15:42:24'),
(144, 3, 'vocabulary', 'berhenti', 77.34, '2025-12-06 15:42:26'),
(145, 3, 'vocabulary', 'berhenti', 87.03, '2025-12-06 15:42:27'),
(146, 3, 'vocabulary', 'berjalan', 88.64, '2025-12-06 15:42:30'),
(147, 3, 'vocabulary', 'berjalan', 87.11, '2025-12-06 15:42:31'),
(148, 3, 'vocabulary', 'berpikir', 92.96, '2025-12-06 15:42:37'),
(149, 3, 'vocabulary', 'berpikir', 86.63, '2025-12-06 15:42:38'),
(150, 3, 'vocabulary', 'betul', 93.20, '2025-12-06 15:42:40'),
(151, 3, 'vocabulary', 'bisindo', 91.73, '2025-12-06 15:42:44'),
(152, 3, 'vocabulary', 'bisindo', 90.93, '2025-12-06 15:42:45'),
(153, 3, 'vocabulary', 'buat', 86.68, '2025-12-06 15:42:48'),
(154, 3, 'vocabulary', 'buat', 88.04, '2025-12-06 15:42:49'),
(155, 3, 'vocabulary', 'hati-hati', 69.53, '2025-12-06 15:43:09'),
(156, 3, 'vocabulary', 'hati-hati', 68.44, '2025-12-06 15:43:10'),
(157, 3, 'vocabulary', 'ingat', 66.05, '2025-12-06 15:43:16'),
(158, 3, 'vocabulary', 'ingat', 60.33, '2025-12-06 15:43:17'),
(159, 3, 'vocabulary', 'jangan', 96.74, '2025-12-06 15:43:20'),
(160, 3, 'vocabulary', 'jangan', 96.74, '2025-12-06 15:43:21'),
(161, 3, 'vocabulary', 'janji', 78.28, '2025-12-06 15:43:25'),
(162, 3, 'vocabulary', 'kamu', 84.54, '2025-12-06 15:43:28'),
(163, 3, 'vocabulary', 'keren', 90.98, '2025-12-06 15:43:31'),
(164, 3, 'vocabulary', 'keren', 92.55, '2025-12-06 15:43:32'),
(165, 3, 'vocabulary', 'ingat', 80.64, '2025-12-06 15:44:19'),
(166, 3, 'vocabulary', 'ingat', 74.96, '2025-12-06 15:44:20'),
(167, 3, 'vocabulary', 'jangan', 86.25, '2025-12-06 15:44:24'),
(168, 3, 'vocabulary', 'jangan', 95.35, '2025-12-06 15:44:25'),
(169, 3, 'vocabulary', 'janji', 89.32, '2025-12-06 15:44:28'),
(170, 3, 'vocabulary', 'janji', 83.70, '2025-12-06 15:44:29'),
(171, 3, 'vocabulary', 'kamu', 84.29, '2025-12-06 15:44:34'),
(172, 5, 'alphabet', 'A', 86.21, '2025-12-06 15:58:28'),
(173, 5, 'alphabet', 'B', 56.07, '2025-12-06 15:58:38'),
(174, 5, 'alphabet', 'A', 93.52, '2025-12-06 15:59:34'),
(175, 5, 'alphabet', 'B', 76.78, '2025-12-06 15:59:44'),
(176, 3, 'alphabet', 'H', 52.81, '2025-12-06 16:00:03'),
(177, 5, 'alphabet', 'C', 61.90, '2025-12-06 16:00:45'),
(178, 5, 'alphabet', 'D', 58.01, '2025-12-06 16:00:53'),
(179, 5, 'alphabet', 'E', 69.99, '2025-12-06 16:01:05'),
(180, 5, 'vocabulary', 'ambil', 69.14, '2025-12-06 16:01:34'),
(181, 5, 'vocabulary', 'bantu', 64.64, '2025-12-06 16:01:42'),
(182, 5, 'alphabet', 'D', 80.82, '2025-12-06 16:06:12'),
(183, 5, 'alphabet', 'E', 70.64, '2025-12-06 16:06:43'),
(184, 5, 'alphabet', 'E', 73.52, '2025-12-06 16:06:43'),
(185, 5, 'alphabet', 'F', 57.21, '2025-12-06 16:06:56'),
(186, 5, 'alphabet', 'F', 54.98, '2025-12-06 16:06:56'),
(187, 5, 'vocabulary', 'ambil', 86.02, '2025-12-06 16:08:21'),
(188, 5, 'vocabulary', 'ambil', 75.78, '2025-12-06 16:08:22'),
(189, 3, 'vocabulary', 'bantu', 92.05, '2025-12-06 16:08:27'),
(190, 3, 'vocabulary', 'bantu', 76.86, '2025-12-06 16:08:28'),
(191, 3, 'vocabulary', 'berdoa', 79.60, '2025-12-06 16:08:39'),
(192, 3, 'alphabet', 'F', 76.26, '2025-12-07 06:15:06'),
(193, 3, 'alphabet', 'G', 51.07, '2025-12-07 06:15:12'),
(194, 3, 'alphabet', 'H', 67.42, '2025-12-07 06:15:19'),
(195, 3, 'alphabet', 'G', 58.20, '2025-12-07 06:15:22'),
(196, 3, 'alphabet', 'A', 75.14, '2025-12-07 06:17:52'),
(197, 3, 'alphabet', 'B', 89.71, '2025-12-07 06:18:03'),
(198, 3, 'alphabet', 'C', 81.26, '2025-12-07 06:18:29'),
(199, 3, 'alphabet', 'D', 76.41, '2025-12-07 06:18:35');

-- --------------------------------------------------------

--
-- Struktur dari tabel `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `difficulty` varchar(20) DEFAULT 'mudah',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `quiz_questions`
--

INSERT INTO `quiz_questions` (`id`, `type`, `question`, `answer`, `difficulty`, `created_at`) VALUES
(2, 'alphabet', 'BUKU', 'BUKU', 'mudah', '2025-11-25 09:48:51'),
(4, 'alphabet', 'DAMAI', 'DAMAI', 'mudah', '2025-11-25 09:48:51'),
(5, 'alphabet', 'ENAK', 'ENAK', 'mudah', '2025-11-25 09:48:51'),
(6, 'alphabet', 'GEMBIRA', 'GEMBIRA', 'sedang', '2025-11-25 09:48:51'),
(7, 'alphabet', 'HARAPAN', 'HARAPAN', 'sedang', '2025-11-25 09:48:51'),
(8, 'alphabet', 'INDAH', 'INDAH', 'sedang', '2025-11-25 09:48:51'),
(9, 'alphabet', 'JUJUR', 'JUJUR', 'sedang', '2025-11-25 09:48:51'),
(10, 'alphabet', 'KELUARGA', 'KELUARGA', 'sulit', '2025-11-25 09:48:51'),
(29, 'alphabet', 'RUMAH', 'RUMAH', 'mudah', '2025-12-07 06:19:40'),
(30, 'vocabulary', 'bantu, janji, keren', 'bantu,janji,keren', 'mudah', '2025-12-07 06:20:11'),
(31, 'vocabulary', 'terima kasih, tunggu, waktu', 'terima kasih,tunggu,waktu', 'mudah', '2025-12-07 06:20:33'),
(32, 'vocabulary', 'berhenti, betul, bisindo', 'berhenti,betul,bisindo', 'mudah', '2025-12-07 06:21:33'),
(33, 'vocabulary', 'berjalan, buat, kamu', 'berjalan,buat,kamu', 'mudah', '2025-12-07 06:21:47'),
(34, 'vocabulary', 'perkenalkan, siapa, terlambat', 'perkenalkan,siapa,terlambat', 'mudah', '2025-12-07 06:22:57'),
(35, 'vocabulary', 'ingat, minta, terima kasih', 'ingat,minta,terima kasih', 'mudah', '2025-12-07 06:23:29');

-- --------------------------------------------------------

--
-- Struktur dari tabel `quiz_results`
--

CREATE TABLE `quiz_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `user_answer` text DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int(11) DEFAULT NULL,
  `completed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `quiz_results`
--

INSERT INTO `quiz_results` (`id`, `user_id`, `quiz_id`, `user_answer`, `is_correct`, `time_taken`, `completed_at`) VALUES
(1, 3, 2, 'BUKU', 1, 71, '2025-11-27 06:50:06'),
(2, 7, 2, 'BUKU', 1, 41, '2025-12-01 14:22:07'),
(3, 7, 2, 'BUKU', 1, 63, '2025-12-03 06:31:52'),
(4, 3, 2, 'BUKU', 1, 8, '2025-12-06 15:21:20'),
(5, 3, 2, 'BUKU', 1, 9, '2025-12-06 15:24:12'),
(6, 3, 2, 'BUKU', 1, 5, '2025-12-06 15:26:17'),
(7, 3, 2, 'BUKU', 1, 7, '2025-12-06 15:26:38'),
(8, 3, 2, 'BUKU', 1, 6, '2025-12-06 15:28:52'),
(9, 3, 2, 'BUKU', 1, 5, '2025-12-06 15:30:35'),
(10, 3, 2, 'BUKU', 1, 6, '2025-12-06 15:31:42'),
(11, 3, 2, 'BUKU', 1, 6, '2025-12-06 15:32:33'),
(12, 3, 2, 'BUKU', 1, 6, '2025-12-06 15:33:05'),
(13, 3, 2, 'BUKU', 1, 20, '2025-12-06 15:37:38'),
(15, 5, 2, 'BUKU', 1, 64, '2025-12-06 16:03:09');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'admin', 'admin@bisindo.com', '0192023a7bbd73250516f069df18b500', 'admin', '2025-11-25 09:48:51'),
(2, 'bima', 'bima@gmail.com', 'fcdc5905c5cc0efd143337b44160e01a', 'user', '2025-11-25 10:01:51'),
(3, 'kai', 'muhammadkhairulikhwanxyz@gmail.com', 'c8837b23ff8aaa8a2dde915473ce0991', 'user', '2025-11-27 06:47:23'),
(4, 'ikhwan', 'czewtyu@gmail.com', 'c81e728d9d4c2f636f067f89cc14862c', 'user', '2025-11-28 14:28:08'),
(5, 'ulma', 'mamaulna499@gmail.com', '9baca14b1a1c4c395887150c8aa63f07', 'user', '2025-12-01 07:24:58'),
(6, 'kai1', '202202011012@mhs.hayamwuruk.ac.id', '44346e80db976665183de9dd2d72caac', 'user', '2025-12-01 08:20:00'),
(7, 'test', 'khozong1@gmail.com', 'c8837b23ff8aaa8a2dde915473ce0991', 'user', '2025-12-01 08:26:51');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `practice_results`
--
ALTER TABLE `practice_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT untuk tabel `practice_results`
--
ALTER TABLE `practice_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- AUTO_INCREMENT untuk tabel `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT untuk tabel `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `practice_results`
--
ALTER TABLE `practice_results`
  ADD CONSTRAINT `practice_results_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD CONSTRAINT `quiz_results_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_results_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quiz_questions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
