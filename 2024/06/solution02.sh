#!/bin/bash

gawk -F '' '{
        for (i=1; i<=NF; ++i) {
                if ($i == "#") {
                        walls[NR][i] = 1
                }
                if ($i == "^") {
                        gi = NR
                        gj = i
                        di = -1
                        dj = 0
                }
                if ($i == 'v') {
                        gi = NR
                        gj = i
                        di = 1
                        dj = 0
                }
        }
} END {
        giorig = gi
        gjorig = gj
        diorig = di
        djorig = dj
        for (i=1; i<=NR; ++i) { for (j = 1; j <= NF; ++j) {
                di = diorig
                dj = djorig
                gi = giorig
                gj = gjorig
                delete seendir
                if (walls[i][j] == 1) {
                        continue
                }
                walls[i][j] = 1
                while (gi >= 1 && gj >= 1 && gi <= NR && gj <= NF) {
                        if (seendir[gi][gj][di][dj] == 1) {
                                sum += 1
                                break
                        }
                        seendir[gi][gj][di][dj] = 1
                       
                        while (walls[gi+di][gj+dj] == 1) {
                               if (di == 0) {
                                       di = dj
                                       dj = 0
                               } else if (dj == 0) {
                                      dj = di * -1
                                      di = 0
                               } 
                        }
                        gi += di
                        gj += dj
                }
                walls[i][j] = 0
        }}
        print sum
}' $1
