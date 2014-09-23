#!/usr/bin/env python

import subprocess
import os

width_padding = 12
height_padding = 6
char_width = 10
char_height = 12

themes = [
    ('#ffffff', 'black', 'motorway'),
]

os.chdir(os.path.dirname(__file__))


for fill, stroke, prefix in themes:
    for ch in range(3, 9):
        w, h = char_width * ch + width_padding, height_padding * 2 + char_height
        command = '''convert -size %dx%d xc:transparent -fill "%s" -stroke "%s" -strokewidth 2 -draw "roundrectangle 0,0 %d,%d 4,4" %s-%dch-48px.png''' % (w, h, fill, stroke, w-1, h-1, prefix, ch)
        print command
        subprocess.call(command, shell=True)
        
    for ch in range(1, 3):
        w, h = char_width * ch + width_padding, height_padding * 2 + char_height
        w += 4
        command = '''convert -size %dx%d xc:transparent -fill "%s" -stroke "%s" -strokewidth 2 -draw "roundrectangle 0,0 %d,%d 12,12" %s-%dch-48px.png''' % (w, h, fill, stroke, w-1, h-1, prefix, ch)
        print command
        subprocess.call(command, shell=True)
