#!/bin/bash

pull=`ssh dmil@158.160.32.142 ls -r /backups/dmil/inc`
echo $pull

n=1
for file in $pull ; do
    echo "$n - $(basename "$file")"
    ((n++))
done

read -p "Write number to restore (1-5): " x

rsync -avz dmil@158.160.32.142:/backups/dmil/current/ /home/dmil/restore/

m=1
for file in $pull ; do
    if [ "$m" -le "$x" ]; then
        echo "restore $file"
        rsync -avz dmil@158.160.32.142:/backups/dmil/inc/$file /home/dmil/restore/
    fi
    ((m++))
done
