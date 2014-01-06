import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick2.mk7'
cachedir= os.path.join(themedir, 'cache')

tag = 'saga'
tile_size = 256

fmt = 'png'

# XXX: This requires mapnik-compose branch
all_ = dict(\
    prototype='node.brick2',
    theme=os.path.join(themedir, 'mapnik/xml/saga'),
    buffer_size=tile_size*2,
    scale_factor=2
    )
        
ROOT = dict(\
    renderer='all_',
    metadata=dict(tag=tag,
                  dispname='Saga',
                  version='2.0',
                  description="A Mason's Brick Take 2",
                  attribution='Open Street Map, Natural Earth II',
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
