#!/bin/bash

path=$1
filename=$2
newfilename=$3

echo "We are finding '$filename' under the folder '$path'"

count=1
for i in `find $path -iname "*$filename*" | tac`
do
    newpath=`echo $i | sed "s@\(.*\)$filename@\1$newfilename@i"`
    sudo mv "$i" "$newpath"
    echo "${count}: Renaming $i to $newpath"
    let count++
done
