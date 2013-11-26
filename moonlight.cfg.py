import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick2.mk7'
cachedir= os.path.join(themedir, 'cache')

tag = 'moonlight'
tile_size = 256

fmt = 'png'

all_ = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/moonlight_all.xml'),
    image_type='png256',
    image_parameters={'colors':64},
    buffer_size=tile_size*2,
    scale_factor=2
    )

ROOT = dict(\
    renderer='all_',
    metadata=dict(tag=tag,
                  version='2.0',
                  description='Moonlight Rocks',
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
