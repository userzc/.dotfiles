#!/bin/bash


# for file in ~/tDownloads/JIU\ JITSU\ CINTURON\ AZUL\ 4°KYU/PROGRAMA\ 4°KYU\ JIU\ JITSU\ JUKOSHIN\ RYU/*.MPG; do
# for file in ~/tDownloads/JIU\ JITSU\ CINTURON\ AZUL\ 4°KYU/COMPLEMENTARIO\ PASAR\ LAGUARDIA/*.MPG; do
for file in *.MPG; do
    fechaoriginal=$(stat "$file" | grep Modify | awk '{split($2,a, "-"); split($3, b, ":")}END{print a[1]a[2]a[3]b[1]b[2]}')
    touch -t $fechaoriginal "converted/${file%.MPG}.mp4"
    echo "Creation date: $fechaoriginal [$file]"
done
