Brick Map Theme
===============

Global general road map using OSM data, including:
- MapBox project files
- Patched mapnik XML themes
- PGSQL scripts for processing OSM data
- Mason map configuration file
- Shields and markers

These are not included:
- OSM planet dump database using `osm2pgsql`
- Natural earth shapefiles
- OSM landmass shapefile
- Scripts for processing city labels using simulated annealing algorithm
- Manually placed top-layer country and city labels
- Scripts for processing DEM data (see Terrain project)

This implemented following cartographic features:
- Variable depth label haloing ("smart halo")
- High quality pre-calculated city names
- Adaptive road z-ordering

Borrowed ideas from Highroad and OSMBright project.

Requires mason-0.9.3.

Note1: Although mason is designed for poorman, OSM-planet-dump database import, data conversion and cache render requires a lot of processing power (or time).  (We cached all cities down to level 18 (see TileBitmap project) using two Intel i5 PCs with 16GB memory in 4 weeks, generating 100GB database file and 500GB tile cache.)

Sample renders:

![Preview 1](https://raw.github.com/Kotaimen/maps-Brick/master/sample-0.jpg)

![Preview 2](https://raw.github.com/Kotaimen/maps-Brick/master/sample-1.jpg)

![Preview 3](https://raw.github.com/Kotaimen/maps-Brick/master/sample-2.jpg)

![Preview 4](https://raw.github.com/Kotaimen/maps-Brick/master/sample-3.jpg)

![Preview 5](https://raw.github.com/Kotaimen/maps-Brick/master/sample-4.jpg)

![Preview 6](https://raw.github.com/Kotaimen/maps-Brick/master/sample-5.jpg)

For a demo map, check [here](http://maps.masonmaps.me/index.html).

