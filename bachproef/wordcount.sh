a=$(pdftotext bachproef-tin.pdf - | wc -w)
count=$((a - 2651))
echo $count
