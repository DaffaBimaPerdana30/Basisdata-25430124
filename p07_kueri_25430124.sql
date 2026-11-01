-- MILESTONE PROYEK : SKRIP KUERI SATU TABEL (perpus_124)
-- Mahasiswa        : Daffa Bima Perdana
-- NPM              : 25430124
-- Basis Data       : perpus_124
-- Deskripsi        : Kumpulan 10 kueri satu tabel untuk mendukung Kebutuhan Informasi (KI) operasional perpustakaan.
-- Syarat           : Menggunakan LIKE, BETWEEN, IN, IS NULL, CASE, fungsi tanggal, dan fungsi string sesuai struktur tabel perpustakaan.


USE perpus_124;


-- ---------------------------------------------------------------------
-- KUERI 1      : Pencarian Buku Menggunakan Pola Kata Kunci pada Judul
-- Syarat       : LIKE, Fungsi String (LOWER)
-- Kode KI      : KI-01
-- Pertanyaan   : Cari judul buku dengan kata kunci 'Pemrograman' atau 'Database'?
-- Ekspektasi   : Menampilkan buku yang judulnya cocok dengan pola kata kunci.
SELECT 
    id_buku, 
    id_kategori, 
    judul_buku, 
    penulis, 
    penerbit, 
    tahun_terbit, 
    stok, 
    stok_min_buku,
FROM buku
WHERE LOWER(judul_buku) LIKE '%pemrograman%' 
   OR LOWER(judul_buku) LIKE '%database%';
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- KUERI 2      : Penyaringan Rentang Tahun Terbit Buku
-- Syarat       : BETWEEN
-- Kode KI      : KI-02
-- Pertanyaan   : Filter buku yang diterbitkan dalam rentang tahun 2024 s/d 2026?
-- Ekspektasi   : Daftar buku terbitan periode terbaru.
SELECT 
    id_buku, 
    id_kategori, 
    judul_buku, 
    penulis, 
    penerbit, 
    tahun_terbit, 
    stok, 
    stok_min_buku,
FROM buku
WHERE tahun_terbit BETWEEN 2024 AND 2026
ORDER BY tahun_terbit ASC;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- KUERI 3      : Pengelompokan Berdasarkan ID Kategori Tertentu
-- Syarat       : IN
-- Kode KI      : KI-03
-- Pertanyaan   : Tampilkan buku yang masuk ke dalam kategori dengan ID tertentu (misal: 1 atau 2)?
-- Ekspektasi   : Baris buku dari kategori pilihan.
SELECT 
    id_buku, 
    id_kategori, 
    judul_buku, 
    penulis, 
    penerbit, 
    tahun_terbit, 
    stok, 
    stok_min_buku,
FROM buku
WHERE id_kategori IN (1, 2)
ORDER BY id_kategori, judul_buku;
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- KUERI 4      : Audit Peminjaman Tanpa Nomor Anggota Terdaftar (Tamu/Umum)
-- Syarat       : IS NULL
-- Kode KI      : KI-04
-- Pertanyaan   : Peminjaman mana saja yang tercatat dengan id_anggota kosong (NULL)?
-- Ekspektasi   : Riwayat peminjaman dengan kolom id_anggota yang kosong.
SELECT 
    id_peminjaman, 
    id_anggota,
    id_buku,
    id_petugas,
    tanggal_pinjam,
    tanggal_jatuh_tempo,
    tanggal_kembali, 
    status_peminjaman,
    denda,
FROM peminjaman
WHERE id_anggota IS NULL;
-- ---------------------------------------------------------------------





-- ---------------------------------------------------------------------
-- KUERI 5      : Klasifikasi Tingkat Ketersediaan Stok Fisik Buku
-- Syarat       : CASE
-- Kode KI      : KI-05
-- Pertanyaan   : Bagaimana status ketersediaan stok fisik buku dibandingkan batas minimumnya?
-- Ekspektasi   : Status stok: Kritis, Waspada, atau Aman.
SELECT 
    id_buku, 
    id_kategori, 
    judul_buku, 
    penulis, 
    penerbit, 
    tahun_terbit, 
    stok, 
    stok_min_buku,
    CASE 
        WHEN stok = 0 THEN 'Habis'
        WHEN stok <= stok_min_buku THEN 'Menipis'
        ELSE 'Tersedia'
    END AS status_stok
FROM buku;
ORDER BY stok ASC;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- KUERI 6      : Rekapitulasi Peminjaman Periode Tertentu (Oktober 2026)
-- Syarat       : Fungsi Tanggal (YEAR, MONTH, DATEDIFF)
-- Kode KI      : KI-06
-- Pertanyaan   : Peminjaman buku apa saja yang terjadi pada Oktober 2026 dengan durasi pinjam di atas 7 hari?
-- Ekspektasi   : Data peminjaman pada periode target sesuai kriteria durasi.
SELECT 
    id_peminjaman, 
    id_anggota,
    id_buku,
    id_petugas,
    tanggal_pinjam,
    tanggal_kembali, 
    denda,
    DATEDIFF(tanggal_jatuh_tempo, tanggal_pinjam) AS durasi_hari,
    status_peminjaman
