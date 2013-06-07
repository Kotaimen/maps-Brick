import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick'
cachedir= os.path.join(themedir, 'cache')

tag = 'Brick_elev'
tile_size = 256

fmt = 'jpg'

azimuth = 325

srtm30_new = os.path.join(datadir, 'srtm30_new/world_tiled.tif')
srtm30_org = os.path.join(datadir, 'SRTM_30_org/world_filled')
ned10 = os.path.join(datadir, 'DEM-Tools-patch/source/ned10m_3857/')


hillshading = dict(\
    prototype='node.homebrewhillshade',
#    dataset_path='/mnt/geodata/DEM-Tools-patch/source/ned100m',
    dataset_path=[
                  srtm30_new, #0
                  srtm30_new, #1
                  srtm30_new, #2
                  srtm30_new, #3
                  srtm30_new, #4
                  srtm30_new, #5
                  srtm30_new, #6
                  [srtm30_new, srtm30_org], #7
                  [srtm30_new, srtm30_org], #8
                  [srtm30_new, srtm30_org], #9
                  [srtm30_new, srtm30_org], #10
                  [srtm30_org, ned10], #11
                  [srtm30_org, ned10], #12
                  [srtm30_org, ned10], #13
#                  [srtm30_new, srtm30_org, ned10, ned3], #14
                  ned10,
#                  [srtm30_new, srtm30_org, ned10, ned3], #15
                  ned10,
                  ],
    #          0  1    2    3  4    5  6   7   8  9 10 11
    zfactor=[100, 90, 80, 50, 40, 20, 16, 13, 10, 8, 6, 5],
    scale=1,
    azimuth=azimuth,
    )

landcover = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'brick-landcover.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=tile_size//256
    )

roads = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'brick-roads.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=tile_size//256
    )

labels = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'brick-labels.xml'),
    image_type='png',
    buffer_size=tile_size*2,
    scale_factor=tile_size//256
    )

label_halo = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'brick-labels_halo.xml'),
    image_type='png',
    buffer_size=tile_size* 2,
    scale_factor=tile_size//256
    )

waterbody = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'waterbody.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=tile_size//256
    )


composer=dict(\
    prototype='node.imagemagick',

    sources=[
        'hillshading', 
        'landcover', 
        'waterbody',        
        'roads', 'labels', 'label_halo', 
    ],
    format=fmt,
    command='''
    {{landcover}}
    
    ( {{hillshading}} -modulate 100,0,100 -brightness-contrast -14%%x-10%% -gamma 0.8 -sharpen 0x0.6 ) -compose softlight -composite
    {{waterbody}} -compose over -composite
    (
        {{roads}}
        ( {{label_halo}}
        #-channel RGBA -blur %(scale)d +channel
        ) -compose dst-out -composite
    ) -compose over -composite
    ( {{labels}} ) -compose over -composite
#     -colorspace gray -fill wheat -tint 120
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
     storage=dict(prototype='cluster',
                stride=16,
                servers=['localhost:11211',],
                root=os.path.join(cachedir, 'export', '%s_1303' % tag),
               ),
    pyramid=dict(levels=range(2, 19),
#                envelope=[-127,27,-67,50], # US mainland
#                envelope=(-124,34,-70,48),
#                envelope=( -123.40/1, 36.444, -118.65, 39.89),
                 zoom=9,
                 center=(-122.4321,37.7702),
                 format=fmt,
                 buffer=4,
                 tile_size=tile_size,
                 ),
)
