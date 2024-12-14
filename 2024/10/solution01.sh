#!/bin/bash

gawk -F '' '{

for (i = 1; i <= NF; ++i) map[NR][i] = $i

} END {
delete trailheads
for (i in map) for (j in map[i]) if (map[i][j] == 0) {
        l = length(trailheads) + 1
        trailheads[l][1] = i
        trailheads[l][2] = j
}

# for (i in trailheads) print trailheads[i][1], trailheads[i][2]


for (i in trailheads) {
        delete visited
        visited[trailheads[i][1], trailheads[i][2]] = 1
        delete q
        q[1][1] = trailheads[i][1]
        q[1][2] = trailheads[i][2]
        head = 1
        tail = 1
        while (head <= tail) {
                x = q[head][1]
                y = q[head][2]
                head++
                for (dx = -1; dx <= 1; ++dx) for (dy = -1; dy <= 1; ++dy) if ((dx == 0) != (dy == 0)) {
                        nx = x + dx
                        ny = y + dy
                        if (nx < 1 || nx > length(map) || ny < 1 || ny > length(map[1])) continue
                        if (map[x][y]+1 != map[nx][ny]) continue
                        if (visited[nx, ny]) continue
                        visited[nx, ny] = 1
                        if (map[nx][ny] == 9) { found++; continue }
                        tail++
                        q[tail][1] = nx
                        q[tail][2] = ny
                }
        }
}
print found
}' $1
