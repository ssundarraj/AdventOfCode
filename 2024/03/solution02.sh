#!/bin/bash

cat $1 | ggrep -Po "mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don\'t\(\)" | tr "(" " " | tr ")" " " | tr "," " " | tr "'" "n" | awk '
BEGIN {
        enabled = 1
}
{
        if ($1 == "mul") {
                sum += enabled * $2 * $3
        } else if ($1 == "do") {
                enabled = 1
        } else if ($1 == "donnt") {
                enabled = 0
        }
} END {
        print sum
}
'
