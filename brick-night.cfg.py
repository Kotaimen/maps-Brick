import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick.mk6'
cachedir= os.path.join(themedir, 'cache')

tag = 'Brick.mk6.night'
tile_size = 256

fmt = 'png'

map = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'Brick_night.xml'),
    image_type='png',
    buffer_size=tile_size*2,
    scale_factor=2
    )

ROOT = dict(\
    renderer='map',
    metadata=dict(tag=tag,
                  version='2.0',
                  description='Brick - OSM North America Road Map',
                  attribution='Open Street Map, Natural Earth',
                  ),
     storage=dict(prototype='cluster',
                stride=16,
                servers=['localhost:11211',],
                root=os.path.join(cachedir, 'export', '%s' % tag),
               ),
    pyramid=dict(levels=range(2, 20),
#                 envelope=[-127,27,-67,50], # US mainland
#                envelope=(-124,34,-70,48),
#                envelope=( -123.40.1, 36.444, -118.65, 39.89),
                 zoom=4,
                 center=(-122.4321,37.7702),
                 format=fmt,
                 buffer=0,
                 tile_size=tile_size,
                 ),
)
