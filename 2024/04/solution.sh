#!/bin/bash

num_cols=$(awk -F '' '{print NF}' $1 | head -n 1)
cols=""
for ((i = 1; i <= $num_cols; i++)); do
        col=$(awk -F '' -v i=$i '{print $i}' $1 | tr -d "\n")
        cols="$cols\n$col"
done

# awk -F '' '{
#         for (i=1; i<=NF; i++) ALLAR [NR,i] = $i
# } END {
#         for (ii = 1; ii <= NF; ii++) {
#                 for (jj = 1; jj <= NF; jj++) {
#                     printf "%s ", ALLAR[ii, jj]; # Print each element
#                 }
#                 printf "\n"; # New line after each row
#         }
#         print "end" NF
#         for (r=1; r<NF * 2 ; r++) {
#                 for (j=r; j>=1; j--) printf "%s", ALLAR [r-j+1,j]
#                 printf "\n"
#         }
#
#         for (r=1; r<NF * 2 ; r++) {
#                 for (j=r; j>=1; j--) printf "%s", ALLAR [r-j+1,NF-j+1]
#                 printf "\n"
#         }
# }' $1
# exit
diags="$(awk -F '' '{
        for (i=1; i<=NF; i++) ALLAR [NR,i] = $i
} END {
        for (r=1; r<NF * 2 ; r++) {
                for (j=r; j>=1; j--) printf "%s", ALLAR [r-j+1,j]
                printf "\n"
        }
        for (r=1; r<NF * 2 ; r++) {
                for (j=r; j>=1; j--) printf "%s", ALLAR [r-j+1,NF-j+1]
                printf "\n"
        }
}' $1)"

rows=$(cat $1)
data="$rows$cols\n$diags\n"
f=$(echo $data | ggrep -Po "XMAS" | wc -l)
r=$(echo $data | ggrep -Po "SAMX" | wc -l)
echo $(expr $f + $r)
