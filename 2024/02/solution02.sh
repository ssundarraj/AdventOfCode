#!/bin/bash

awk '
function abs(x) {
        return x < 0 ? -x : x
}
function safe(x, size) {
        desc = 0
        for (i=2; i<=size; i++) {
                diff = x[i] - x[i-1]
                if (i==2 && diff < 0) desc = 1
                if ((diff < 0) != desc) {
                        return 0
                }
                if (abs(diff) < 1 || abs(diff) > 3) {
                        return 0
                }
        }  
        return 1
}
function delete_shift(x, y, idx) {
        size = length(x)
        j = 1
        for (i=1; i<=size; i++) {
                if (i == idx) continue
                y[j] = x[i]
                j++
        }
}
function print_arr(x) {
        for (i=1; i<=length(x); i++) {
                printf "%d ", x[i]
        }
        printf "\n"
}
{
        split($0, x, " ")
        for (ii = 1; ii <= length(x); ii++) {
                delete y
                delete_shift(x, y, ii)
                # print_arr(x)
                # print_arr(y)
                if (safe(y, length(y))) {
                        z+=1
                        break
                }
        }
        # z+= safe(x, NF)
} END {
        print z
}
' $1
