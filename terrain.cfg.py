# ============================================================================
# Terrain Render Configuration File
# ============================================================================

version = 0.95

import os

# ============================================================================
# Global variables

tag = 'terrain'
tile_size = 256
fmt = 'jpg'
azimuth = 325 # light direction

datadir = os.path.expanduser('~/proj/geodata')
themedir = './themes/Brick2.mk9'
exportdir = os.path.join(themedir, 'cache', 'export')
cachedir = os.path.join(themedir, 'cache', 'terrain_tmp')


# ============================================================================
# Relief data

# Land relief with bathymetry, 90m resolution
srtm30_new = os.path.join(datadir, 'Stage/SRTM30PLUS/NetCDF2GTIFF/world.3857.tif')
# SRTM30, 30m resolution
srtm30_org = os.path.join(datadir, 'Stage/SRTM3/world.3857.vrt')
# NED 100m resolution, USA mainland only
ned100 = os.path.join(datadir, 'Stage/NED100M/')
# NED 10m resolution, USA mainland, Hawaii
ned10 = os.path.join(datadir, 'Stage/NED10M/')
# NED 3m resolution, only in part areas
ned3 = os.path.join(datadir, 'DEM-Tools-patch/source/ned3m/')

# New zealand 10m
nz = os.path.join(datadir, 'lris-new-zealand/all.tif')


# ============================================================================
# Bathymetry relief, using GDAL engine

#    0   1   2   3   4   5   6   7   8   9  10
bathymetry_zfactors = \
   [35, 30, 30, 25, 15,  10, 7,  4,  3,  2,  1]

bathymetry_zfactors_half = map(lambda x: x/2., bathymetry_zfactors)

bathymetry_elevation = dict(\
    prototype='node.raster',
    dataset_path=srtm30_new,
    keep_cache=False,
    )

bathymetry_hypsometricmap = dict(\
    prototype='node.colorrelief',
    sources='bathymetry_elevation',
    color_context=os.path.join(themedir, 'mapnik/terrain/hypsometric-map-ocean.txt'),
    )

bathymetry_diffuse = dict(\
    prototype='node.hillshading',
    sources='bathymetry_elevation',
    zfactor=bathymetry_zfactors,
    scale=1,
    altitude=35,
    azimuth=azimuth,
    )

bathymetry_detail = dict(\
    prototype='node.hillshading',
    sources='bathymetry_elevation',
    zfactor=bathymetry_zfactors_half,
    scale=1,
    altitude=65,
    azimuth=azimuth,
)

bathymetry_specular = dict(\
    prototype='node.hillshading',
    sources='bathymetry_elevation',
    zfactor=bathymetry_zfactors,
    scale=1,
    altitude=85,
    azimuth=azimuth,
    )

bathymetry_relief = dict(\
    prototype='node.imagemagick',
    sources=['bathymetry_diffuse', 'bathymetry_detail', 'bathymetry_specular', 'bathymetry_hypsometricmap'],
    format='jpg',
    command='''
    (
         ( {{bathymetry_diffuse}} -fill grey50 -colorize 100%% )
         ( {{bathymetry_diffuse}} ) -compose blend -define compose:args=30%% -composite
         ( {{bathymetry_detail}} -fill #4C78FF -tint 80 -gamma 0.8  ) -compose blend -define compose:args=40%% -composite
         ( {{bathymetry_specular}} -gamma 2 ) -compose blend -define compose:args=30%% -composite
         -brightness-contrast -11%%x-0%%
         ( {{bathymetry_hypsometricmap}} ) -compose overlay -composite
 		 -quality 100
    )
    ''',
    )


# ============================================================================
# Land terrain relief, using homebrew blending engine, which supports overlay
# different resolution data together.

# Rule of thumb:
# 100m resolution - level < 7
# 30m resolution - level < 11
# 10m resolution - level < 14
# 3m resolution - level < 17

