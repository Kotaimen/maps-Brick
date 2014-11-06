import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick2.mk9'
cachedir= os.path.join(themedir, 'cache')

tag = 'newspaper'
tile_size = 256

fmt = 'png'


base = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/newspaper_base.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=1
    )

road = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/newspaper_road.xml'),
    image_type='png',
    buffer_size=16,
    scale_factor=1
    )

label = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/newspaper_label.xml'),
    image_type='png',
    buffer_size=tile_size*1,
    scale_factor=1
    )

halo = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/newspaper_label_halo.xml'),
    image_type='png',
    buffer_size=tile_size*1,
    scale_factor=1
    )

composer=dict(\
    prototype='node.imagemagick',

    sources=['base', 'road', 'label', 
             ],
    format=fmt,
    command='''
    # Apply ordered dither to landbase, mimics 'halftone dither' effect
    ( {{base}} 
    -ordered-dither o4x4,6 
    )
    
    (
        # Use a different dither for some variation
        ( {{road}} )
        # Fill halo with land color and only render on top of roads
        ( {{label}} -channel A -morphology Dilate Disk:3 +channel +level-colors #ebe9e6 ) -compose Atop -composite
        -ordered-dither o4x4,4 
    ) -compose Over -composite

    (
        # Increase lightness of labels, will apply Multiply later...
        {{label}} 
        -brightness-contrast +10
        # Mimics 'typewriter' effect, only works on thin fonts.
        # Find line joins of labels and thicken/darken them.
        # Uses ImageMagick's morphology operation.
        # Slow!
        ( +clone -channel A
          -morphology HMT LineJunctions
#          -morphology Dilate Disk:1
          +channel 
        ) -compose Multiply -composite
    )  -compose Darken -composite
    
    # Make "real" duetone effect, not fake color tint.
    # First reduce brightness and contrast (the original 'mono' theme 
    # is high contrast white/black ) so the image fit in mid tone range.
    -brightness-contrast -12x-10
    
    # Convert to grayscale then apply duetone lookup table
    # The reference duotone images are converted from 
    # Photoshop's classic 'Duotone' mode library.
    -colorspace gray %(lut)s -clut
    
    # Finally, convert to paletted png
    -dither none
    -colors 128
    ''' % dict(lut=os.path.join(themedir, 'mapnik/res/duotone/Bl-for-dark-cg9-cg2.png')),
    )

ROOT = dict(\
    renderer='composer',
    metadata=dict(tag=tag,
                  dispname='Newspaper',
                  version='2.0',
                  description="A Mason's Morning Newspaper",
                  attribution='Open Street Map, Natural Earth',
                  ),
    storage=dict(prototype='cluster',
               stride=8,
               servers=['localhost:11211',],
               root=os.path.join(cachedir, 'export', '%s' % tag),
              ),
    pyramid=dict(levels=range(2, 21),
                 zoom=8,
                 center=(-122.4321, 37.7702),
                 format=fmt,
                 buffer=0,
                 tile_size=tile_size,
                 ),
)