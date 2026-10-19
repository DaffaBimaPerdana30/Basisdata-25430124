# Milestone Proyek 04: Normalisasi Basis Data
* Nama : Daffa Bima Perdana
* NPM : 25430124
* Kelas : D
* Pertemuan Ke-04
* Tanggal Pelaksanaan : 14 Oktober 2026
* Dosen Pengampu : Dedi Irawan, S.Kom., M.T.I.
---
## 1. Dokumen Sumber dan Skema Bentuk UNF
Analisis normalisasi diawali dengan memeriksa dokumen Kartu / Bukti Peminjaman Buku Perpustakaan (sebagaimana dirumuskan pada dokumen kebutuhan Pertemuan 2). Dokumen mentah tersebut mencatat beberapa judul buku dalam satu kali transaksi peminjaman, yang memicu kemunculan kelompok berulang (repeating groups).

### A. Format Dokumen Sumber
```text
Nomor Bukti Peminjaman : PMJ0001
Tanggal Peminjaman     : 2026-10-12
ID Anggota             : P001
Nama Anggota           : Daffa
Nomor Handphone        : 081234567890
----------------------------------------------------------------------------------
ID Buku | Judul Buku              | Kategori   | Tarif Denda/Hari | Jumlah Pinjam
----------------------------------------------------------------------------------
BK01    | Algoritma & Pemrograman | Komputer   | Rp 3.000         | 1
BK02    | Basis Data Relasional   | Komputer   | Rp 3.000         | 1
----------------------------------------------------------------------------------
Batas Tanggal Pengembalian : 2026-10-19
Maksimal Pinjam            : 2 Eksemplar
```

### B. Notasi Skema Relasi UNF
```text
Peminjaman_UNF (
    no_peminjaman,
    tgl_pinjam,
    id_anggota,
    nama_anggota,
    no_hp,
    daftar_buku(id_buku, judul_buku, kategori_buku, tarif_denda_per_hari, qty, subtotal_denda),
    total_denda,
)
```
### C. Simulasi Tabel UNF
| no_pesanan | tgl_pesan | id_anggota | nama_anggota | no_hp | daftar_barang | total_bayar |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| PMJ0001 | 2026-10-12 | P001 | Daffa | 081234567890 | BK03 (Laskar Pelangi, Novel, 3000, 2, 6000), BK04 (Bumi Manusia, Sastra, 3000, 1, 3000)| 9000 |
| PMJ0002 | 2026-10-13 | P002 | Bima | 089876543210 | B03 (Laskar Pelangi, Novel, 3000, 1, 3000), BK01 (Algoritma & Pemrograman, Komputer, 3000, 1, 3000) | 6000 |

## 2. Dependensi Fungsional dan Aturan Bisnis
* AB01 (Identitas Anggota) merupakan setiap anggota yang terdaftar memiliki tanda pengenal yang unik berupa id_anggota yang dapat digunakan untuk menentukan identitas profil secara tunggal.

       id_anggota --> nama_anggota, no_telp, tgl_daftar

* AB02 (Katalog Buku) merupakan Setiap buku diidentifikasi secara unik oleh id_buku yang menentukan judul, klasifikasi kategori, tarif denda per hari, dan sisa stok fisik.

        id_buku --> judul_buku, kategori_buku, tarif_denda_perhari, stok

* AB03 (Header Transaksi Peminjaman) difungsikan sebagai setiap transaksi peminjaman diidentifikasi oleh id_peminjaman yang menunjukan waktu terjadinya transaksi, anggota yang meminjam dan total denda akhir.

        id_peminjaman --> tgl_peminjaman, id_anggota, total_denda
    
* AB04 Rincian Item Peminjaman. pada tahap ini, banyaknya buku yang dipinjam dan tarif denda kesepakatan transaksi ditentukan secara bersama-sama oleh transaksi peminjaman dan buku tertentu.

        id_peminjaman, id_buku --> stok_peminjaman,_ tarif_denda_peminjaman

