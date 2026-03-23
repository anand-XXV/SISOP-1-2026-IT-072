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
    Opsi = ARGV[2]
    delete ARGV[2]
}

NR == 1 { next }
```
`BEGIN` dijalankan sekali untuk membaca data. Setelah BEGIN mulai dengan set FS = "," digunakan untuk memisahkan kolom berdasarkan tanda koma yang sesuai dengan format di dalam file CSVnya.
`Opsi` menyimpan nilai argumen untuk digunakan di bagian END.
`ARGV[2]` adalah argumen ketiga yang dimasukkan saat menjalankan perintah yang berfungsi untuk pemilihan opsi a/b/c/d/e, jika ARGVnya [0] atau [1] maka ARGV[0] = 'awk' dan ARGV[1] = 'passenger.csv'
`delete ARGV[2]` diperlukan agar AWK tidak mencoba membuka a/b/c/d/e sebagai file input.
`NR == 1 { next }` digunakan untuk membaca data nomor baris saat ini yaitu 1 (Header) dan langsung skip ke baris berikutnya dengan next.

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
- `jumlah_penumpang++` untuk menghitung total penumpang
- `total_usia ++ $2` untuk menjumlahkan semua usia penumpang (kolom ke-2)
- `gerbong[$4] = 1` untuk enyimpan gerbong unik ke dalam array AWK (kolom ke-4)
- `if ($2 > max_usia)` untuk mencari penumpang dengan usia tertinggi
- `max_usia = $2` dan `tertua = $1` untuk set usia tertua dan nama penumpang tertua (kolom 2 untuk usia tertua dan kolom 1 untuk nama penumpang tertua)
- `if ($3 == "Business")` untuk menghitung penumpang Business Class (kolom ke-3)

```
END {
    for (g in gerbong) {
        gerbong_penumpang++
    }
```
`END` dijalankan sekali setelah semua data sudah selesai dibaca.
`for (g in gerbong)` adalah loop array gerbong untuk menghitung jumlah gerbong unik.

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
        print "Contoh penggunaan: awk -f file.sh data.csv a"
    }
}
```
Menampilkan output sesuai dengan pilihan opsi yang sesuai dengan soalnya dan jika opsi yang dipilih bukan a/b/c/d/e akan menampilkan output cara penggunaannya.

Screenshot output a/b/c/d/e dan pilihan diluarnya:
<img width="1130" height="274" alt="image" src="https://github.com/user-attachments/assets/a21df353-998d-41e4-95e1-12dc43baefda" />

Kendala:
Tidak ada

## Soal 2
Sesuai dengan rekomendasi soalnya, langkah pertama untuk pengerjaan soalnya adalah dengan mempersiapkan toolsnya.
Langkah pertama persiapannya yaitu membuat virtual environment Python dan install gdown untuk mendownload file pdf peta ekspedisi amba dengan cara:
```
python3 -m venv venv
source venv/bin/activate
pip install gdown
```

Setelah aktifkan venv, download file pdfnya dengan menggunakan gdown.
```
gdown "https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q" -O peta-ekspedisi-amba.pdf
```

Karena PDF tampangnya hanya berisi gambar, untuk mencari URL tersembunyi di dalamnya gunakan perintah 'strings'.
```
strings peta-ekspedisi-amba.pdf | grep -i "github"
```
Dari ini dapatlah link repository: `https://github.com/pocongcyber77/peta-gunung-kawi.git`

Sesuai dengan saran dari soal, kita clone repository menggunakan Git.
```
git clone https://github.com/pocongcyber77/peta-gunung-kawi.git
```
Dari clone ini dapatlah file bernama gsxtrack.json, di dalam file ini berisi data penting.
Soal lalu memberi instruksi untuk mendapatkan data-data penting dalam file tersebut menggunakan shell script yang akan menyimpan hasilnya dalam file .txt baru.

Untuk yang pertama, membuat shellscript untuk mendapat data id, site_name, latitude, longitude pada setiap baris lalu menyimpannya dalam file 'titik-penting.txt'
Jalankan `nano parserkoordinat.sh` lalu isi dengan kode berikut:
```
#!/bin/bash

INPUT="gsxtrack.json"
OUTPUT="titik-penting.txt"

> "$OUTPUT"

grep -E '"id"|"site_name"|"latitude"|"longitude"' "$INPUT" | awk -F'"' '
/"id"/ { id = $4 }
/"site_name"/ { name = $4 }
/"latitude"/ { lat = $3; gsub(/: /, "", lat); gsub(/,/, "", lat) }
/"longitude"/ { lon = $3; gsub(/: /, "", lon); gsub(/,/, "", lon); print id","name","lat","lon }
' >> "$OUTPUT"

cat "$OUTPUT"
```
- `#!/bin/bash` atau shebang berfungsi untuk memberitahu sistem bahwa script ini dijalankan menggunakan Bash
- `INPUT="gsxtrack.json"` dan `OUTPUT="titik-penting.txt"` mendefinisikan variabel untuk nama file input dan output.
- `> "$OUTPUT"` berfungsi untuk mengosongkan file output dengan redirection (>) yang akan membuat file baru jika
  belum ada, atau menimpa isinya jika sudah ada.
- `grep -E` berfungsi untuk mencari baris yang mengandung salah satu dari beberapa pola sekaligus
- `|` adalah pipe, yang berfungsi untuk mengubah output grep menjadi input awk
- `awk -F'"'` adalah AWK dengan Field Separator (FS) tanda kutip
- `/"id"/` adalah pola pencarian AWK untuk baris yang mengandung "id"
- `gsub(/: /, "", lat)` menghapus karakter `: ` dari nilai latitude.
- `gsub(/,/, "", lat)` menghapus karakter `,` di akhir nilai jika ada.
- `>> "$OUTPUT"` berfungsi untuk redirection append hasil ke file output
- `cat "$OUTPUT"` menampilkan isi file `titik-penting.txt` ke terminal setelah selesai

Dan untuk yang kedua, membuat shellscript untuk menemukan lokasi pusaka dengan mencari titik pusat dengan menggunakan metode titik simetri diagonal lalu menghitungkan titik tengah diagonal tersebut dengan menggunakan koordinat yang telah di ekstrak.
Shellscript tersebut diberi nama `nemupusaka.sh` untuk menghitung titik tengah tersebut dengan menggunakan rumus yang tersedia di dalam soal dan memberikan outputnya ke file `posisipusaka.txt`.

Maka, jalankan `nano nemupusaka.sh` lalu diisi dengan kode berikut:
```
#!/bin/bash

INPUT="titik-penting.txt"
OUTPUT="posisipusaka.txt"

lat1=$(grep "node_001" "$INPUT" | awk -F',' '{print $3}')
lon1=$(grep "node_001" "$INPUT" | awk -F',' '{print $4}')
lat2=$(grep "node_003" "$INPUT" | awk -F',' '{print $3}')
lon2=$(grep "node_003" "$INPUT" | awk -F',' '{print $4}')

lat_tengah=$(awk "BEGIN {print ($lat1 + $lat2) / 2}")
lon_tengah=$(awk "BEGIN {print ($lon1 + $lon2) / 2}")

echo "Koordinat pusat: $lat_tengah, $lon_tengah"
echo "$lat_tengah, $lon_tengah" > "$OUTPUT"
```
- `#!/bin/bash` atau shebang berfungsi untuk memberitahu sistem bahwa script ini dijalankan menggunakan Bash
- `INPUT="titik-penting.txt"` dan `OUTPUT="posisipusaka.txt"` mendefinisikan variabel untuk nama file input dan output.
- `lat1=$(grep "node_001" "$INPUT" | awk -F',' '{print $3}')` dimana `grep "node_001"` mencari baris yang mengandung `node_001` di file input, `|` meneruskan hasil grep ke awk, `awk -F','` menggunakan koma sebagai Field Separator, `'{print $3}'` mengambil kolom ke-3 yaitu latitude, dan akhirnya hasil disimpan ke variabel `lat1`
- `lat2` dan `lon2` sama seperti lat1 dan lon1, tetapi mengambil data dari `node_003`,  node_001 dan node_003 dipilih karena keduanya adalah titik diagonal dari persegi yang terbentuk oleh 4 node
- `lat_tengah=$(awk "BEGIN {print ($lat1 + $lat2) / 2}")` menggunakan AWK Special Rule `BEGIN` untuk menghitung aritmatika float karena bash tidak bisa menghitung bilangan desimal secara langsung, sehingga menggunakan AWK sebagai kalkulator, rumus titik tengah yaitu `(lat1 + lat2)/2`, dan akhirnya menyimpan hasilnya ke variabel `lat_tengah`
- `echo "Koordinat pusat: $lat_tengah, $lon_tengah"` menampilkan hasil koordinat pusaka ke terminal
- `echo "$lat_tengah, $lon_tengah" > "$OUTPUT"` melanjutkan menampilkan hasil koordinat pusaka ke terminal lalu menyimpannya dengan redirection (>) untuk menulisnya ke dalam file posisipusaka.txt

Screenshot output dan isi file .txt:
<img width="1361" height="295" alt="image" src="https://github.com/user-attachments/assets/73fb90aa-f097-42dd-98d3-071944c224e8" />

Kendala:
Pembersihan venv supaya tidak muncul di repo github yang cukup rumit
