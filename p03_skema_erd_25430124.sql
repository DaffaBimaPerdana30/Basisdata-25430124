-- 1. Buat dan gunakan database
CREATE DATABASE IF NOT EXISTS db_perpustakaan;
USE db_perpustakaan;

-- 2. Tabel Kategori Buku
CREATE TABLE kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(50) NOT NULL,
    keterangan TEXT
) ENGINE=InnoDB;

-- 3. Tabel Buku
CREATE TABLE buku (
    id_buku INT AUTO_INCREMENT PRIMARY KEY,
    id_kategori INT NOT NULL,
    judul_buku VARCHAR(150) NOT NULL,
    penulis VARCHAR(100) NOT NULL,
    penerbit VARCHAR(100) NOT NULL,
    tahun_terbit YEAR NOT NULL,
    stok INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_buku_kategori 
        FOREIGN KEY (id_kategori) 
        REFERENCES kategori(id_kategori) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Tabel Anggota Perpustakaan
CREATE TABLE anggota (
    id_anggota VARCHAR(20) PRIMARY KEY, -- Contoh: ANG001
    nama_anggota VARCHAR(100) NOT NULL,
    alamat TEXT NOT NULL,
    nomor_telepon VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE
) ENGINE=InnoDB;

-- 5. Tabel Petugas / Admin Perpustakaan
CREATE TABLE petugas (
    id_petugas INT AUTO_INCREMENT PRIMARY KEY,
    nama_petugas VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Disimpan dalam bentuk hash
    jabatan VARCHAR(50)
) ENGINE=InnoDB;

-- 6. Tabel Peminjaman (Transaksi & Relasi Many-to-Many antara Anggota, Buku, dan Petugas)
CREATE TABLE peminjaman (
    id_peminjaman INT AUTO_INCREMENT PRIMARY KEY,
    id_anggota VARCHAR(20) NOT NULL,
    id_buku INT NOT NULL,
    id_petugas INT NOT NULL,
    tanggal_pinjam DATE NOT NULL,
    tanggal_jatuh_tempo DATE NOT NULL,
    tanggal_kembali DATE NULL, -- Bernilai NULL jika belum dikembalikan
    denda DECIMAL(10,2) DEFAULT 0.00,
    status_peminjaman ENUM('Dipinjam', 'Kembali', 'Hilang') DEFAULT 'Dipinjam',
    
    -- Penerapan Foreign Key & Integritas Referensial
    CONSTRAINT fk_pinjam_anggota 
        FOREIGN KEY (id_anggota) 
        REFERENCES anggota(id_anggota) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_pinjam_buku 
        FOREIGN KEY (id_buku) 
        REFERENCES buku(id_buku) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_pinjam_petugas 
        FOREIGN KEY (id_petugas) 
        REFERENCES petugas(id_petugas) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;