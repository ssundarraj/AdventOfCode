#!/bin/bash

data=$(gawk -F '' '{
        for (i=1; i<=NF; i++) data[NR][i] = $i
} END {
        for (i=1; i<NF-1; i++) {
                for (j=1; j<NF-1; j++) {
                        for (k=0; k<3; k++) {
                                for (l = 0; l< 3; l++) {
                                        printf data[i+k][j+l]
                                }
                        }
                        print " "
                }
        }
}' $1)
echo $data | tr " " "\n" | grep -e "M.M.A.S.S" -e "S.M.A.S.M" -e "S.S.A.M.M" -e "M.S.A.M.S" | wc -l
