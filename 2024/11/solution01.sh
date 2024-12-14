#!/bin/bash

gawk -F ' ' '
function num_stones(n, b) {
        if (b == 0) return 1
        if (m[n, b]) return m[n, b]
        if (n == 0) {
                m[n,b] = num_stones(1, b-1)
        } else if (length(n) % 2 == 0) {
                m[n,b] = num_stones(int(substr(n, 1, length(n) / 2)), b-1) + num_stones(int(substr(n, length(n) / 2 + 1)), b-1)
        } else {
                m[n, b] = num_stones(n * 2024, b-1)
        }
        return m[n,b]
}
{
for (i = 1; i <= NF; ++i) stones[i] = $i

} END {


b = 25
for (i = 1; i <= length(stones); ++i) {
        count += num_stones(stones[i], 75)
}
print count
}' $1
