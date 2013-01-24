import os



zfactor=3 # Reduce this when using high resolution data!
azimuth=355 

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick'
cachedir= os.path.join(themedir, 'cache')

tag = 'Brick'
tile_size = 256

fmt = 'png'


elev_1km = dict(\
    prototype='datasource.dataset',
    dataset_path=os.path.join(datadir, 'srtm30_new/world_tiled.tif'),
    cache=dict(prototype='metacache',
        root=os.path.join(cachedir, 'elevation'),
        compress=True,
        data_format='gtiff',
        ),
    )
    
elev_100m = dict(\
    prototype='datasource.dataset',
    dataset_path=os.path.join(datadir, 'DEM-Tools-patch/source/ned100m/world_3857.tif'),
    cache=dict(prototype='metacache',
        root=os.path.join(cachedir, 'elevation'),
        compress=True,
        data_format='gtiff',
        ),
    )
    
elev_10m = dict(\
    prototype='datasource.dataset',
    dataset_path=os.path.join(datadir, '/data/tilestorage/geodata/world_3857.tif'),    
    cache=dict(prototype='metacache',
        root=os.path.join(cachedir, 'elevation'),
        compress=True,
        data_format='gtiff',
        ),
    )
elevation = dict(\
    prototype='composite.selector',
    sources = ['elev_1km', 'elev_100m', 'elev_10m'],
    
    #            0  1  2  3  4  5  6  7  8  9 10 11 12 13 
    condition = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2],
    )

terrain = dict(\
    prototype='composite.imagemagick',
    sources=['diffuse', 'detail', 'specular',],
    format='jpg',
    command='''   
    (
         ( $1 -fill grey50 -colorize 100% )
         ( $1 ) -compose blend -define compose:args=50% -composite
         ( $2 -fill #003cff -tint 35  -gamma 0.8 ) -compose blend -define compose:args=30% -composite
         ( $3 -gamma 3  ) -compose blend -define compose:args=20% -composite
#         -brightness-contrast -20%x-10%
#         -gamma 0.7
         -quality 99
    )
    '''
    )

    
diffuse = dict(\
    prototype='processing.hillshading',
    sources='elevation',
    zfactor=zfactor,
    scale=1,
    altitude=35,
    azimuth=azimuth,
    )

detail = dict(\
    prototype='processing.hillshading',
    sources='elevation',
    zfactor=zfactor / 2.,
    scale=1,
    altitude=65,
    azimuth=azimuth,
)

specular = dict(\
    prototype='processing.hillshading',
    sources='elevation',
    zfactor=zfactor,
    scale=1,
    altitude=85,
    azimuth=azimuth,
    )


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
    sources=['landcover', 'roads', 'labels', 'label_halo',
             'terrain', ],
    format=fmt,
    command='''   
    $1 
    ( $5 -gamma 0.6  ) -compose softlight -composite    
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
    cache=dict(prototype='cluster',
               stride=16,
               servers=['localhost:11211',],
               root=os.path.join(cachedir, 'export', '%s' % tag),
              ),
    pyramid=dict(levels=range(2, 14),
#                   envelope=(-180,-0.58,-52.32,71.60),                 
                 envelope=(-124,34,-70,48),                 
#                envelope=( -123.40/1, 36.444, -118.65, 39.89),
                 zoom=9,
                 center=(-122.4321,37.7702),
                 format=fmt,
                 buffer=0,
                 tile_size=tile_size,
                 ),
)
