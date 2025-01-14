#!/usr/bin/env sh
echo "^$1,$2,$3,$4,$5"
grep "^$1,$2,$3,$4,$5" ~/SSoMdata/robots/gen3_act.csv | awk -F "," ' { print $15 " " $23 " " $31 " " $39 " " $47 " " $55 }' | xargs -l bash -c 'sh ~/SSoMdata/robots/pos.sh $0 $1 $2 $3 $4 $5'