FROM peminjaman
WHERE YEAR(tanggal_pinjam) = 2026 
  AND MONTH(tanggal_pinjam) = 10
  AND DATEDIFF(tanggal_jatuh_tempo, tanggal_pinjam) > 7
ORDER BY tanggal_pinjam ASC;
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- KUERI 7      : Standardisasi Format Teks Nama Anggota & Panjang Digit Kontak
-- Syarat       : UPPER, CONCAT, LENGTH
-- Kode KI      : KI-07
-- Pertanyaan   : Bagaimana tampilan nama anggota dalam huruf kapital serta panjang nomor teleponnya?
-- Ekspektasi   : Profil anggota dengan format teks standar dan validitas digit nomor telepon.
SELECT 
    id_anggota, 
    UPPER(nama_anggota) AS nama_kapital, 
    CONCAT('+62', SUBSTRING(nomor_telepon, 2)) AS nomor_internasional,
    LENGTH(nomor_telepon) AS panjang_digit_telepon
FROM anggota
ORDER BY nama_anggota ASC;
-- ---------------------------------------------------------------------






-- ---------------------------------------------------------------------
-- KUERI 8      : Perhitungan Durasi Waktu Sejak Anggota Terdaftar
-- Syarat       : DATEDIFF, CURDATE (atau fungsi logis tanggal berbasis transaksi)
-- Kode KI      : KI-08
-- Pertanyaan   : Berapa lama rentang hari dari tanggal pinjam hingga tanggal kembali pada transaksi peminjaman?
-- Ekspektasi   : Kolom durasi penyelesaian peminjaman dalam satuan hari.
SELECT 
    id_peminjaman, 
    id_anggota,
    id_buku,
    id_petugas,
    tanggal_pinjam,
    tanggal_jatuh_tempo,
    status_peminjaman,
    denda,
    DATEDIFF(tanggal_kembali, tanggal_pinjam) AS lama_peminjaman_hari
FROM peminjaman
WHERE status_peminjaman = 'Kembali'
ORDER BY tanggal_pinjam ASC;
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- KUERI 9      : Penyaringan Denda Peminjaman Bernilai Tinggi
-- Syarat       : Operator Logika & Perbandingan
-- Kode KI      : KI-09
-- Pertanyaan   : Transaksi peminjaman mana saja yang dikenakan denda di atas Rp 5.000?
-- Ekspektasi   : Detail peminjaman dengan nominal denda pelanggaran tinggi.
SELECT 
    id_peminjaman, 
    id_anggota, 
    id_buku, 
    id_petugas, 
    tanggal_pinjam, 
    tanggal_jatuh_tempo, 
    tanggal_kembali, 
    CONCAT('Rp ', FORMAT(denda, 0, 'id_ID')) AS denda_rupiah, 
    status_peminjaman
FROM peminjaman;
WHERE denda > 5000.00
ORDER BY denda DESC;
-- ---------------------------------------------------------------------




-- ---------------------------------------------------------------------
-- KUERI 10     : Pengelompokan Status Peminjaman Berdasarkan Kondisi
-- Syarat       : CASE, Relasional
-- Kode KI      : KI-10
-- Pertanyaan   : Bagaimana kategorisasi kondisi denda dan status pengembalian buku?
-- Ekspektasi   : Label kategori penalti atau kedisiplinan pengembalian peminjam.
SELECT 
    id_peminjaman, 
    id_anggota,
    id_buku,
    id_petugas,
    tanggal_pinjam,
    tanggal_jatuh_tempo,
    tanggal_kembali, 
    status_peminjaman,
    denda,
    CASE 
        WHEN denda > 6000 THEN 'Pelanggaran Berat (Denda Tinggi)'
        WHEN denda > 0 THEN 'Terlambat (Denda Ringan)'
        ELSE 'Tepat Waktu / Tanpa Denda'
    END AS kategori_kedisiplinan
FROM peminjaman
ORDER BY denda DESC;
-- ---------------------------------------------------------------------


-- CATATAN KEBUTUHAN INFORMASI (KI) BERIKUTNYA (MULTI-TABLE JOIN):
-- 1. Rekapitulasi peminjaman lengkap dengan nama anggota, judul buku, dan nama petugas.
-- 2. Pencarian kategori buku secara spesifik menggunakan nama kategori teks.




























SELECT 
    id_buku, 
    id_kategori, 
    UPPER(judul_buku) AS judul_buku, 
    penulis, 
    penerbit, 
    tahun_terbit, 
    stok, 
    stok_min_buku
FROM buku;






