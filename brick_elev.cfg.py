import os


zfactor = 8 # 8,4,2,1
azimuth = 355 

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick'
cachedir= os.path.join(themedir, 'cache')

tag = 'Brick'
tile_size = 256

fmt = 'jpg'

elev_1km = dict(\
    prototype='datasource.dataset',
    dataset_path=os.path.join(datadir, 'srtm30_new/world_tiled.tif'),
    keep_cache=False,
    cache=dict(prototype='metacache',
        root=os.path.join(cachedir, 'elevation'),
        compress=False,
        data_format='gtiff',
        ),
    )
    
elev_30m = dict(\
    prototype='datasource.dataset',
    dataset_path=os.path.join(datadir, 'SRTM_30_org/world/world_3857.tif'),
    keep_cache=False,
    cache=dict(prototype='metacache',
        root=os.path.join(cachedir, 'elevation'),
        compress=False,
        data_format='gtiff',
        ),
    )
    
elev_10m = dict(\
    prototype='datasource.dataset',
    dataset_path=os.path.join(datadir, '/data/tilestorage/geodata/ned/usmainland.vrt'), 
    keep_cache=False,
    cache=dict(prototype='metacache',
        root=os.path.join(cachedir, 'elevation'),
        compress=False,
        data_format='gtiff',
        ),
    )

elevation = dict(\
    prototype='composite.selector',
    sources = ['elev_1km', 'elev_30m', 'elev_10m'],
    
    #            0  1  2  3  4  5  6  7  8  9 10 11 12 13 
    condition = [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2],
    )

terrain = dict(\
    prototype='composite.imagemagick',
    sources=['diffuse', 'detail'],
    format='jpg',
    command='''   
    (
         ( $1 -fill grey50 -colorize 100% )
         ( $1 ) -compose blend -define compose:args=60% -composite
         ( $2 -fill #003cff -tint 35 -gamma 0.8 ) -compose blend -define compose:args=40% -composite
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
    
    
naturalearth = dict(\
    prototype='datasource.dataset',
    dataset_path=os.path.join(datadir, 'natural-earth-2.0b3/raster/NE2_HR_LC/NE2_HR_LC.tiled.tif'),
    )
    
landmask = dict(\
    prototype='datasource.mapnik',
    theme=os.path.join(themedir, 'landmask.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=1
    )

waterbody = dict(\
    prototype='datasource.mapnik',
    theme=os.path.join(themedir, 'waterbody.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=1
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
             'terrain', 
             'naturalearth', 'landmask', 'waterbody',
             ],
    format=fmt,
    command='''   
    $1
#    ( 
#      ( $6 -modulate 100,90,97 -gamma 1.6 -brightness-contrast -0%-10% ) 
#      $7 -compose copyopacity -composite
#    ) -compose over -composite
    
    ( $5 -gamma 0.6 ) -compose softlight -composite    
    
#    $8 -compose over -composite
    
    ( 
        $2
        ( $4 
        #-channel RGBA -blur %(scale)d +channel 
        ) -compose dst-out -composite
    ) -compose over -composite
    ( $3 ) -compose over -composite    
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
    pyramid=dict(levels=range(2, 14),
#                envelope=[-127,27,-67,50], # US mainland
                 zoom=9,
                 center=(-122.4321,37.7702),
                 format=fmt,
                 buffer=8,
                 tile_size=tile_size,
                 ),
)