land_hillshading = dict(\
    prototype='node.homebrewhillshade',
    dataset_path=[
                  srtm30_new, #0
                  srtm30_new, #1
                  srtm30_new, #2
                  srtm30_new, #3
                  srtm30_new, #4
                  srtm30_new, #5
                  srtm30_new, #6
                  [srtm30_org, srtm30_new], #7
                  [srtm30_org, srtm30_new], #8
                  [srtm30_org, srtm30_new], #9
                  [srtm30_org, srtm30_new], #10
                  [ned10, srtm30_org], #11
                  ned10, #12
                  ned10, #13
                  ned10, #14
                  ned10,
#                  [ned10, srtm30_org], #15
#                  [ned3, ned10], #16
                  ],
    #          0  1    2    3  4    5  6   7   8  9 10 11
    zfactor=[100, 90, 80, 50, 40, 20, 16, 13, 10, 8, 6, 5],
    scale=1,
    azimuth=azimuth,
    )

# Land coloring
land_cover = dict(\
    prototype='node.raster',
    dataset_path=os.path.join(datadir, 'Vanilla/NaturalEarth2/raster/NE2_HR_LC/NE2_HR_LC.tiled.tif'),
    )


# ============================================================================
# Landmass, Waterbody masks

ocean_mask = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/terrain/watermask.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=1
    )

waterbody = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/terrain/waterbody.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=1
    )


# ============================================================================
# Roads

road = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/terrain_road.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=1
    )


label = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/terrain_label_halo.xml'),
    image_type='png',
    buffer_size=tile_size,
    scale_factor=1
    )

# ============================================================================
# Composing

terrain = dict(
    prototype='node.imagemagick',
    sources=[
        'land_hillshading', 'land_cover',
        'bathymetry_relief', 'ocean_mask',
        'waterbody',
    ],
    format=fmt,
    command='''
        #### Land ####
        {{land_hillshading}} -brightness-contrast -15%%x-5%%
        (
            {{land_cover}} -brightness-contrast -10%%x-5%% %(blur_radius)s
        ) -compose Overlay -composite
        
        -sharpen 0x1
        -gamma %(land_gamma)s
        -sigmoidal-contrast 2

        #### Land overlay ####        
        {{waterbody}} -compose Over -composite
        
        #### Bathymetry overlay ####
        (
            {{bathymetry_relief}}
            {{ocean_mask}} -compose CopyOpacity -composite
        ) -compose Over -composite

        -quality 100 
    ''',
    command_params=dict(
                         #       1          2          3          4          5          6
        blur_radius=     ['-blur 3', '-blur 3', '-blur 2', '-blur 2', '-blur 2', '-blur 1', ''],
                         #   0     1     2     3     4     5     6     7     8     9   10   11   12   13
    	land_gamma=      [0.67, 0.67, 0.67, 0.70, 0.71, 0.72, 0.77, 0.81, 0.86, 0.86, 0.9, 0.9, 0.9, 1.0],
    	),
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'terrain'),
               compress=False,
               data_format='jpg',
        ),
    )

composer = dict(
    prototype='node.imagemagick',
    sources=[
        'terrain', 'road', 'label', 
    ],
    format=fmt,
    command='''
        {{terrain}}

        #### Road ####
        {{road}} -compose HardLight -composite

        #### Label ####
        (
            {{terrain}} +level 40%,70%
            ( {{label}} -channel A -morphology EdgeOut Disk:1 +channel ) -compose DstIn -composite
        ) -compose Lighten -composite

        {{label}} -compose Over -composite
        -quality 85 
    ''',
    
    )

ROOT = dict(\
    renderer='composer',
    metadata=dict(tag=tag,
                  dispname='Terrain2',
                  version='2.0',
                  description='High Quality Shaded Relief Map',
                  attribution='OSM, SRTM+, NED',
                  ),

    storage=dict(prototype='cluster',
             stride=8,
             servers=['localhost:11211',],
             root=os.path.join(exportdir, '%s' % tag),
             ),

    pyramid=dict(levels=range(0, 17),
#                 envelope=[-127,27,-67,50], # US mainland
#                 envelope=[-93,27,-67,50], # US mainland
#                 envelope=[-159,18,-154,22], # US Hawaii
# 				  envelope=[-122.4475, 37.7879,-122.4474, 37.7880],
                 zoom=5,
                 center=(-122.4475, 37.7879),
                 format=fmt,
                 buffer=8,
                 tile_size=tile_size,
                 ),
)
