BEGIN {
    FS=","
}

NR > 1 {

    count++

    gerbong[$3] = 1

    if ($4 > max) {
        max = $4
        nama = $1
    }

    total = total + $4

    if ($5 == "Business") {
        business++
    }
}

END {
    if (pilihan == "a") {
        print "Jumlah seluruh penumpang KANJ adalah " count " orang"
    }
    else if (pilihan == "b") {
        jumlah = 0
        for (i in gerbong) jumlah++
        print "Jumlah gerbong penumpang KANJ adalah " jumlah
    }
    else if (pilihan == "c") {
        print nama " adalah penumpang kereta tertua dengan usia " max " tahun"
    }
    else if (pilihan == "d") {
        rata = int(total / count)
        print "Rata-rata usia penumpang adalah " rata " tahun"
    }
    else if (pilihan == "e") {
        print "Jumlah penumpang business class ada " business " orang"
    }
    else {
        print "Soal tidak dikenali. Gunakan a,b,c,d, atau e."
        print "Contoh penggunaan: awk -v pilihan=a -f KANJ.sh passenger.csv"
    }
}
