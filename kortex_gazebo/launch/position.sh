#!/usr/bin/env sh
echo "^$1,$2,$3,$4"
grep "^$1,$2,$3,$4" ~/SSoMdata/robots/gen3_act.csv | awk -F "," ' { print $14 " " $22 " " $30 " " $38 " " $46 " " $54 }' | xargs -l bash -c 'sh ~/SSoMdata/robots/pos.sh $0 $1 $2 $3 $4 $5'
