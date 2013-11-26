import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick2.mk7'
cachedir= os.path.join(themedir, 'cache')

tag = 'brick2'
tile_size = 256

fmt = 'png'


base = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/brick_base.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=2
    )

road = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/brick_road.xml'),
    image_type='png',
    buffer_size=16,
    scale_factor=2
    )

label = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/brick_label.xml'),
    image_type='png',
    buffer_size=tile_size*2,
    scale_factor=2
    )

halo = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/brick_label_halo.xml'),
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
    {{base}}
    (
        {{road}} {{halo}} -compose dst-out  -composite
    ) -compose over -composite
    {{label}} -compose over -composite
    -dither none
    -colors 128
    ''',
    )
ROOT = dict(\
    renderer='composer',
    metadata=dict(tag=tag,
                  version='2.0',
                  description="A Mason's Brick Take 2",
                  attribution='Open Street Map, Natural Earth',
                  ),
    storage=dict(prototype='cluster',
               stride=16,
               servers=['localhost:11211',],
               root=os.path.join(cachedir, 'export', '%s' % tag),
              ),
    pyramid=dict(levels=range(2, 20),
                 zoom=8,
                 center=(-122.4321, 37.7702),
                 format=fmt,
                 buffer=0,
                 tile_size=tile_size,
                 ),
)
