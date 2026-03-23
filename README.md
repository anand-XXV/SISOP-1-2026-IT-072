# SISOP-1-2026-IT-072

## Soal 1
Langkah pertama yaitu mendownload dan membuka file passenger.csv yang berada di dalam soalnya. Di dalam .csv tersebut dapat terlihat bahwa isi data penumpang terdiri dari:
- Nama Penumpang
- Usia
- Kursi Kelas
- dan Gerbong

Di dalam soal, perintah soal menggunakan command Linux dan bantuan awk. Kode awk diberi nama KANJ.sh (sesuai dengan soal) yang berisi dari 5 fungsi, yaitu:
a. Menampilkan jumlah penumpang KANJ
b. Menampilkan jumlah gerbong penumpang KANJ
c. Menampilkan penumpang KANJ yang tertua serta umurnya
d. Menampilkan rata-rata penumpang KANJ
e. Menampilkan jumlah penumpang business KANJ

Setelah membaca soal dan perintah fitur yang harus ada di dalam kode, kita mulai membuat kode penyelesaian dengan ```nano KANJ.sh```

Di dalam KANJ.sh, mulai mengisi dengan
```
BEGIN {
    FS = ","
}

NR == 1 { next }
```
BEGIN dijalankan sekali untuk membaca data. Setelah BEGIN mulai dengan set FS = "," digunakan untuk memisahkan kolom berdasarkan tanda koma yang sesuai dengan format di dalam file CSVnya.
NR == 1 { next } digunakan untuk membaca data nomor baris saat ini yaitu 1 (Header) dan langsung skip ke baris berikutnya dengan next.

```
{
    jumlah_penumpang++
    total_usia += $2
    gerbong[$4] = 1
    if ($2 > max_usia) {
        max_usia = $2
        tertua = $1
    }
    if ($3 == "Business") {
        business++
    }
}
```
Bagian ini dijalankan untuk setiap baris data penumpang dimana:
- 'jumlah_penumpang++' untuk menghitung total penumpang
- 'total_usia ++ $2' untuk menjumlahkan semua usia penumpang (kolom ke-2)
- 'gerbong[$4] = 1' untuk enyimpan gerbong unik ke dalam array AWK (kolom ke-4)
- 'if ($2 > max_usia)' untuk mencari penumpang dengan usia tertinggi
- 'max_usia = $2' dan 'tertua = $1' untuk set usia tertua dan nama penumpang tertua (kolom 2 untuk usia tertua dan kolom 1 untuk nama penumpang tertua)
- 'if ($3 == "Business")' untuk menghitung penumpang Business Class (kolom ke-3)

```
END {
    for (g in gerbong) {
        gerbong_penumpang++
    }
```
END dijalankan sekali setelah semua data sudah selesai dibaca.
'for (g in gerbong)' adalah loop array gerbong untuk menghitung jumlah gerbong unik.

```
    if (Opsi == "a") {
        print "Jumlah seluruh penumpang KANJ adalah " jumlah_penumpang " orang"
    }
    else if (Opsi == "b") {
        print "Jumlah gerbong penumpang KANJ adalah " gerbong_penumpang
    }
    else if (Opsi == "c") {
        print tertua " adalah penumpang kereta tertua dengan usia " max_usia " tahun"
    }
    else if (Opsi == "d") {
        print "Rata-rata usia penumpang adalah " int(total_usia / jumlah_penumpang) " tahun"
    }
    else if (Opsi == "e") {
        print "Jumlah penumpang business class ada " business " orang"
    }
    else {
        print "Soal tidak dikenali. Gunakan a,b,c,d, atau e."
        print "Contoh penggunaan: awk -f file.sh Opsi=a data.csv"
    }
}
```
Menampilkan output sesuai dengan pilihan opsi yang sesuai dengan soalnya dan jika opsi yang dipilih bukan a/b/c/d/e akan menampilkan output cara penggunaannya.

Screenshot output a/b/c/d/e dan pilihan diluarnya:
<img width="1215" height="271" alt="image" src="https://github.com/user-attachments/assets/ef4a0db7-7898-4a84-b033-907db0082f33" />

Kendala:
Dari soal menspesifikasikan untuk input seperti:
```awk -f KANJ.sh passenger.csv a```

Tetapi, input tersebut tidak bisa dijalankan karena pilihan a dikirakan sebagai sebuah file, cara memperbaikinya adalah menggunakan ARGV tetapi dari pencarian saya di modul 1 tidak muncuk penjelasan untuK ARGV, tetapi ARGV mulai muncul di modul 2.

Oleh karena itu, soal menggunakan Opsi==a/b/c/d/e sebagai pemilihan opsi input yang seperti berikut:
```awk -f KANJ.sh -v Opsi=a passenger.csv```

## Soal 2
