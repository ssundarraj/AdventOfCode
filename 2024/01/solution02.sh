gawk '{
  xs[$1] += 1
  ys[$2] += 1
} END {
  for (i in xs) {
    sum+= i  * xs[i] * ys[i]
  }
  print sum
}' $1
