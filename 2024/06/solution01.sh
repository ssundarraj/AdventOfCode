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
       while (gi >= 1 && gj >= 1 && gi <= NR && gj <= NF) {
               if (seen[gi][gj] != 1)
                        ++steps
               seen[gi][gj] = 1
               
                if (walls[gi+di][gj+dj] == 1) {
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
        print steps
}' $1
