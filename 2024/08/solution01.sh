#!/bin/bash

gawk -F '' '{

for (i=1; i<=NF; ++i) {
        if ($i != ".") {
                cur_len = length(a[$i])
                a[$i][cur_len+1][1] = NR
                a[$i][cur_len+1][2] = i
        }
}
} END {
# for (i in a) for (j in a[i]) print i " is at " a[i][j][1] "," a[i][j][2]

for (i in a) {
        for (j=1; j<= length(a[i]); ++j) {
                for (k=j+1; k<= length(a[i]); ++k) {
                        # print "pairs of " i " : " a[i][j][1], a[i][j][2] " and " a[i][k][1], a[i][k][2]
                        x1 = a[i][j][1]
                        y1 = a[i][j][2]
                        x2 = a[i][k][1]
                        y2 = a[i][k][2]
                        xdiff = x1 - x2
                        ydiff = y1 - y2
                        cx1 = x1 + xdiff
                        cy1 = y1 + ydiff
                        cx2 = x2 - xdiff
                        cy2 = y2 - ydiff
                        if (cx1 >= 1 && cx1 <= NR && cy1 >= 1 && cy1 <= NF) {
                                # print "found node" i " at " cx1, cy1
                                nodes[cx1][cy1] = 1
                        }
                        if (cx2 >= 1 && cx2 <= NR && cy2 >= 1 && cy2 <= NF) {
                                # print "found node" i " at " cx2, cy2
                                nodes[cx2][cy2] = 1
                        }
                }
        }
}
for (i in nodes) for (j in nodes[i]) ++count
print count
}' $1
