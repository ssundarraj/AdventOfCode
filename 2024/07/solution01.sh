#!/bin/bash

gawk -F ' ' '{

target = substr($1, 1, length($1) - 1)

delete a

a[1] = $2
for (i=3; i<=NF; ++i) {
        curlen = length(a)
        for (j=1; j<= curlen; ++j) {
                a[length(a)+1] = a[j] * $i
                a[j] = a[j] + $i
        }
}

for (i in a) {
        if (a[i] == target) {
                sum += target
                break
        }
}
print sum
}' $1
