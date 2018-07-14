#!/bin/bash

./announce.sh "${1}" t echoed1.wav 
./announce.sh "${1}" h echoed2.wav 
sox "${2}" bgm.wav gain -h -14 
sox -r 44100 -n zero.wav trim 0 5

sox \
zero.wav echoed1.wav \
zero.wav echoed2.wav \
-c 2 \
loop.wav
sox loop.wav loop2.wav delay 0 0.03
sox -m loop2.wav bgm.wav output.wav
rm bgm.wav 
play output.wav
