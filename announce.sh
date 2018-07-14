#!/bin/bash

count=0
test -f list.txt && rm list.txt
cat ${1} | while read line ; do
    base=$(printf "%06d" ${count})
    echo "${line}" > ${base}.txt
#    ./voicetext.py ${base}.txt ${base}.mp3 || exit -1
    ./voicetext.py "${base}.txt" "${base}.mp3" &
    echo -n " ${base}.mp3" >> list.txt
    count=$(echo "${count} + 1" | bc)
done
for f in $(cat list.txt); do
    while true; do
        if test -f ${f}; then
            break;
        fi
        sleep 0.5
    done
done
cat list.txt
sox $(cat list.txt) output.wav || exit -1
rm list.txt
rm 000???.??? 
sox output.wav echoed.wav echo 1.0 0.75 100 0.5 reverb || exit -1
rm output.wav
play echoed.wav

