a=$(pdftotext bachproef-tin.pdf - | wc -w)
count=$((a - 3129))
echo $count
