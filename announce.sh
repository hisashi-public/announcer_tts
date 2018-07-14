#!/bin/bash

count=0
test -f list.txt && rm list.txt
cat ${1} | while read line ; do
    base=$(printf "%06d" ${count})
    echo "${line}" > ${base}.txt
#    ./voicetext.py ${base}.txt ${base}.mp3 || exit -1
    ./voicetext.py "${base}.txt" "${base}.mp3" ${2} &
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
sox -r 44100 -n zero.wav trim 0 0.5 || exit -1
LIST=""
for f in $(cat list.txt); do
    LIST="${LIST} zero.wav ${f} "
done
sox ${LIST} zero.wav -r 44100 output.wav
rm list.txt
rm 000???.??? 
sox output.wav ${3} echo 1.0 0.75 100 0.5 reverb || exit -1
rm output.wav

