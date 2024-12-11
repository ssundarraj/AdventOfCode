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

for (j = length(disk); j > 0; j--) {
        if (disk[j] == ".") continue
        k = j
        while (disk[k] == disk[j] && k >= 1) k--
        file_size = j - k
        for (i = 1; i <= k; i++) {
                if (disk[i] != ".") continue
                l = i
                while (disk[l] == ".") l++
                free_size = l - i
                if (free_size >= file_size) {
                        for (m = 0; m < file_size; m++) {
                                disk[i + m] = disk[j]
                                disk[k + m + 1] = "."
                        }
                        break
                }
                i = l - 1
        }
        j = k + 1
}

# print "disk is"
# for (i in disk) printf disk[i]


for (i in disk) {
        if (disk[i] == ".") continue 
        checksum += disk[i] * (i - 1)

}
print checksum




}' $1
