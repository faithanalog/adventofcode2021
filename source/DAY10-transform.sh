#!/bin/sh

OUT="source/DAY10-$1input.z80"

echo "IN_PROG:" > "$OUT"

cat source/DAY10-$1input.txt | \
    sed '
        s/(/000/g
        s/)/001/g
        s/\[/010/g
        s/]/011/g
        s/{/100/g
        s/}/101/g
        s/</110/g
        s/>/111/g
    ' \
    | tr -d '\n' \
    | sed -E '
        s/(........)/\1b, /g

        s/, (.......)$/, \10b/
        s/, (......)$/, \100b/
        s/, (.....)$/, \1000b/
        s/, (....)$/, \10000b/
        s/, (...)$/, \100000b/
        s/, (..)$/, \1000000b/
        s/, (.)$/, \10000000b/

        s/, $//
        s/$/\n/
        s/^/.db /
    ' >> "$OUT"


echo "IN_PROG_END:" >> "$OUT"
ccho ".db 0, 0, 0" >> "$OUT" # padding
echo "IN_LINE_LENS:" >> "$OUT"

cat source/DAY10-$1input.txt \
    | while read -r ln; do
        printf '%s' "$ln" | wc -c
    done \
    | sed 's/^/.db /' \
    >> "$OUT"

echo "IN_LINE_LENS_END:" >> "$OUT"
