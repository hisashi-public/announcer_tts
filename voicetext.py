#!/usr/bin/env python3

from pyVoiceText import VoiceText

def voicetext(textfile, outfile, speaker, speed):
    vt = VoiceText(open('./key.txt', 'r').read(16))
    wave = vt.fetch(
        text=open(textfile, 'r').read(),
        speaker=speaker,
        emotion_level=1,
        pitch=100,
        speed=speed,
        volume=100)
    vt.save(wave, outfile)


if __name__ == "__main__":
    import sys
    argv = sys.argv
    speaker='hikari'
    speed=100
    print('VoiceText start: ', argv[1])
    voicetext(argv[1], argv[2], speaker, speed)
    print('VoiceText finish: ', argv[1])
