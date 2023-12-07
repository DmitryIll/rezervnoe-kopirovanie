#!/bin/bash
n=1
for file in /tmp/increment/*; do
    echo "$n - $(basename "$file")"
    ((n++))
done

read -p "Write number to restore (1-5): " x

m=1
for file in /tmp/increment/*; do
    if [ "$m" -le "$x" ]; then
        rsync -avz $file/ joos@10.103.7.20:/home/joos/
    fi
    ((m++))
done