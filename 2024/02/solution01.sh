#!/bin/bash

awk '
function abs(x) {
        return x < 0 ? -x : x
}
{
        desc = 0        
        for (i=2; i<=NF; i++) {
                diff = $i - $(i-1)
                if (i==2 && diff < 0) desc = 1
                if ((diff < 0) != desc) {
                        next
                }
                if (abs(diff) < 1 || abs(diff) > 3) {
                        next
                }
        }  
        z+=1
} END {
        print z
}
' $1
