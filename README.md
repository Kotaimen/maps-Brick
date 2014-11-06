# Brick Map Theme

## Features

### 2.1

- Imposm3 OSM data import
    - Supports real time OSM replication
- `mapnik2.3+` and `carto 0.9.5`
- Improve road render
    - Only casing and inline is required
    - Road geometries is passed from database only once
    - Real semi-transparent outlined tunnel (same as Google)
- Revised colour themes
    - More flexibility
    - Improved retina support
    - New special effects
- Speedup by employing
    - Data simplify
    - Async `postgis` read
    - Postgres `materialised` view
    - Layer based buffering
    - `mapnik` stylesheet patching 
    
### 2.0

- Imposm3 OSM data import
    - Supports real time OSM replication
- `mapnik2.2+` and `carto 0.9.5`
- `mason-0.9.5`
- Various colour themes
- Retina support
- Transparent tunnel
- Offset road labels
- High quality terrain
    - Merged with primary roadmap theme
- Speedup by use special `mason brick2` cartographer

### 1.0-1.4

- `osm2pgsql` OSM data import
- `mapnik 2.0+`
- `mason-0.9.3`
- Variable depth haloing ("smart halo")
- High quality pre-calculated city names (using simulated annealing)
- Adaptive road z-ordering (idea from Highroad and OSMBright project)

## Sample Render:

> to be updated...