* AB05 Pencatatan Riwayat denda.pada tahap ini, setiap mutasi pembayaran dan akumulasi denda dicatat secara unik pada id_denda yang dapat merekan pemilik akun, transaksi peminjaman buku, besaran denda dan waktu pencatata.

        id_denda --> id_anggota, id_peminjaman, jumlah_denda, tgl_denda

## 3. Tahapan Normalisasi
### A. Tahapan 1NF
Pada tahapan ini setiap kolom harus bernilai dan tidak ada perulangan kolom sejenis. tindakan yang dilakukan yaitu menghilangkan kelompok berurai pada daftar_buku menjadi baris individual sehingga setiap baris hanya mempresentasikan satu jenis buku yang dipinjam per nomor peminjaman.

        {no_peminjaman, id_buku}

Berikut ini contoh simulasi tabel 1NF

| no_peminjaman | tgl_pinjam | id_anggota | nama_anggota | no_hp | total_denda | id_buku | judul_buku | kategori | tarif_denda | qty | subtotal_denda |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| PMJ0001 | 2026-10-12 | P001 | Daffa | 081234567890 | 9000 | BK001 | Laskar Pelangi | Novel | 3000 | 2 | 6000 |
| PMJ0001 | 2026-10-12 | P001 | Daffa | 081234567890 | 9000 | BK002 | Bumi Manusia | Sastra | 3000 | 1 | 3000 |
| PMJ0002 | 2026-10-13 | P002 | Bima | 089876543210 | 3000 | BK001 | Laskar Pelangi | Novel | 3000 | 1 | 3000 |
### B. Tahapan 2NF

Pada tahapan ini syarat memenuhi1NF dan tidak boleh ada ketergantungan parsial. semua atribut non-kunci harus bergantung sepenuhnya pada Primary Key, bukan hanya sebagai elemen kunci komposit.
* Analisis komposit pada 1NF 
                
        {no_peminjaman, id_buku}
* id_buku memiliki atribut judul_buku, kategori_buku dan tarif_denda.
* no_peminjaman memiliku atribut tgl_pinjam, id_anggota, no_telp dan tarif_denda

Solusi dari Dekomposisi yaitu dengan memecah menjadi 3 tabel yaitu tabel peminjaman header, tabel katalog buku dan tabel asosiatif detail peminjaman.


### 1. Tabel Peminjaman Header dengan kunci utama no_peminjaman

| no_peminjaman (PK) | tgl_pinjam | id_anggota | nama_anggota | no_hp | total_denda |
| :--- | :--- | :--- | :--- | :--- | :--- |
| PMJ0001 | 2026-10-12 | P001 | Daffa | 081234567890 | 9000 |
| PMJ0002 | 2026-10-13 | P002 | Bima | 089876543210 | 3000 |


### 2. Tabel Master Buku dengan kunci utama id_buku

| id_buku (PK) | judul_buku | kategori | tarif_denda |
| :--- | :--- | :--- | :--- |
| BK001 | Laskar Pelangi | Novel | 3000 |
| BK002 | Bumi Manusia | Sastra | 3000 |


### 3. Tabel Detail Peminjaman dengan kunci utama no_peminjaman, id_buku

| no_peminjaman (PK, FK) | id_buku (PK, FK) | qty | tarif_denda_detail |
| :--- | :--- | :--- | :--- |
| PMJ0001 | BK001 | 2 | 6000 |
| PMJ0001 | BK002 | 1 | 3000 |
| PMJ0002 | BK001 | 1 | 3000 |

### C. Tahapan 3NF

Pada tahap ini syarat yang harus terpenuhi yaitu 2NF dan tidak boleh ada ketergantungan transitif dan atribut non-kunci tidak boleh bergantung pada stribut non-kunci lainnya.
* Analisis Pelanggaran pada 2NF pada tabel peminjaman_deader

        no_peminjaman --> id_anggota --> {nama_anggota, no_telp}
Atribut nama_anggota dan no_hp bergantung fungsional pada atribut non-kunci id_anggota. Ini menimbulkan anomali pembaruan (jika nomor HP berganti) dan redundansi data.

Solusi dari dekomposisinya adalah Memisahkan entitas data anggota ke dalam tabel tersendiri (anggota), sehingga tabel peminjaman hanya menyimpan id_anggota sebagai Foreign Key. Menambahkan tabel riwayat_denda untuk menangani rekaman denda/sanksi secara normal.

