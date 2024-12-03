#!/bin/bash

cat $1 | ggrep -Po "mul\((\d{1,3}),(\d{1,3})\)" | ggrep -Po "\d{1,3},\d{1,3}" | tr "," " " | awk '
{
        sum += $1 * $2
} END {
        print sum
}
'
