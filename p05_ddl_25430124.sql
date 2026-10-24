DROP DATABASE IF EXISTS perpus_124;
CREATE DATABASE perpus_124 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE perpus_124;


CREATE TABLE kategori (
    id_kategori INT(11) NOT NULL AUTO_INCREMENT,
    nama_kategori VARCHAR(50) NOT NULL,
    keterangan TEXT NULL,
    CONSTRAINT pk_kategori PRIMARY KEY (id_kategori)
) ENGINE=InnoDB;


CREATE TABLE buku (
    id_buku INT(11) NOT NULL AUTO_INCREMENT,
    id_kategori INT(11) NOT NULL,
    judul_buku VARCHAR(150) NOT NULL,
    penulis VARCHAR(100) NOT NULL,
    penerbit VARCHAR(100) NULL,
    tahun_terbit YEAR(4) NULL,
    stok INT(11) NOT NULL DEFAULT 0,
    stok_min_buku INT(11) NOT NULL DEFAULT 0,
    CONSTRAINT pk_buku PRIMARY KEY (id_buku),
    CONSTRAINT chk_stok_buku CHECK (stok >= 0),
    CONSTRAINT chk_stok_min_buku CHECK (stok_min_buku >= 0),
    CONSTRAINT fk_buku_kategori FOREIGN KEY (id_kategori)
        REFERENCES kategori(id_kategori)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE anggota (
    id_anggota VARCHAR(20) NOT NULL,
    nama_anggota VARCHAR(100) NOT NULL,
    alamat TEXT NULL,
    nomor_telepon VARCHAR(15) NOT NULL,
    email VARCHAR(100) NULL,
    CONSTRAINT pk_anggota PRIMARY KEY (id_anggota),
    CONSTRAINT chk_nomor_telepon_format CHECK (LENGTH(nomor_telepon) >= 10)
) ENGINE=InnoDB;


CREATE TABLE petugas (
    id_petugas INT(11) NOT NULL AUTO_INCREMENT,
    nama_petugas VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    jabatan VARCHAR(50) NULL,
    CONSTRAINT pk_petugas PRIMARY KEY (id_petugas),
    CONSTRAINT uq_petugas_username UNIQUE (username)
) ENGINE=InnoDB;


    id_peminjaman INT(11) NOT NULL AUTO_INCREMENT,
    id_anggota VARCHAR(20) NULL,
    id_buku INT(11) NOT NULL,
    id_petugas INT(11) NOT NULL,
    tanggal_pinjam DATE NOT NULL,
    tanggal_jatuh_tempo DATE NOT NULL,
    tanggal_kembali DATE NULL,
    denda DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status_peminjaman ENUM('Dipinjam', 'Kembali', 'Hilang') NOT NULL DEFAULT 'Dipinjam',
    CONSTRAINT pk_peminjaman PRIMARY KEY (id_peminjaman),
    CONSTRAINT chk_denda CHECK (denda >= 0),
    CONSTRAINT fk_peminjaman_anggota FOREIGN KEY (id_anggota)
        REFERENCES anggota(id_anggota)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_peminjaman_buku FOREIGN KEY (id_buku)
        REFERENCES buku(id_buku)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_peminjaman_petugas FOREIGN KEY (id_petugas)
        REFERENCES petugas(id_petugas)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

