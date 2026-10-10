# Dokumen Kebutuhan Data Proyek: Perpustakaan
**Penyusun:** Daffa Bima Perdana
**NPM: ** 25430124
**Kelas:** D  
**Mata Kuliah:** Praktikum Basis Data  
---

## 1. Profil Organisasi dan lingkup Layanan
** Sistem Pelayanan Peminjaman Buku Perpustakaan merupakan sistem informasi berbasis digital yang melayani pengelolaan bahan pustaka dan prosedur transaksi peminjaman buku. Ruang lingkup sistem mencakup pengelolaan katalog buku dan kategori, pendaftaran anggota, pemrosesan transaksi peminjaman dan pengembalian, perhitungan denda keterlambatan, serta pencatatan stok buku dan ulasan bacaan.

## 2. Proses Bisnis (PB)
* PB-01 (Registrasi dan Autentikasi Anggota): Anggota mendaftarkan akun baru dengan mengisi identitas dasar serta kontak, kemudian sistem mencatat data akun untuk kebutuhan autentikasi masuk ke platform perpustakaan.
* PB-02 (Manajemen Katalog dan Stok Buku): Admin/Pustakawan mengelola data buku, kategori/klasifikasi buku, penerbit/pengarang, dan memperbarui stok/jumlah ketersediaan buku di rak perpustakaan.
* PB-03 (Peminjaman dan Transaksi Pengajuan Buku): Anggota memilih buku yang ingin dipinjam ke dalam daftar pinjaman, menentukan durasi/tanggal peminjaman, dan membuat transaksi pengajuan peminjaman buku.
* PB-04 (Konfirmasi Pengembalian dan Pelunasan Denda): Anggota melakukan pengembalian buku atau pelunasan denda keterlambatan (jika ada), kemudian admin/sistem memvalidasi status peminjaman menjadi selesai/dikembalikan.
* PB-05 (Pengelolaan Ulasan dan Resensi Buku): Anggota yang telah menyelesaikan peminjaman dapat memberikan rating dan ulasan teks/resensi terhadap buku yang telah dibaca.
