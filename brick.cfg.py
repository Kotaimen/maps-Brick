import os

 
zfactor=3 # Reduce this when using high resolution data!
azimuth=345
 
datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Brick'
cachedir= os.path.join(themedir, 'cache')
tag = 'Brick'

tile_size = 256

# 
# elevation = dict(\
#     prototype='datasource.dataset',
#     # 2-7
# #    dataset_path=os.path.join(datadir, 'srtm30_new/world_tiled.tif'), # (2-7)
#     # 8-11
# #    dataset_path=os.path.join(datadir, '/home/pset/proj/geodata/SRTM_30_org/world/fill/world.900913.vrt'),
#     # 12-16
#    dataset_path=os.path.join(datadir, 'sf_10m/sf.vrt'),
#     cache=dict(prototype='metacache',
#         root=os.path.join(cachedir, 'elevation'),
#         compress=True,
#         data_format='gtiff',
#         ),
#     )
# 
# diffuse = dict(\
#     prototype='processing.hillshading',
#     sources='elevation',
#     zfactor=zfactor,
#     scale=1,
#     altitude=25,
#     azimuth=azimuth,
#     )
# 
# detail = dict(\
#     prototype='processing.hillshading',
#     sources='elevation',
#     zfactor=1.5,
#     scale=1,
#     altitude=45,
#     azimuth=azimuth,
# )
# 
# specular = dict(\
#     prototype='processing.hillshading',
#     sources='elevation',
#     zfactor=zfactor,
#     scale=1,
#     altitude=90,
#     azimuth=azimuth,
#     )
# 
# 
# terrain = dict(\
#     prototype='composite.imagemagick',
# #    cache=dict(prototype='metacache',
# #               root=os.path.join(cachedir, '%s' % tag),
# #               data_format='png',
# #               ),                  
#     sources=['diffuse', 'detail', 'specular'],
#     format='jpg',
#     command='''   
#     (
#         ( $1 -fill grey50 -colorize 100% )
#         ( $1 ) -compose blend -define compose:args=60% -composite
#         ( $2 -brightness-contrast +0%x+30% ) -compose blend -define compose:args=20% -composite    
#         ( $3 -gamma 4 ) -compose blend -define compose:args=20% -composite     
#         -brightness-contrast -20%x-30%
# #        -gamma 0.9
#         -quality 90
#     )
#     '''
#     )


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
    buffer_size=tile_size*2,
    scale_factor=tile_size//256
    )


composer=dict(\
    prototype='composite.imagemagick',   
    sources=['landcover', 'roads', 'labels', 'label_halo',  #'terrain'
             ],
    format='png',
    command='''   
    $1 
#    ( $5 ) -compose softlight -composite
   ( 
     $2
     $4 -compose dst-out -composite
   ) -compose over -composite
   ( $3 ) -compose over -composite    
#     -quality 90
    '''
    )

ROOT = dict(\
    renderer='composer',
    metadata=dict(tag=tag,
                  version='1.0',
                  description='',
                  attribution='',
                  ),
#     cache=dict(prototype='filesystem',
#                root=os.path.join(cachedir, 'export', '%s' % tag),
#                data_format='jpg',
#                simple=False
#               ),
#    cache=dict(prototype='mbtiles',
#               database=os.path.join(cachedir, 'export', '%s.mbtiles' % tag),
#               data_format='jpg',
#               ),                            
    pyramid=dict(levels=range(2, 19),
                 envelope=(-180,-0.582078122168095,-52.3231981114464,71.6048216388151),                 
#                 envelope=( -123.401, 36.444, -118.65, 39.89),
                 zoom=9,
                 center=(-122.4321,37.7702),
                 format='jpg',
                 buffer=8,
                 tile_size=tile_size,
                 ),
)
