# ============================================================================
# Terrain Render Configuration File
# ============================================================================

version = 0.95

import os

# ============================================================================
# Global variables

tag = 'terrain2'
tile_size = 256
fmt = 'jpg'
scalefactor = 1 # label scale factor
azimuth = 325 # light direction

datadir = '/Users/Kotaimen/proj/geodata'
themedir = './themes/Brick2.mk7'
exportdir = os.path.join(themedir, 'cache', 'export')
cachedir = os.path.join(themedir, 'cache', 'terrain_tmp')


# ============================================================================
# Relief data

# Land relief with bathymetry, 90m resolution
srtm30_new = os.path.join(datadir, 'srtm30_new/world_tiled.tif')
# SRTM30, 30m resolution
srtm30_org = os.path.join(datadir, 'SRTM_30_org/world_filled/')
# NED 100m resolution, USA mainland only
ned100 = os.path.join(datadir, 'DEM-Tools-patch/source/ned100m/')
# NED 10m resolution, USA mainland, Hawaii
ned10 = os.path.join(datadir, 'DEM-Tools-patch/source/ned10m_3857/')
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
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'bathymetry_elevation'),
               compress=False,
               data_format='gtiff',
        ),
    )

bathymetry_hypsometricmap = dict(\
    prototype='node.colorrelief',
    sources='bathymetry_elevation',
    color_context=os.path.join(themedir, 'mapnik/terrain/hypsometric-map-ocean.txt'),
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'bathymetry_hypsometricmap'),
               compress=False,
               data_format='png',
              ),
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
                  [ned10, srtm30_org], #12
                  [ned10, srtm30_org], #13
                  [ned10, srtm30_org], #14
                  ned10,
#                  [ned10, srtm30_org], #15
#                  [ned3, ned10], #16
                  ],
    #          0  1    2    3  4    5  6   7   8  9 10 11
    zfactor=[100, 90, 80, 50, 40, 20, 16, 13, 10, 8, 6, 5],
    scale=1,
    azimuth=azimuth,
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'land_relief'),
               compress=False,
               data_format='jpg',
        ),
    )

# Land coloring
land_cover = dict(\
    prototype='node.raster',
    dataset_path=os.path.join(datadir, 'natural-earth-2.0b3/raster/NE2_HR_LC_2/NE2_HR_LC_3857.tif'),
#    dataset_path=os.path.join(datadir, 'natural-earth-2.0b3/raster/HYP_HR/HYP_HR_tiled.tif'),
#    dataset_path=os.path.join(datadir, '_processed/landcover-rgb-4326.tif'),
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

builtup_area = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'builtuparea.xml'),
    image_type='png',
    buffer_size=tile_size//4,
    scale_factor=1
    )

waterbody = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/terrain/waterbody.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=1
    )

relief_contours = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/terrain/contours.xml'),
    image_type='png',
    buffer_size=tile_size//2,
    scale_factor=1,
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'contours'),
               compress=False,
               data_format='png',
        ),
    )

# ============================================================================
# Roads

road = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/terrain_road.xml'),
    image_type='png',
    buffer_size=16,
    scale_factor=2
    )

label = dict(\
    prototype='node.mapnik',
    theme=os.path.join(themedir, 'mapnik/xml/terrain_label.xml'),
    image_type='png',
    buffer_size=tile_size*2,
    scale_factor=2
    )


# ============================================================================
# Composing

composer = dict(
    prototype='node.imagemagick',
    sources=['land_hillshading', 'land_cover',
      	     'bathymetry_relief', 'ocean_mask',
#              'relief_contours',
             'bathymetry_hypsometricmap',
             'waterbody',
             'road',
             'label'
             ],
    format=fmt,
    command='''
        {{land_hillshading}} -brightness-contrast -15%%x-5%%
        (
            {{land_cover}}
            -brightness-contrast -10%%x-5%%
            %(blur_radius)s
        ) -compose Overlay -composite
        -sharpen 0x0.9
        -gamma %(land_gamma)s
        -sigmoidal-contrast 1.9

        #### Contours ####
#         ( {{relief_contours}} ) -compose Multiply -composite

        #### Land overlay ####
        {{waterbody}} -compose Over -composite

        #### Bathymetry overlay ####
        (
            {{bathymetry_relief}}
            {{ocean_mask}} -compose CopyOpacity -composite
        ) -compose Over -composite

        (
            {{road}}
            -brightness-contrast 0%%x-12%%
        ) -compose HardLight -composite

        #### Label ####

        (
            {{bathymetry_hypsometricmap}} -brightness-contrast +10%%             +level 15%%,100%%
            {{ocean_mask}} -compose DstIn -composite
            {{land_cover}} -brightness-contrast -10%%x-5%% -compose DstOver -composite
            {{waterbody}} -compose Over -composite

            ( {{label}} -channel A -morphology EdgeOut Disk:3  +channel ) -compose DstIn -composite
        ) -compose Lighten -composite

#   (
#             {{label}} -geometry +2+2
#             -channel A -virtual-pixel edge -blur 0x2
#             -evaluate Multiply 0.4 +channel
#             +level-colors black
#         ) -compose Multiply -composite

        ( {{label}} ) -compose Over -composite

        -quality 90
    ''',
    command_params=dict(
                         #       1          2          3          4          5          6
        blur_radius=     ['-blur 3', '-blur 3', '-blur 2', '-blur 2', '-blur 2', '-blur 1', ''],
                         #   0     1     2     3     4     5     6     7     8     9   10   11   12   13
    	land_gamma=      [0.67, 0.67, 0.67, 0.70, 0.71, 0.72, 0.77, 0.81, 0.86, 0.86, 0.9, 0.9, 0.9, 1.0],
        label_intensity= [0   ,    0,    0,    0,    2,    3,    5,    6,    7,   10],
    	),
    )

ROOT = dict(\
    renderer='composer',
    metadata=dict(tag=tag,
                  version='2.0',
                  description='High Quality Shaded Relief Map',
                  attribution='OSM, SRTM+, NED',
                  ),

    storage=dict(prototype='cluster',
             stride=16,
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
                 buffer=32,
                 tile_size=tile_size,
                 ),
)

