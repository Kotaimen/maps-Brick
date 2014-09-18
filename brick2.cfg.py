import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick2.mk9'
cachedir= os.path.join(themedir, 'cache')

tag = 'brick2.mk9'
tile_size = 256

fmt = 'png'

all_ = dict(\
    prototype='node.brick2',
    theme=os.path.join(themedir, 'mapnik/xml/brick'),
    buffer_size=tile_size*1,
    halo_opacity=0.7,
    scale_factor=1,
    )
        
ROOT = dict(\
    renderer='all_',
    metadata=dict(tag=tag,
                  dispname='Brick2',
                  version='2.0',
                  description="A Mason's Brick Take 2",
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
