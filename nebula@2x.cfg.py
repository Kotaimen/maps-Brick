import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick2.mk9'
cachedir= os.path.join(themedir, 'cache')

tag = 'nebula@2x'
tile_size = 256

fmt = 'png'

all_ = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/nebula@2x_all.xml'),
    buffer_size=tile_size*2,
    scale_factor=2,
    )
        
ROOT = dict(\
    renderer='all_',
    metadata=dict(tag=tag,
                  dispname='Nebula (Retina)',
                  version='2.1',
                  description="Nebula",
                  attribution='Open Street Map, Natural Earth II',
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
