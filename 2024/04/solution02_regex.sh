#!/bin/bash

data=$(cat $1 | tr "\n" ",")
s1=$(echo $data | ggrep -oP "M(?=[A-Z]S.{138}.A..{138}M[A-Z]S)" | wc -l)
s2=$(echo $data | ggrep -oP "S(?=[A-Z]S.{138}.A..{138}M[A-Z]M)" | wc -l)
s3=$(echo $data | ggrep -oP "S(?=[A-Z]M.{138}.A..{138}S[A-Z]M)" | wc -l)
s4=$(echo $data | ggrep -oP "M(?=[A-Z]M.{138}.A..{138}S[A-Z]S)" | wc -l)
echo $(expr $s1 + $s2 + $s3 + $s4)
