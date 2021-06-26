-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Jun 2021 pada 06.10
-- Versi server: 10.4.14-MariaDB
-- Versi PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `skripsi-minat-bakat`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `groups`
--

CREATE TABLE `groups` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'guru', 'Pembuat Soal dan ujian'),
(3, 'siswa', 'Peserta Ujian');

-- --------------------------------------------------------

--
-- Struktur dari tabel `guru`
--

CREATE TABLE `guru` (
  `id_guru` int(11) NOT NULL,
  `nip` char(12) NOT NULL,
  `nama_guru` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `keterampilan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `guru`
--

INSERT INTO `guru` (`id_guru`, `nip`, `nama_guru`, `email`, `keterampilan_id`) VALUES
(3, '01234567', 'abi', 'abi@gmail.com', 1),
(4, '202020202', 'Baru guru', 'guru@gmail.com', 1),
(19, '345234567', 'new', 'new@nw.com', 1),
(22, '1965091620', 'Miftachul Choir', 'Miftahul@gmail.com', 6),
(26, '1965091601', 'Ahmad Latif', 'Latif@gmail.com', 7),
(27, '1965091602', 'sulistina', 'sulistina@gmail.com', 8),
(28, '1965091603', 'Agung', 'Agung@gmail.com', 9),
(29, '1965091604', 'Chariri', 'chariri@gmail.com', 10),
(30, '1965091605', 'riski bactiar', 'riski@gmail.com', 11),
(31, '1965091606', 'Yuli', 'yuli@gmail.com', 12),
(32, '1965091607', 'ayu', 'ayu@gmail.com', 14),
(33, '1965091608', 'Rudi', 'rudi@gmail.com', 13),
(34, '1965091609', 'diah', 'diah@gmail.com', 16);

--
-- Trigger `guru`
--
DELIMITER $$
CREATE TRIGGER `edit_user_dosen` BEFORE UPDATE ON `guru` FOR EACH ROW UPDATE `users` SET `email` = NEW.email, `username` = NEW.nip WHERE `users`.`username` = OLD.nip
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hapus_user_dosen` BEFORE DELETE ON `guru` FOR EACH ROW DELETE FROM `users` WHERE `users`.`username` = OLD.nip
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `h_ujian`
--

CREATE TABLE `h_ujian` (
  `id` int(11) NOT NULL,
  `ujian_id` int(11) NOT NULL,
  `siswa_id` int(11) NOT NULL,
  `list_soal` longtext NOT NULL,
  `list_jawaban` longtext NOT NULL,
  `jml_benar` int(11) NOT NULL,
  `nilai` decimal(10,2) NOT NULL,
  `nilai_bobot` decimal(10,2) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `tgl_selesai` datetime NOT NULL,
  `status` enum('Y','N') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `h_ujian`
--

INSERT INTO `h_ujian` (`id`, `ujian_id`, `siswa_id`, `list_soal`, `list_jawaban`, `jml_benar`, `nilai`, `nilai_bobot`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES
(5, 4, 3, '11', '11:B:N', 0, '0.00', '100.00', '2021-05-08 10:17:09', '2021-05-08 10:27:09', 'N'),
(6, 6, 9, '13', '13:C:N', 1, '100.00', '100.00', '2021-06-22 08:35:10', '2021-06-22 08:40:10', 'N'),
(7, 7, 9, '13', '13:E:N', 0, '0.00', '100.00', '2021-06-22 08:40:08', '2021-06-22 08:45:08', 'N'),
(8, 8, 9, '15', '15:B:N', 1, '100.00', '100.00', '2021-06-22 08:59:09', '2021-06-22 09:04:09', 'N'),
(9, 9, 10, '16', '16:E:N', 0, '0.00', '100.00', '2021-06-23 19:36:21', '2021-06-23 19:41:21', 'N'),
(10, 12, 10, '19,20,21,22', '19:B:Y,20:A:N,21:B:N,22::N', 0, '0.00', '100.00', '2021-06-25 13:10:22', '2021-06-25 13:20:22', 'N'),
(11, 13, 10, '23', '23:C:Y', 0, '0.00', '100.00', '2021-06-25 15:35:14', '2021-06-25 15:45:14', 'N'),
(12, 14, 10, '31,28,34,32,35,27,29,33,26,30', '31:A:N,28:C:N,34:B:N,32:D:N,35:A:N,27:C:N,29:E:N,33:A:N,26:B:N,30:C:N', 3, '30.00', '100.00', '2021-06-26 10:37:35', '2021-06-26 10:47:35', 'N');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan`
--

CREATE TABLE `jurusan` (
  `id_jurusan` int(11) NOT NULL,
  `nama_jurusan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jurusan`
--

INSERT INTO `jurusan` (`id_jurusan`, `nama_jurusan`) VALUES
(1, 'Rekayasa Perangkat Lunak'),
(2, 'Akutansi'),
(3, 'Perbankan Syariah'),
(4, 'Pemasaran'),
(5, 'Teknik Komputer Jaringan'),
(6, 'Multimedia');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan_keterampilan`
--

CREATE TABLE `jurusan_keterampilan` (
  `id` int(11) NOT NULL,
  `keterampilan_id` int(11) NOT NULL,
  `jurusan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jurusan_keterampilan`
--

INSERT INTO `jurusan_keterampilan` (`id`, `keterampilan_id`, `jurusan_id`) VALUES
(9, 5, 1),
(10, 3, 2),
(11, 3, 3),
(12, 1, 1),
(15, 6, 1),
(16, 6, 5),
(17, 6, 6),
(18, 8, 1),
(19, 8, 3),
(20, 8, 5),
(21, 8, 6),
(22, 7, 1),
(23, 7, 4),
(24, 7, 5),
(25, 7, 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` int(11) NOT NULL,
  `nama_kelas` varchar(30) NOT NULL,
  `jurusan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`, `jurusan_id`) VALUES
(1, 'XI', 2),
(2, 'XI', 1),
(3, 'X', 1),
(7, 'XII', 1),
(8, 'X', 2),
(9, 'XII', 2),
(10, 'X', 6),
(11, 'XI', 6),
(12, 'XII', 6),
(13, 'X', 4),
(14, 'XI', 4),
(15, 'XII', 4),
(16, 'X', 3),
(17, 'XI', 3),
(18, 'XII', 3),
(19, 'X', 5),
(20, 'XI', 5),
(21, 'XII', 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas_guru`
--

CREATE TABLE `kelas_guru` (
  `id` int(11) NOT NULL,
  `kelas_id` int(11) NOT NULL,
  `guru_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kelas_guru`
--

INSERT INTO `kelas_guru` (`id`, `kelas_id`, `guru_id`) VALUES
(20, 3, 5),
(21, 7, 5),
(30, 3, 21),
(32, 19, 23),
(33, 10, 23),
(34, 16, 23),
(35, 3, 23),
(36, 16, 24),
(37, 19, 24),
(41, 3, 22),
(42, 13, 22),
(43, 19, 22),
(44, 10, 22),
(49, 3, 27),
(50, 13, 27),
(51, 19, 27),
(52, 10, 27),
(53, 3, 26),
(54, 13, 26),
(55, 19, 26),
(56, 10, 26);

-- --------------------------------------------------------

--
-- Struktur dari tabel `keterampilan`
--

CREATE TABLE `keterampilan` (
  `id_keterampilan` int(11) NOT NULL,
  `nama_keterampilan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `keterampilan`
--

INSERT INTO `keterampilan` (`id_keterampilan`, `nama_keterampilan`) VALUES
(6, 'Bakat Penalaran Visual'),
(7, 'Bakat Penalaran Numerik'),
(8, 'Bakat Analisa Verbal'),
(9, 'Bakat Penalaran Urutan'),
(10, 'Bakat Pengenalan Spasial'),
(11, 'Bakat Tiga Dimensi'),
(12, 'Bakat Sistematisasi'),
(13, 'Bakat Kosa Kata'),
(14, 'Bakat Figural Angka'),
(15, 'Ujian Minat'),
(16, 'Minat');

-- --------------------------------------------------------

--
-- Struktur dari tabel `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `ip_address`, `login`, `time`) VALUES
(43, '::1', 'dandy@admini.com', 1624602912);

-- --------------------------------------------------------

--
-- Struktur dari tabel `m_ujian`
--

CREATE TABLE `m_ujian` (
  `id_ujian` int(11) NOT NULL,
  `guru_id` int(11) NOT NULL,
  `keterampilan_id` int(11) NOT NULL,
  `nama_ujian` varchar(200) NOT NULL,
  `jumlah_soal` int(11) NOT NULL,
  `waktu` int(11) NOT NULL,
  `jenis` enum('acak','urut') NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `terlambat` datetime NOT NULL,
  `token` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `m_ujian`
--

INSERT INTO `m_ujian` (`id_ujian`, `guru_id`, `keterampilan_id`, `nama_ujian`, `jumlah_soal`, `waktu`, `jenis`, `tgl_mulai`, `terlambat`, `token`) VALUES
(4, 4, 1, 'bakat', 1, 10, 'acak', '2021-05-08 10:17:00', '2021-05-08 15:00:36', 'KUIVZ'),
(5, 5, 5, 'bakat', 1, 5, 'acak', '2021-04-25 15:10:21', '2021-04-25 15:15:39', 'MDXJW'),
(8, 21, 6, 'ujian bakat', 1, 5, 'acak', '2021-06-22 08:58:00', '2021-06-22 09:00:04', 'KIDPV'),
(10, 23, 7, 'penalaran visual', 1, 5, 'acak', '2021-06-23 21:24:43', '2021-06-23 21:24:47', 'RPKVJ'),
(13, 22, 6, 'bakat', 1, 10, 'acak', '2021-06-25 15:35:00', '2021-06-25 15:40:00', 'DWQEF'),
(14, 26, 7, 'Penalaran Numerik', 10, 10, 'acak', '2021-06-26 10:37:00', '2021-06-26 10:41:20', 'JKHGI');

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `nim` char(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `kelas_id` int(11) NOT NULL COMMENT 'kelas&jurusan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama`, `nim`, `email`, `jenis_kelamin`, `kelas_id`) VALUES
(10, 'M.Fajri Zulianto', '10011234', 'Fajri01@gmail.com', 'L', 3),
(11, 'Fatkhur Rozi', '10024587', 'rozi@gmail.com', 'L', 10),
(12, 'Roy Bravi Zulfan', '10012456', 'Roy@gmail.com', 'L', 19),
(13, 'M.Misbachul Sifak', '10012765', 'sifak@gmail.com', 'L', 3),
(14, 'Asy Sam Fathir A.N', '10012987', 'isam01@gmail.com', 'L', 19),
(15, 'Erlangga Arif Putra Bakti', '10021897', 'Angga@gmail.com', 'L', 10),
(16, 'dandya', '6457577678', 'dandya@gmail.com', 'P', 15);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_soal`
--

CREATE TABLE `tb_soal` (
  `id_soal` int(11) NOT NULL,
  `guru_id` int(11) NOT NULL,
  `keterampilan_id` int(11) NOT NULL,
  `bobot` int(11) NOT NULL,
  `file` varchar(255) NOT NULL,
  `tipe_file` varchar(50) NOT NULL,
  `soal` longtext NOT NULL,
  `opsi_a` longtext NOT NULL,
  `opsi_b` longtext NOT NULL,
  `opsi_c` longtext NOT NULL,
  `opsi_d` longtext NOT NULL,
  `opsi_e` longtext NOT NULL,
  `file_a` varchar(255) NOT NULL,
  `file_b` varchar(255) NOT NULL,
  `file_c` varchar(255) NOT NULL,
  `file_d` varchar(255) NOT NULL,
  `file_e` varchar(255) NOT NULL,
  `jawaban` varchar(5) NOT NULL,
  `created_on` int(11) NOT NULL,
  `updated_on` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_soal`
--

INSERT INTO `tb_soal` (`id_soal`, `guru_id`, `keterampilan_id`, `bobot`, `file`, `tipe_file`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `file_a`, `file_b`, `file_c`, `file_d`, `file_e`, `jawaban`, `created_on`, `updated_on`) VALUES
(11, 4, 1, 1, '819713aa215c6d83df2e47d4a1f58ead.jpg', 'image/jpeg', '<p>rozi</p>', '<p>kasdasd</p>', '<p>asdasd</p>', '<p>asdasd</p>', '<p>asdasd</p>', '<p>asdad</p>', '', '', '', '', '', 'A', 1620441578, 1620441815),
(12, 20, 6, 1, '', '', '<p>asdasd</p>', '<p>dfgdfg</p>', '<p>wrertert</p>', '<p>fhgfgjjgh</p>', '<p>dfgdfg</p>', '<p>dfgdfg</p>', '', '', '', '', '', 'C', 1624324727, 1624324727),
(15, 21, 6, 1, 'e32f1e04f1410cb606a4fe43d5b3cc15.PNG', 'image/png', '<p>Pilih Gambar Untuk Melengkapi</p>', '<p>asdasd</p>', '<p>asdasd</p>', '<p>adsfsdg</p>', '<p>sfsdgdthyh</p>', '<p>ftheh</p>', '', '', '', '', '', 'B', 1624326878, 1624326878),
(25, 25, 9, 1, '6f3b6321d27f46d96d3648bb6c8cf074.JPG', 'image/jpeg', '<p>asdasd</p>', '<p>adsadasda</p>', '<p>asdasdasd</p>', '<p>asdasd</p>', '<p>asdasd</p>', '<p>asdasd</p>', '', '', '', '', '', 'C', 1624611395, 1624611408),
(26, 26, 7, 1, 'db87a4f5e7ecd9d03a60f98d1088148b.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>2</p>', '<p>1</p>', '<p>3</p>', '<p>5</p>', '<p>6</p>', '', '', '', '', '', 'B', 1624630451, 1624630451),
(27, 26, 7, 1, '80a57ab4f67420d9a0eb2e87c5bb5649.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>3</p>', '<p>5</p>', '<p>8</p>', '<p>6</p>', '<p>7</p>', '', '', '', '', '', 'C', 1624630502, 1624671232),
(28, 26, 7, 1, '7fe0d030170804ee61428015830c4f4f.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>3</p>', '<p>2</p>', '<p>1</p>', '<p>5</p>', '<p>4</p>', '', '', '', '', '', 'A', 1624630552, 1624671122),
(29, 26, 7, 1, '32e8df0a82c0cf16ba617d402ae02e2c.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>1</p>', '<p>3</p>', '<p>2</p>', '<p>4</p>', '<p>5</p>', '', '', '', '', '', 'C', 1624630613, 1624671113),
(30, 26, 7, 1, '23443da7898ea9dc7b081845b06d6019.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>5</p>', '<p>4</p>', '<p>3</p>', '<p>2</p>', '<p>1</p>', '', '', '', '', '', 'A', 1624630644, 1624671105),
(31, 26, 7, 1, '435fe922db15f406b08ee0a3c4cee423.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>13</p>', '<p>15</p>', '<p>17</p>', '<p>18</p>', '<p>20</p>', '', '', '', '', '', 'D', 1624630722, 1624671098),
(32, 26, 7, 1, '7fd34d282b7971bd9e5bb2454e984d4f.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>1</p>', '<p>2</p>', '<p>4</p>', '<p>3</p>', '<p>5</p>', '', '', '', '', '', 'D', 1624630764, 1624671089),
(33, 26, 7, 1, 'bcf565a28ee655ade0bbc313af90b90c.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>11</p>', '<p>12</p>', '<p>16</p>', '<p>17</p>', '<p>15</p>', '', '', '', '', '', 'E', 1624630811, 1624671080),
(34, 26, 7, 1, '336b703cd1ed872c68c136bc3168148f.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>32</p>', '<p>35</p>', '<p>31</p>', '<p>30</p>', '<p>39</p>', '', '', '', '', '', 'E', 1624630857, 1624671072),
(35, 26, 7, 1, '06c87d77e09d2c90497fc96df64df71e.jpg', 'image/jpeg', '<p>Lengkapi Angka Kosong Tersebut ?</p>', '<p>10</p>', '<p>12</p>', '<p>15</p>', '<p>20</p>', '<p>18</p>', '', '', '', '', '', 'D', 1624630890, 1624671065),
(36, 34, 16, 1, '5850f0a3f38e684c897db42ed08b1dfc.png', 'image/png', '<p>Jawab Sesuai Minat Yang Anda pilih </p>', '<p>A</p>', '<p>B</p>', '<p>C</p>', '<p>D</p>', '<p>E</p>', '', '', '', '', '', 'B', 1624672564, 1624673036),
(37, 34, 16, 1, 'd5c6a4cfad1cc293ce4e15b2914e3a50.png', 'image/png', '<p>Jawab Sesuai Minat Yang Anda pilih </p>', '<p>A</p>', '<p>B</p>', '<p>C</p>', '<p>D</p>', '<p>E</p>', '', '', '', '', '', 'C', 1624673083, 1624673115),
(38, 34, 16, 1, 'e4e34bfa0314533dcb397c417a61a86d.png', 'image/png', '<p>Jawab Sesuai Minat Yang Anda pilih </p>', '<p>A</p>', '<p>B</p>', '<p>C</p>', '<p>D</p>', '<p>E</p>', '', '', '', '', '', 'C', 1624673142, 1624673142),
(39, 34, 16, 1, '', '', '<p>Jawab Sesuai Minat Yang Anda pilih </p>', '<p>A</p>', '<p>B</p>', '<p>C</p>', '<p>D</p>', '<p>E</p>', '', '', '', '', '', 'D', 1624673175, 1624673175),
(40, 34, 16, 1, 'cda0a4559344497427ab0c754b69fa45.png', 'image/png', '<p>Jawab Sesuai Minat Yang Anda pilih </p>', '<p>A</p>', '<p>B</p>', '<p>C</p>', '<p>D</p>', '<p>E</p>', '', '', '', '', '', 'B', 1624673219, 1624673219),
(41, 34, 16, 1, 'b3f374d76255312d3497621f37464837.png', 'image/png', '<p>Jawab Sesuai Minat Yang Anda pilih </p>', '<p>A</p>', '<p>B</p>', '<p>C</p>', '<p>D</p>', '<p>E</p>', '', '', '', '', '', 'E', 1624673245, 1624673245);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `activation_selector` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `forgotten_password_selector` varchar(255) DEFAULT NULL,
  `forgotten_password_code` varchar(255) DEFAULT NULL,
  `forgotten_password_time` int(11) UNSIGNED DEFAULT NULL,
  `remember_selector` varchar(255) DEFAULT NULL,
  `remember_code` varchar(255) DEFAULT NULL,
  `created_on` int(11) UNSIGNED NOT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `email`, `activation_selector`, `activation_code`, `forgotten_password_selector`, `forgotten_password_code`, `forgotten_password_time`, `remember_selector`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'Administrator', '$2y$12$tGY.AtcyXrh7WmccdbT1rOuKEcTsKH6sIUmDr0ore1yN4LnKTTtuu', 'dandy@admin.com', NULL, '', NULL, NULL, NULL, NULL, NULL, 1268889823, 1624676206, 1, 'Admin', 'Dandy', 'ADMIN', '0'),
(14, '::1', '01234567', '$2y$10$sHiq6DrjJDlN0.v3sRXEtuyhaH7NbcniLDt9/UDOY2Rsf8m5HKJFC', 'abi@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1619426517, NULL, 1, 'abi', 'abi', NULL, NULL),
(18, '::1', '202020202', '$2y$10$FAZSDq9Zt4IbMDayU.9aAOUt7ziprzIpWtKM6KzdbEeQIl.YET34y', 'guru@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1619426532, 1621226479, 1, 'Baru', 'guru', NULL, NULL),
(24, '::1', '345234567', '$2y$10$WSsvaFaLo.7U9iZRBQcOUuo5rnT5zuJ3KLdNkiYPERI.0.fxvXpq6', 'new@nw.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1619849419, 1619849668, 1, 'new', 'new', NULL, NULL),
(25, '::1', '12121212', '$2y$10$x3WqqQzBNVvFZMBUqgyC7.CZZ4NkEhYTNmALswb9w7YY13mcSzTJC', 'amarta@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624325039, NULL, 1, 'Mohammad', 'S', NULL, NULL),
(27, '::1', '10101010', '$2y$10$IxOT9zrYCehx1jEczD8ls.O/IzaP2RrRZduyWQOLB93dVqpG8.e4y', 'isam@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624325377, 1624327139, 1, 'isam', 'isam', NULL, NULL),
(28, '::1', '100112498', '$2y$10$40OTCDUfQFHCrpFaRjLZ.ezm4wR6ZA4vKTPCv8gz1AxH9842D2g8e', 'Fajri@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624448595, NULL, 1, 'M.Fajri', 'Zulianto', NULL, NULL),
(29, '::1', '10024587', '$2y$10$Gj6s4idWdR9k.bpBtnvO1.AlZqX/aDsu2yuQxxwtgXqnAC1Vt91dW', 'rozi@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624448646, 1624495354, 1, 'Fatkhur', 'Rozi', NULL, NULL),
(30, '::1', '10011234', '$2y$10$fFKgWI6dFh4DAenTxk8gZ.MUSQZQbP2VJRptYYK9jfyoMtHxLF74y', 'Fajri01@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624448695, 1624678632, 1, 'M.Fajri', 'Zulianto', NULL, NULL),
(31, '::1', '10012456', '$2y$10$NN3dxAm9FN4yyjiyze/uhex84mPPCVp0ofhfY0ECtjKeWeu37Bdb2', 'Roy@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624448830, NULL, 1, 'Roy', 'Zulfan', NULL, NULL),
(32, '::1', '10012765', '$2y$10$vFDyYvdhdwMYFi3SCk8QHeQB5j1D/jpEbDfpJ5VdICzza2UaMULXa', 'sifak@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624448833, NULL, 1, 'M.Misbachul', 'Sifak', NULL, NULL),
(33, '::1', '10012987', '$2y$10$sWYbxjUI76Eun13kAx9InO8pZLTF69I/kvK.GggYx7LmIyOM9BFoC', 'isam01@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624448999, NULL, 1, 'Asy', 'A.N', NULL, NULL),
(34, '::1', '10021897', '$2y$10$QxroRmlJrnrLuhlIpmVmN...VXQtKU1FbgKVeH3C9JdO59gLKLf3.', 'Angga@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624449002, NULL, 1, 'Erlangga', 'Bakti', NULL, NULL),
(35, '::1', '1965091620', '$2y$10$IYRtOKIsvy7KCDqRMF8aEuydfzS0LkdUdmyGWw9Tnt9LQ.oIyFKd6', 'Miftahul@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624450773, 1624630058, 1, 'Miftachul', 'Choir', NULL, NULL),
(38, '::1', '1965091601', '$2y$10$/sZ2enwxmjKGwPPnjkq/pejtYfN6uh1cFVhSc5vF7oKM/zA1Vu/aK', 'Latif@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624618598, 1624679907, 1, 'Ahmad', 'Latif', NULL, NULL),
(39, '::1', '1965091602', '$2y$10$D0bllvQIyG7lgBgvV05VgeZIfST5j9cRw/D2yIiqd3GRP3q2MY5RO', 'sulistina@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624618601, NULL, 1, 'sulistina', 'sulistina', NULL, NULL),
(40, '::1', '1965091603', '$2y$10$oH1cKLlHxgZ9O0/8vbAwNOOa2Z.ONYiR7zeH/qSWtG9zKQgdeHW/i', 'Agung@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624618603, NULL, 1, 'Agung', 'Agung', NULL, NULL),
(41, '::1', '1965091604', '$2y$10$yEkFQchClZ8mU.ixeE8qMezPik0wAkOiTKDKKw9OIMdOI7O..wtwy', 'chariri@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624618605, NULL, 1, 'Chariri', 'Chariri', NULL, NULL),
(42, '::1', '1965091606', '$2y$10$HFeEpKHJS8t4YxcR8Whu5.qnYQSOu2W..okkFtvRw13l9lohEax7u', 'yuli@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624618750, NULL, 1, 'Yuli', 'Yuli', NULL, NULL),
(43, '::1', '1965091605', '$2y$10$ipL/3ewE6jjluWK7E5.c5OhN.dr1DNSTu55MrJ6gLEYLa8Tnq6Vh6', 'riski@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624618753, NULL, 1, 'riski', 'bactiar', NULL, NULL),
(44, '::1', '1965091607', '$2y$10$jH6PRwgcpTCxD0J5shugdONG6Ygg2HdxbRSuLK.sbX.wDpbgZMunm', 'ayu@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624618770, NULL, 1, 'ayu', 'ayu', NULL, NULL),
(45, '::1', '6457577678', '$2y$10$0r9BO8JKsWNOxEtIrVz6K.vmeaHfnSVf/sJVFSGutZLMCsiTv8zsW', 'dandya@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624618824, NULL, 1, 'dandya', 'dandya', NULL, NULL),
(46, '::1', '1965091608', '$2y$10$oPhn6H1GL0xPhvgE1BoUneB2NYg0tU0DtFHYl2tbASgiNpSlvEX/y', 'rudi@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624619152, NULL, 1, 'Rudi', 'Rudi', NULL, NULL),
(47, '::1', '1965091609', '$2y$10$8rJ5AFF64CivnVIRbivA3uJaT3di6/4DNbhqk.eCpxVqqpOrToznG', 'diah@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1624619154, 1624672351, 1, 'diah', 'diah', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users_groups`
--

CREATE TABLE `users_groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(3, 1, 1),
(16, 14, 2),
(20, 18, 2),
(26, 24, 2),
(27, 25, 3),
(29, 27, 3),
(30, 28, 3),
(31, 29, 3),
(32, 30, 3),
(33, 31, 3),
(34, 32, 3),
(35, 33, 3),
(36, 34, 3),
(37, 35, 2),
(40, 38, 2),
(41, 39, 2),
(42, 40, 2),
(43, 41, 2),
(44, 42, 2),
(45, 43, 2),
(46, 44, 2),
(47, 45, 3),
(48, 46, 2),
(49, 47, 2);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `guru`
--
ALTER TABLE `guru`
  ADD PRIMARY KEY (`id_guru`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nip` (`nip`),
  ADD KEY `matkul_id` (`keterampilan_id`);

--
-- Indeks untuk tabel `h_ujian`
--
ALTER TABLE `h_ujian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ujian_id` (`ujian_id`),
  ADD KEY `siswa_id` (`siswa_id`) USING BTREE;

--
-- Indeks untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id_jurusan`);

--
-- Indeks untuk tabel `jurusan_keterampilan`
--
ALTER TABLE `jurusan_keterampilan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jurusan_id` (`jurusan_id`),
  ADD KEY `keterampilan_id` (`keterampilan_id`) USING BTREE;

--
-- Indeks untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `jurusan_id` (`jurusan_id`);

--
-- Indeks untuk tabel `kelas_guru`
--
ALTER TABLE `kelas_guru`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kelas_id` (`kelas_id`),
  ADD KEY `dosen_id` (`guru_id`);

--
-- Indeks untuk tabel `keterampilan`
--
ALTER TABLE `keterampilan`
  ADD PRIMARY KEY (`id_keterampilan`);

--
-- Indeks untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `m_ujian`
--
ALTER TABLE `m_ujian`
  ADD PRIMARY KEY (`id_ujian`),
  ADD KEY `keterampilan_id` (`keterampilan_id`) USING BTREE,
  ADD KEY `guru_id` (`guru_id`) USING BTREE;

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`),
  ADD UNIQUE KEY `nim` (`nim`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `kelas_id` (`kelas_id`);

--
-- Indeks untuk tabel `tb_soal`
--
ALTER TABLE `tb_soal`
  ADD PRIMARY KEY (`id_soal`),
  ADD KEY `keterampilan_id` (`keterampilan_id`) USING BTREE,
  ADD KEY `guru_id` (`guru_id`) USING BTREE;

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_activation_selector` (`activation_selector`),
  ADD UNIQUE KEY `uc_forgotten_password_selector` (`forgotten_password_selector`),
  ADD UNIQUE KEY `uc_remember_selector` (`remember_selector`),
  ADD UNIQUE KEY `uc_email` (`email`) USING BTREE;

--
-- Indeks untuk tabel `users_groups`
--
ALTER TABLE `users_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  ADD KEY `fk_users_groups_users1_idx` (`user_id`),
  ADD KEY `fk_users_groups_groups1_idx` (`group_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `groups`
--
ALTER TABLE `groups`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `guru`
--
ALTER TABLE `guru`
  MODIFY `id_guru` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT untuk tabel `h_ujian`
--
ALTER TABLE `h_ujian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  MODIFY `id_jurusan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `jurusan_keterampilan`
--
ALTER TABLE `jurusan_keterampilan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `kelas_guru`
--
ALTER TABLE `kelas_guru`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT untuk tabel `keterampilan`
--
ALTER TABLE `keterampilan`
  MODIFY `id_keterampilan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT untuk tabel `m_ujian`
--
ALTER TABLE `m_ujian`
  MODIFY `id_ujian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `tb_soal`
--
ALTER TABLE `tb_soal`
  MODIFY `id_soal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT untuk tabel `users_groups`
--
ALTER TABLE `users_groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `siswa_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id_kelas`);

--
-- Ketidakleluasaan untuk tabel `users_groups`
--
ALTER TABLE `users_groups`
  ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
