#!/bin/bash

# todo awk
col1=($(cut -d ' ' -f1 input.txt | sort))
col2=($(cut -d ' ' -f4 input.txt | sort))

function diff {
        if [ $1 -lt $2 ]; then
                echo $(($2 - $1))
        else
                echo $(($1 - $2))
        fi
}

sum=0
for i in $(seq 0 $((${#col1[@]} - 1))); do
        ((sum += $(diff ${col1[$i]} ${col2[$i]})))
done

echo $sum
