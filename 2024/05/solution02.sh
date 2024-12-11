#!/bin/bash

gawk -F ',' '{

if (NF <= 1) {
  split($1, a, "|")
  ordering[a[1]][a[2]] = 1
} else {
  bad = 0
  for (i=1; i<=NF; i++) {
        for (j=i+1; j<=NF; j++) {
                if (ordering[$j][$i] == 1) {
                        bad = 1
                }
        }
  }
  if (!bad) next
  # print "bad" $0
  for (i=1; i<=NF; i++) {
        for (j=i+1; j<=NF; j++) {
                if (ordering[$j][$i] == 1) {
                    # print "swapping" $i, $j
                    x = $i
                    $i = $j
                    $j = x
                    j = i
                }
        }
  }
  idx = NF/2 + 1
  sum+= $idx 
}


} END {
for (i in ordering) {
      for (j in ordering[i]) {
        # print i, j, ordering[i][j]
      }
}
print sum

}' $1
