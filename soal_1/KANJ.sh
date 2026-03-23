BEGIN {
    FS = ","
    Opsi = ARGV[2]
    delete ARGV[2]
}

NR == 1 { next }

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

END {
    for (g in gerbong) {
        gerbong_penumpang++
    }

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
