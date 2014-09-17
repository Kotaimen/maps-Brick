import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick2.mk8'
cachedir= os.path.join(themedir, 'cache')

tag = 'voynich@2x'
tile_size = 256

fmt = 'png'

all_ = dict(\
    prototype='node.brick2',
    theme=os.path.join(themedir, 'mapnik/xml/voynich'),
    buffer_size=tile_size*2,
    halo_opacity=0.8,    
    scale_factor=2
    )
    
base = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/voynich_base.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=2
    )

road = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/voynich_road.xml'),
    image_type='png',
    buffer_size=16,
    scale_factor=2
    )

label = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/voynich_label.xml'),
    image_type='png',
    buffer_size=tile_size*2,
    scale_factor=2
    )

halo = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/voynich_label_halo.xml'),
    image_type='png',
    buffer_size=tile_size*2,
    scale_factor=2
    )    
    
composer=dict(\
    prototype='node.imagemagick',

    sources=['base', 'road', 'label', 'halo',
             ],
    format=fmt,
    command='''
    # Apply ordered dither to landbase, mimics 'halftone dither' effect
    ( {{base}} %(texture)s -compose color -composite )
    
    (
        # Use a different dither for some variation
        {{road}}
        # Fill halo with land color and only render on top of roads
        {{halo}} -compose Atop -composite
    ) -compose Over -composite

    (
        # Increase lightness of labels, will apply Multiply later...
        {{label}}
    )  -compose Over -composite
    
    '''  % dict(texture=os.path.join(themedir, 'mapnik/texture/paper1.png')),
    )
    
        
ROOT = dict(\
    renderer='all_',
    metadata=dict(tag=tag,
                  dispname='Voynich (Retina)',
                  version='2.0',
                  description="A Mason's Mystery",
                  attribution='Open Street Map, Natural Earth II',
                  ),
    storage=dict(prototype='cluster',
               stride=16,
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
