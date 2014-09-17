import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick2.mk8'
cachedir= os.path.join(themedir, 'cache')

tag = 'nebula'
tile_size = 256

fmt = 'png'

all_ = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/nebula_all.xml'),
    buffer_size=tile_size*1,
    scale_factor=1
    )
        
ROOT = dict(\
    renderer='all_',
    metadata=dict(tag=tag,
                  dispname='Nebula',
                  version='2.0',
                  description="Where we came from",
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
