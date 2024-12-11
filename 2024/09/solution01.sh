#!/bin/bash

gawk -F '' '{

idx = 0
id = 0
for (i=1; i<=NF; ++i) {
        if (i % 2 == 1) {
                for (x = 0; x < $i; x++) disk[++idx] = id
                id++ 
        } else {
                for (x = 0; x < $i; x++) disk[++idx] = "."
        }
}
} END {

i = 1
j = length(disk)

while (i < j) {
        if (disk[i] != ".") {
                i++
                continue
        }
        if (disk[j] == ".") {
                j--
                continue
        }
        disk[i] = disk[j]
        disk[j] = "."
}

for (i in disk) {
        if (disk[i] == ".") break
        checksum += disk[i] * (i - 1)

}
print checksum




}' $1