Struktur Skema 5 Entitas 3NF

        1. anggota
                * skema: anggota(id_anggota, nama_anggota, no_telp, tgl_daftar)
                PK: id_anggota

        2. buku
                * skema: buku(id_buku, judul_buku, Kategori_buku, Tarif-denda_perhari, stok)
                PK: id_buku
        
        3. peminjaman
                * Skema: peminjaman(id_peminjaman, tgl_peminjaman, id_anggota, total_denda)
                PK: id_peminjaman 
                FK: id_anggota --> anggota(id_anggota)

        4. detai_peminjaman
                * Skema: detai_peminjaman(id_peminjaman, id_buku, stok_detail_peminjaman, Tarif_denda_detail_peminjaman)
                PK: (id_peminjaman, id_buku)
                FK: id_peminjaman, id_buku

        5. riwayat_denda
                * Skema: riwayat_denda(id_denda, id_anggota, id_peminjaman, jumlah_denda, jenis_sanksi, tgl_denda)
                PK: id_denda
                FK: id_anggota, id_peminjaman

### D. Tahapan Bentuk Normal Boyce-Codd (BCNF)
Definisi dari tahapan ini adalah sebuah relasi berada dalam BCNF jika untuk setiap ketergantungan fungsional nontrivial X --> Y, maka X harus merupakan superkey.

* Pengujian

        1. Relasi anggota : Determinan adalah id_anggota (merupakan Primary Key) --> Lolos BCNF.
        2. Relasi buku : Determinan adalah id_buku (merupakan Primary Key) --> Lolos BCNF.   
        3.  Relasi peminjaman : Determinan adalah id_peminjaman (merupakan Primary Key) --> Lolos BCNF.   
        4. Relasi detail_peminjaman : Determinan adalah pasangan komposit {id_peminjaman, id_buku} (merupakan Primary Key) --> Lolos BCNF.
        5. Relasi riwayat_denda : Determinan adalah id_denda (merupakan Primary Key) --> Lolos BCNF. 

### 4. Analisis Nilai Turunan 


1. Subtotal Denda (qty * tarif_denda):
Keputusan yang dapat diterima yaitu tidak disimpan secara fisik. Alasannya Menyimpan subtotal melanggar prinsip efisiensi dan integritas normalisasi karena nilainya dapat dihitung kapan saja menggunakan kueri proyeksi:
        
                SELECT id_peminjaman, id_buku, (qty_detail_peminjaman * tarif_denda_detail_peminjaman) AS subtotal_denda
                FROM detail_peminjaman;
     

2. Tarif Denda Satuan Transaksi (tarif_denda_detail_peminjaman):

   Keputusan yang dapat diambil yaitu dengan cara tetap disimpan secara fisik. alasannya yaitu atribut ini bukan nilai turunan dari tabel buku, melainkan rekaman historis (*point-in-time snapshot*) pada saat transaksi peminjaman terjadi. Jika tarif denda buku di tabel master mengalami penyesuaian/kenaikan tarif di masa depan, nilai akumulasi denda transaksi peminjaman masa lalu tidak boleh ikut berubah.

3. Total Denda Transaksi (total_denda):

   Keputusan yang dapat diambil yaitu dengan cara tetap disimpan secara fisik. Alasannya dapat digunakan sebagai dasar rekonsiliasi kas riil perpustakaan, bukti pembayaran akuntansi, dan menjaga integritas audit transaksi jika di kemudian hari terdapat penyesuaian khusus seperti pemutihan denda, potongan diskon denda, atau penghapusan sanksi.


## 5. Status Perubahan ERD 

Hasil pengujian normalisasi mengonfirmasi bahwa 5 entitas utama (anggota, buku, peminjaman, detail_peminjaman, dan riwayat_denda) terbebas dari anomali data serta ketergantungan parsial maupun transitif. Oleh karena itu, skema ERD pada berkas p03_skema_erd_25430124.drawio dinyatakan final dan tidak membutuhkan penambahan tabel baru.
