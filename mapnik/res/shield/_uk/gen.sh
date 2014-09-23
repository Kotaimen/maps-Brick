#!/usr/bin/env python

import subprocess
import os

width_padding = 6
height_padding = 6
char_width = 12
char_height = 12

themes = [
    ('#0079C1',  'M'),
    ('#00703C',  'A'),
]

os.chdir(os.path.dirname(__file__))


for fill, prefix in themes:
    for ch in range(2, 7):

        w, h = char_width * ch + width_padding, height_padding * 2 + char_height


        command = '''convert -size %dx%d xc:transparent -fill "%s" -draw "roundrectangle 0,0 %d,%d 4,4" %s-%dch-48px.png''' % (w, h, fill, w-1, h-1, prefix, ch)
        print command
        subprocess.call(command, shell=True)
    
