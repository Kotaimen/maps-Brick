import os


zfactor=12 # Reduce this when using high resolution data!
azimuth=345 

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick'
cachedir= os.path.join(themedir, 'cache')

tag = 'Brick'
tile_size = 256

fmt = 'png'

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
    buffer_size=tile_size,
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
#     cache=dict(prototype='filesystem',
#                root=os.path.join(cachedir, '%s' % tag),
#                data_format=fmt,
#                simple=True
#               ),    
    sources=['landcover', 'roads', 'labels', 'label_halo',
             ],
    format=fmt,
    command='''   
    $1 
    ( 
        $2
        ( $4 -channel RGBA -blur %(scale)d +channel ) -compose dst-out -composite
    ) -compose over -composite
    ( $3 ) -compose over -composite    
#    -colorspace gray -fill wheat -tint 90
    ''' % dict(scale=tile_size//256)
    )

ROOT = dict(\
    renderer='composer',
    metadata=dict(tag=tag,
                  version='2.0',
                  description='Brick - OSM North America Road Map',
                  attribution='Open Street Map, Natural Earth',
                  ),
    cache=dict(prototype='filesystem',
               root=os.path.join(cachedir, 'export', '%s' % tag),
               data_format=fmt,
               simple=False
              ),
#     cache=dict(prototype='cascade',
#                violate=['memcache', {'servers': ['localhost:11211',] }],
#                presistent=['filesystem', {'root': os.path.join(cachedir, 'export', '%s' % tag), 'simple': False, }],              
#                data_format=fmt,
#                ),
    pyramid=dict(levels=range(9, 19),
                  envelope=(-180,-0.58,-52.32,71.60),                 
#                 envelope=(-124,34,-70,48),                 
#                envelope=( -123.401, 36.444, -118.65, 39.89),
                 zoom=9,
                 center=(-122.4321,37.7702),
                 format=fmt,
                 buffer=0,
                 tile_size=tile_size,
                 ),
)
