gawk '{
  xs[NR-1] = $1
  ys[NR-1] = $2
} END {
  asort(xs)
  asort(ys)
  for (i in xs) {
    diff = xs[i] - ys[i]
    diff = diff < 0 ? -diff : diff
    sum += diff
  }
  print sum
}' $1
