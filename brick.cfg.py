import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick'
cachedir= os.path.join(themedir, 'cache')

tag = 'Brick'
tile_size = 256

fmt = 'jpg'

landcover = dict(\
    prototype='datasource.mapnik',
    theme=os.path.join(themedir, 'brick-landcover.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=tile_size//256
    )

roads = dict(\
    prototype='datasource.mapnik',
    theme=os.path.join(themedir, 'brick-roads.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=tile_size//256
    )

labels = dict(\
    prototype='datasource.mapnik',
    theme=os.path.join(themedir, 'brick-labels.xml'),
    image_type='png',
    buffer_size=tile_size*2,
    scale_factor=tile_size//256
    )

label_halo = dict(\
    prototype='datasource.mapnik',
    theme=os.path.join(themedir, 'brick-labels_halo.xml'),
    image_type='png',
    buffer_size=tile_size* 2,
    scale_factor=tile_size//256
    )

composer=dict(\
    prototype='composite.imagemagick',   
  
    sources=['landcover', 'roads', 'labels', 'label_halo',
             ],
    format=fmt,
    command='''   
    $1 
    ( 
        $2
        ( $4 
        #-channel RGBA -blur %(scale)d +channel 
        ) -compose dst-out -composite
    ) -compose over -composite
    ( $3 ) -compose over -composite    
#    -colorspace gray -fill wheat -tint 90
    -quality 90
    ''' % dict(scale=tile_size//256)
    )

ROOT = dict(\
    renderer='composer',
    metadata=dict(tag=tag,
                  version='2.0',
                  description='Brick - OSM North America Road Map',
                  attribution='Open Street Map, Natural Earth',
                  ),
    cache=dict(prototype='cluster',
               stride=16,
               servers=['localhost:11211',],
               root=os.path.join(cachedir, 'export', '%s' % tag),
              ),
    pyramid=dict(levels=range(2, 19),
#                 envelope=[-127,27,-67,50], # US mainland
#                envelope=(-124,34,-70,48),                 
#                envelope=( -123.40/1, 36.444, -118.65, 39.89),
                 zoom=9,
                 center=(-122.4321,37.7702),
                 format=fmt,
                 buffer=4,
                 tile_size=tile_size,
                 ),
)
