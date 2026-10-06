TUGAS PRAKTIKUM BASIS DATA - MODUL 1
Berkas      : p01_lingkungan_25430124.sql
Basis Data  : perpus_124
Karakter    : utf8mb4 / utf8mb4_unicode_ci
========================================================

1. Pembuatan Basis Data Utama (Idempotent)
a. Buat database utama
CREATE DATABASE IF NOT EXISTS perpus_124
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

2. Pembuatan Akun Mahasiswa / Pengembang Utama
b. Buat akun utama digunakan untuk hak akses penuh perpus_124
CREATE USER IF NOT EXISTS 'mhs_124'@'localhost' 
  IDENTIFIED BY 'PodoMbiyen';

GRANT ALL PRIVILEGES ON perpus_124* TO 'mhs_124'@'localhost';

3. Pembuatan Akun Anggota / Pembaca
c. Buat akun tamu atau anggota
CREATE USER IF NOT EXISTS 'tamu_124'@'localhost' 
  IDENTIFIED BY 'PodoMbiyen';

GRANT SELECT ON toko_115.* TO 'tamu_124'@'localhost';

4. Terapkan Hak Akses
d. Simpan perubahan
FLUSH PRIVILEGES;
