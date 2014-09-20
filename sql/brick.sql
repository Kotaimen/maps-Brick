BEGIN;

CREATE SCHEMA IF NOT EXISTS "brick";

SET search_path TO brick, public;


-- landuse

DROP VIEW IF EXISTS landuse_areas_gen1;
DROP VIEW IF EXISTS landuse_areas_gen0;
DROP VIEW IF EXISTS landuse_areas;
CREATE OR REPLACE VIEW landuse_areas AS SELECT osm_id AS gid, class, type, area, geometry FROM osm_landusage_areas ORDER BY area DESC NULLS LAST, gid;
CREATE OR REPLACE VIEW landuse_areas_gen0 AS SELECT osm_id AS gid, class, type, area, geometry FROM osm_landusages_gen1 ORDER BY area DESC NULLS LAST, gid;
CREATE OR REPLACE VIEW landuse_areas_gen1 AS SELECT osm_id AS gid, class, type, area, geometry FROM osm_landusages_gen0 ORDER BY area DESC NULLS LAST, gid;

DROP VIEW IF EXISTS landuse_ways;
CREATE OR REPLACE VIEW landuse_ways AS SELECT osm_id AS gid, class, type, geometry FROM osm_landusage_ways;

-- water
DROP VIEW IF EXISTS waterareas_gen1;
DROP VIEW IF EXISTS waterareas_gen0;
DROP VIEW IF EXISTS waterareas;
CREATE OR REPLACE VIEW waterareas AS (
    SELECT osm_id AS gid, 'natural'::text AS class, type, area, geometry
        FROM osm_waterareas
    UNION ALL 
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_landusage_areas WHERE type IN ('water', 'pond', 'salt_pond', 'water_reservoir', 'reservoir')
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );
CREATE OR REPLACE VIEW waterareas_gen0 AS (
    SELECT osm_id AS gid, 'natural'::text AS class, type, area, geometry
        FROM osm_waterareas_gen1
    UNION ALL 
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_landusages_gen1 WHERE type IN ('water', 'pond', 'salt_pond', 'water_reservoir', 'reservoir')
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );
CREATE OR REPLACE VIEW waterareas_gen1 AS (
    SELECT osm_id AS gid, 'natural'::text AS class, type, area, geometry
        FROM osm_waterareas_gen0
    UNION ALL 
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_landusages_gen0 WHERE type IN ('water', 'pond', 'salt_pond', 'water_reservoir', 'reservoir')
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );

DROP VIEW IF EXISTS waterways_gen1;
DROP VIEW IF EXISTS waterways_gen0;
DROP VIEW IF EXISTS waterways;
CREATE OR REPLACE VIEW waterways AS SELECT osm_id AS gid, 'natural'::text AS class, type, geometry FROM osm_waterways;
CREATE OR REPLACE VIEW waterways_gen0 AS SELECT osm_id AS gid, 'natural'::text AS class, type, geometry FROM osm_waterways_gen1 WHERE type='river';
CREATE OR REPLACE VIEW waterways_gen1 AS SELECT osm_id AS gid, 'natural'::text AS class, type, geometry FROM osm_waterways_gen0;

-- transport
DROP VIEW IF EXISTS transport_areas;
DROP VIEW IF EXISTS transport_points;
DROP VIEW IF EXISTS aeroways;
DROP VIEW IF EXISTS barrierways;
CREATE OR REPLACE VIEW transport_areas AS SELECT osm_id AS gid, 'transport'::text AS class, type, geometry FROM osm_transport_areas;
CREATE OR REPLACE VIEW transport_points AS SELECT osm_id AS gid, 'transport'::text AS class, type, geometry FROM osm_transport_points;
CREATE OR REPLACE VIEW aeroways AS SELECT osm_id AS gid, 'transport'::text AS class, type, geometry FROM osm_aeroways;
CREATE OR REPLACE VIEW barrierways AS SELECT osm_id AS gid, 'transport'::text AS class, type, geometry FROM osm_barrierways;

-- buildings
DROP VIEW IF EXISTS buildings;
CREATE OR REPLACE VIEW buildings AS SELECT osm_id AS gid, 'building'::text AS class, type, geometry FROM osm_buildings ORDER BY ST_YMin(ST_Envelope(geometry)) DESC;

-- administration
DROP VIEW IF EXISTS admins;
CREATE OR REPLACE VIEW admins AS SELECT osm_id AS gid, 'admin'::text AS class, type, geometry FROM osm_admin WHERE admin_level<=4;


-- roads
DROP VIEW IF EXISTS roads_gen1;
DROP VIEW IF EXISTS roads_gen0;
DROP VIEW IF EXISTS roads;
CREATE OR REPLACE VIEW roads AS 
    SELECT 
        osm_id AS gid,
        class,
        CASE
            WHEN class = 'highway' AND type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
            WHEN class = 'highway' AND type IN ('primary', 'primary_link') THEN 'primary'
            WHEN class = 'highway' AND type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
            WHEN class = 'highway' AND type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
            WHEN class = 'highway' AND type IN ('path', 'track', 'living_street', 'service') THEN 'path'
            WHEN class = 'highway' AND type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 'pedestrian'
            WHEN class = 'highway' AND type IN ('construction', 'proposed') THEN 'proposed'
            WHEN class = 'railway' AND type = 'rail' THEN 'rail'
            WHEN class = 'railway' AND type IN ('subway', 'light_rail') THEN 'subway'
            WHEN class = 'railway' AND type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
            WHEN class = 'railway' THEN 'monorail'
            ELSE 'path'
        END::text AS type,
        tunnel AS is_tunnel,
        bridge AS is_bridge,
        oneway AS is_oneway,
        CASE
            WHEN type ~~ '%_link' THEN 1
            ELSE 0
        END::smallint AS is_link,
        CASE
            WHEN layer IS NULL THEN 0
            ELSE layer
        END::smallint AS layer,
        CASE
            WHEN type = 'motorway' THEN 0
            WHEN type = 'trunk' THEN 20
            WHEN class = 'railway' THEN 30
            WHEN type = 'primary' THEN 40
            WHEN type = 'secondary' THEN 50
            WHEN type = 'tertiary' THEN 60
            
            WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
            WHEN type IN ('path', 'track', 'living_street', 'service') THEN 80
            WHEN type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 90
            WHEN type IN ('construction', 'proposed') THEN 100

            WHEN type = 'motorway_link' THEN 71
            WHEN type = 'trunk_link' THEN 72
            WHEN type = 'primary_link' THEN 73
            WHEN type = 'secondary_link' THEN 74
            WHEN type = 'tertiary_link' THEN 75

            ELSE 255
        END::smallint AS rank,
        geometry
    FROM osm_roads
      ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
CREATE OR REPLACE VIEW roads_gen0 AS 
    SELECT 
        osm_id AS gid,
        class,
        CASE
            WHEN class = 'highway' AND type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
            WHEN class = 'highway' AND type IN ('primary', 'primary_link') THEN 'primary'
            WHEN class = 'highway' AND type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
            WHEN class = 'highway' AND type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
            WHEN class = 'highway' AND type IN ('path', 'track', 'living_street', 'service') THEN 'path'
            WHEN class = 'highway' AND type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 'pedestrian'
            WHEN class = 'highway' AND type IN ('construction', 'proposed') THEN 'proposed'
            WHEN class = 'railway' AND type = 'rail' THEN 'rail'
            WHEN class = 'railway' AND type IN ('subway', 'light_rail') THEN 'subway'
            WHEN class = 'railway' AND type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
            WHEN class = 'railway' THEN 'monorail'
            ELSE 'path'
        END::text AS type,
        tunnel AS is_tunnel,
        bridge AS is_bridge,
        oneway AS is_oneway,
        CASE
            WHEN type ~~ '%_link' THEN 1
            ELSE 0
        END::smallint AS is_link,
        CASE
            WHEN layer IS NULL THEN 0
            ELSE layer
        END::smallint AS layer,
        CASE
            WHEN type = 'motorway' THEN 0
            WHEN type = 'trunk' THEN 20
            WHEN class = 'railway' THEN 30
            WHEN type = 'primary' THEN 40
            WHEN type = 'secondary' THEN 50
            WHEN type = 'tertiary' THEN 60
            
            WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
            WHEN type IN ('path', 'track', 'living_street', 'service') THEN 80
            WHEN type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 90
            WHEN type IN ('construction', 'proposed') THEN 100

            WHEN type = 'motorway_link' THEN 71
            WHEN type = 'trunk_link' THEN 72
            WHEN type = 'primary_link' THEN 73
            WHEN type = 'secondary_link' THEN 74
            WHEN type = 'tertiary_link' THEN 75

            ELSE 255
        END::smallint AS rank,
        geometry
    FROM osm_roads_gen1
    ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
CREATE OR REPLACE VIEW roads_gen1 AS 
    SELECT 
        osm_id AS gid,
        class,
        CASE
            WHEN class = 'highway' AND type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
            WHEN class = 'highway' AND type IN ('primary', 'primary_link') THEN 'primary'
            WHEN class = 'highway' AND type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
            WHEN class = 'highway' AND type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
            WHEN class = 'highway' AND type IN ('path', 'track', 'living_street', 'service') THEN 'path'
            WHEN class = 'highway' AND type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 'pedestrian'
            WHEN class = 'highway' AND type IN ('construction', 'proposed') THEN 'proposed'
            WHEN class = 'railway' AND type = 'rail' THEN 'rail'
            WHEN class = 'railway' AND type IN ('subway', 'light_rail') THEN 'subway'
            WHEN class = 'railway' AND type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
            WHEN class = 'railway' THEN 'monorail'
            ELSE 'path'
        END::text AS type,
        tunnel AS is_tunnel,
        bridge AS is_bridge,
        oneway AS is_oneway,
        CASE
            WHEN type ~~ '%_link' THEN 1
            ELSE 0
        END::smallint AS is_link,
        CASE
            WHEN layer IS NULL THEN 0
            ELSE layer
        END::smallint AS layer,
        CASE
            WHEN type = 'motorway' THEN 0
            WHEN type = 'trunk' THEN 20
            WHEN class = 'railway' THEN 30
            WHEN type = 'primary' THEN 40
            WHEN type = 'secondary' THEN 50
            WHEN type = 'tertiary' THEN 60
            
            WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
            WHEN type IN ('path', 'track', 'living_street', 'service') THEN 80
            WHEN type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 90
            WHEN type IN ('construction', 'proposed') THEN 100

            WHEN type = 'motorway_link' THEN 71
            WHEN type = 'trunk_link' THEN 72
            WHEN type = 'primary_link' THEN 73
            WHEN type = 'secondary_link' THEN 74
            WHEN type = 'tertiary_link' THEN 75

            ELSE 255
        END::smallint AS rank,
        geometry
    FROM osm_roads_gen0
    ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
        

-- labels
DROP VIEW IF EXISTS label_places;
CREATE OR REPLACE VIEW label_places AS
    SELECT 
        osm_id AS gid,
        name,
        type,
        CASE WHEN type = 'country' THEN 1
             WHEN type = 'region' THEN 2
             WHEN type = 'state' THEN 3
             WHEN type = 'city' THEN 4
             WHEN type = 'town' THEN 5
             WHEN type = 'suburb' THEN 6
             WHEN type = 'village' THEN 7
             WHEN type = 'hamlet' THEN 8
             WHEN type = 'locality' THEN 9
             ELSE 10
        END::smallint AS rank,
        population,
        geometry
    FROM osm_places
    ORDER BY rank, population DESC NULLS LAST, osm_id;


DROP VIEW IF EXISTS label_landuse_areas;
CREATE OR REPLACE VIEW label_landuse_areas AS
    SELECT osm_id AS gid, class, type, name, area,
    CASE
        WHEN type IN ( 'hospital', 'doctors', 'clinic', 'nursery', 'dentist') THEN 'hospital'
        WHEN type IN ('university','college') THEN 'college'
        WHEN type = 'museum' THEN 'museum'
        WHEN type IN ('arts_centre', 'gallery') THEN 'art-gallery'
        WHEN type = 'library' THEN 'library'
        WHEN type = 'theatre' THEN 'theatre'
        WHEN type = 'cinema' THEN 'cinema'
        WHEN type = 'school' THEN 'school'
        WHEN type = 'post_office' THEN 'post'
        WHEN type IN ('townhall','public_building', 'courthouse') THEN 'town-hall'
        WHEN type IN ('prison', 'police') THEN 'police'
        WHEN type IN ('hotel', 'motel') THEN 'town'
        WHEN type = 'fire_station' THEN 'fire-station'
        WHEN type = 'zoo' THEN 'zoo'
        WHEN type IN ('stadium', 'sports_centre') THEN 'soccer'
        WHEN type = 'cemetery' THEN 'cemetery'
        WHEN type = 'industrial' THEN 'industrial'
        WHEN type = 'landfill' THEN 'waste-basket'
        WHEN type IN ('retail', 'commercial') THEN 'grocery'
        WHEN type = 'playground'  THEN 'playground'
        WHEN type IN ('recreation_ground', 'pitch') THEN 'pitch'
        WHEN type IN ('golf_range', 'golf_course', 'miniature_golf') THEN 'golf'
        WHEN type IN ('forest', 'meadow', 'grass', 'grassland', 'wood', 'wetland', 'marsh', 'scrub', 'heath', 'park') THEN 'park2'
        WHEN type IN ('garden', 'village_green', 'greenspace')  THEN 'garden'
        WHEN type IN ('railway', 'railroad') THEN 'rail'
        WHEN type IN ('aerodrome', 'airport') THEN 'airport'
        WHEN type = 'airfield' THEN 'airfield'
        WHEN type = 'marina' THEN 'harbor'
        WHEN type IN ('nature_reserve', 'conservation', 'national_park') THEN 'park'
        WHEN type = 'pharmacy' THEN 'pharmacy'
        WHEN type = 'bank' THEN 'bank'
        WHEN type = 'bar' THEN 'bar'
        WHEN type = 'cafe' THEN 'cafe'
        WHEN type = 'parking' THEN 'parking'
        ELSE 'square'
    END::text AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landusage_area_labels
    WHERE class != 'place'
    ORDER BY area DESC, gid;


DROP VIEW IF EXISTS label_landuse_areas_gen0;
CREATE OR REPLACE VIEW label_landuse_areas_gen0 AS
    SELECT osm_id AS gid, class, type, name, area,
    CASE
        WHEN type IN ( 'hospital', 'doctors', 'clinic', 'nursery', 'dentist') THEN 'hospital'
        WHEN type IN ('university','college') THEN 'college'
        WHEN type = 'museum' THEN 'museum'
        WHEN type IN ('arts_centre', 'gallery') THEN 'art-gallery'
        WHEN type = 'library' THEN 'library'
        WHEN type = 'theatre' THEN 'theatre'
        WHEN type = 'cinema' THEN 'cinema'
        WHEN type = 'school' THEN 'school'
        WHEN type = 'post_office' THEN 'post'
        WHEN type IN ('townhall','public_building', 'courthouse') THEN 'town-hall'
        WHEN type IN ('prison', 'police') THEN 'police'
        WHEN type IN ('hotel', 'motel') THEN 'town'
        WHEN type = 'fire_station' THEN 'fire-station'
        WHEN type = 'zoo' THEN 'zoo'
        WHEN type IN ('stadium', 'sports_centre') THEN 'soccer'
        WHEN type = 'cemetery' THEN 'cemetery'
        WHEN type = 'industrial' THEN 'industrial'
        WHEN type = 'landfill' THEN 'waste-basket'
        WHEN type IN ('retail', 'commercial') THEN 'grocery'
        WHEN type = 'playground'  THEN 'playground'
        WHEN type IN ('recreation_ground', 'pitch') THEN 'pitch'
        WHEN type IN ('golf_range', 'golf_course', 'miniature_golf') THEN 'golf'
        WHEN type IN ('forest', 'meadow', 'grass', 'grassland', 'wood', 'wetland', 'marsh', 'scrub', 'heath', 'park') THEN 'park2'
        WHEN type IN ('garden', 'village_green', 'greenspace')  THEN 'garden'
        WHEN type IN ('railway', 'railroad') THEN 'rail'
        WHEN type IN ('aerodrome', 'airport') THEN 'airport'
        WHEN type = 'airfield' THEN 'airfield'
        WHEN type = 'marina' THEN 'harbor'
        WHEN type IN ('nature_reserve', 'conservation', 'national_park') THEN 'park'
        WHEN type = 'pharmacy' THEN 'pharmacy'
        WHEN type = 'bank' THEN 'bank'
        WHEN type = 'bar' THEN 'bar'
        WHEN type = 'cafe' THEN 'cafe'
        WHEN type = 'parking' THEN 'parking'
        ELSE 'square'
    END::text AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landusage_area_labels_gen1
    WHERE class != 'place'
    ORDER BY area DESC, gid;


DROP VIEW IF EXISTS label_landuse_areas_gen1;
CREATE OR REPLACE VIEW label_landuse_areas_gen1 AS
    SELECT osm_id AS gid, class, type, name, area,
    CASE
        WHEN type IN ( 'hospital', 'doctors', 'clinic', 'nursery', 'dentist') THEN 'hospital'
        WHEN type IN ('university','college') THEN 'college'
        WHEN type = 'museum' THEN 'museum'
        WHEN type IN ('arts_centre', 'gallery') THEN 'art-gallery'
        WHEN type = 'library' THEN 'library'
        WHEN type = 'theatre' THEN 'theatre'
        WHEN type = 'cinema' THEN 'cinema'
        WHEN type = 'school' THEN 'school'
        WHEN type = 'post_office' THEN 'post'
        WHEN type IN ('townhall','public_building', 'courthouse') THEN 'town-hall'
        WHEN type IN ('prison', 'police') THEN 'police'
        WHEN type IN ('hotel', 'motel') THEN 'town'
        WHEN type = 'fire_station' THEN 'fire-station'
        WHEN type = 'zoo' THEN 'zoo'
        WHEN type IN ('stadium', 'sports_centre') THEN 'soccer'
        WHEN type = 'cemetery' THEN 'cemetery'
        WHEN type = 'industrial' THEN 'industrial'
        WHEN type = 'landfill' THEN 'waste-basket'
        WHEN type IN ('retail', 'commercial') THEN 'grocery'
        WHEN type = 'playground'  THEN 'playground'
        WHEN type IN ('recreation_ground', 'pitch') THEN 'pitch'
        WHEN type IN ('golf_range', 'golf_course', 'miniature_golf') THEN 'golf'
        WHEN type IN ('forest', 'meadow', 'grass', 'grassland', 'wood', 'wetland', 'marsh', 'scrub', 'heath', 'park') THEN 'park2'
        WHEN type IN ('garden', 'village_green', 'greenspace')  THEN 'garden'
        WHEN type IN ('railway', 'railroad') THEN 'rail'
        WHEN type IN ('aerodrome', 'airport') THEN 'airport'
        WHEN type = 'airfield' THEN 'airfield'
        WHEN type = 'marina' THEN 'harbor'
        WHEN type IN ('nature_reserve', 'conservation', 'national_park') THEN 'park'
        WHEN type = 'pharmacy' THEN 'pharmacy'
        WHEN type = 'bank' THEN 'bank'
        WHEN type = 'bar' THEN 'bar'
        WHEN type = 'cafe' THEN 'cafe'
        WHEN type = 'parking' THEN 'parking'
        ELSE 'square'
    END::text AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landusage_area_labels_gen0
    WHERE class != 'place'
    ORDER BY area DESC, gid;
    

DROP VIEW IF EXISTS label_roads;
CREATE OR REPLACE VIEW label_roads AS
    SELECT     class, type, name, 
            length(name) AS name_length, 
            tunnel AS is_tunnel, 
            bridge AS is_bridge, 
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction,
            geometry
    FROM (
         SELECT     class, 
         CASE
             WHEN class = 'highway' AND type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
             WHEN class = 'highway' AND type IN ('primary', 'primary_link') THEN 'primary'
             WHEN class = 'highway' AND type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
             WHEN class = 'highway' AND type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
             WHEN class = 'highway' AND type IN ('path', 'track', 'living_street', 'service') THEN 'path'
             WHEN class = 'highway' AND type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 'pedestrian'
             WHEN class = 'highway' AND type IN ('construction', 'proposed') THEN 'proposed'
             WHEN class = 'railway' AND type = 'rail' THEN 'rail'
             WHEN class = 'railway' AND type IN ('subway', 'light_rail') THEN 'subway'
             WHEN class = 'railway' AND type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
             WHEN class = 'railway' THEN 'monorail'
             ELSE 'path'
         END::text AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
                tunnel,
                bridge,
                CASE
                    WHEN type = 'motorway' THEN 0
                    WHEN type = 'trunk' THEN 20
                    WHEN class = 'railway' THEN 30
                    WHEN type = 'primary' THEN 40
                    WHEN type = 'secondary' THEN 50
                    WHEN type = 'tertiary' THEN 60
            
                    WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
                    WHEN type IN ('path', 'track', 'living_street', 'service') THEN 80
                    WHEN type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 90
                    WHEN type IN ('construction', 'proposed') THEN 100

                    WHEN type = 'motorway_link' THEN 71
                    WHEN type = 'trunk_link' THEN 72
                    WHEN type = 'primary_link' THEN 73
                    WHEN type = 'secondary_link' THEN 74
                    WHEN type = 'tertiary_link' THEN 75

                    ELSE 255
                END::smallint AS rank,
                geometry
        FROM osm_road_labels
        UNION ALL
        SELECT     'ferry' AS class, 
                'ferry' AS type, 
                name,
                0 AS tunnel,
                0 AS bridge,
                100 as rank,
                geometry
        FROM osm_landusage_ways
        WHERE type='ferry'
    ) AS foo
    ORDER BY rank DESC, name_length DESC, is_bridge DESC, is_tunnel DESC, name;


DROP VIEW IF EXISTS label_roads_gen0;
CREATE OR REPLACE VIEW label_roads_gen0 AS
    SELECT     class, type, name, 
            length(name) AS name_length, 
            tunnel AS is_tunnel, 
            bridge AS is_bridge, 
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction,
            geometry
    FROM (
         SELECT     class, 
         CASE
             WHEN class = 'highway' AND type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
             WHEN class = 'highway' AND type IN ('primary', 'primary_link') THEN 'primary'
             WHEN class = 'highway' AND type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
             WHEN class = 'highway' AND type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
             WHEN class = 'highway' AND type IN ('path', 'track', 'living_street', 'service') THEN 'path'
             WHEN class = 'highway' AND type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 'pedestrian'
             WHEN class = 'highway' AND type IN ('construction', 'proposed') THEN 'proposed'
             WHEN class = 'railway' AND type = 'rail' THEN 'rail'
             WHEN class = 'railway' AND type IN ('subway', 'light_rail') THEN 'subway'
             WHEN class = 'railway' AND type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
             WHEN class = 'railway' THEN 'monorail'
             ELSE 'path'
         END::text AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
                tunnel,
                bridge,
                CASE
                    WHEN type = 'motorway' THEN 0
                    WHEN type = 'trunk' THEN 20
                    WHEN class = 'railway' THEN 30
                    WHEN type = 'primary' THEN 40
                    WHEN type = 'secondary' THEN 50
                    WHEN type = 'tertiary' THEN 60
        
                    WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
                    WHEN type IN ('path', 'track', 'living_street', 'service') THEN 80
                    WHEN type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 90
                    WHEN type IN ('construction', 'proposed') THEN 100

                    WHEN type = 'motorway_link' THEN 71
                    WHEN type = 'trunk_link' THEN 72
                    WHEN type = 'primary_link' THEN 73
                    WHEN type = 'secondary_link' THEN 74
                    WHEN type = 'tertiary_link' THEN 75

                    ELSE 255
                END::smallint AS rank,
                geometry
        FROM osm_road_labels_gen1
    ) AS foo
    ORDER BY rank DESC, name_length DESC, is_bridge DESC, is_tunnel DESC, name;


DROP VIEW IF EXISTS label_roads_gen1;
CREATE OR REPLACE VIEW label_roads_gen1 AS
    SELECT     class, type, name, 
            length(name) AS name_length, 
            tunnel AS is_tunnel, 
            bridge AS is_bridge, 
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction,
            geometry
    FROM (
         SELECT     class, 
         CASE
             WHEN class = 'highway' AND type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
             WHEN class = 'highway' AND type IN ('primary', 'primary_link') THEN 'primary'
             WHEN class = 'highway' AND type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
             WHEN class = 'highway' AND type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
             WHEN class = 'highway' AND type IN ('path', 'track', 'living_street', 'service') THEN 'path'
             WHEN class = 'highway' AND type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 'pedestrian'
             WHEN class = 'highway' AND type IN ('construction', 'proposed') THEN 'proposed'
             WHEN class = 'railway' AND type = 'rail' THEN 'rail'
             WHEN class = 'railway' AND type IN ('subway', 'light_rail') THEN 'subway'
             WHEN class = 'railway' AND type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
             WHEN class = 'railway' THEN 'monorail'
             ELSE 'path'
         END::text AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
                tunnel,
                bridge,
                CASE
                    WHEN type = 'motorway' THEN 0
                    WHEN type = 'trunk' THEN 20
                    WHEN class = 'railway' THEN 30
                    WHEN type = 'primary' THEN 40
                    WHEN type = 'secondary' THEN 50
                    WHEN type = 'tertiary' THEN 60
    
                    WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
                    WHEN type IN ('path', 'track', 'living_street', 'service') THEN 80
                    WHEN type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN 90
                    WHEN type IN ('construction', 'proposed') THEN 100

                    WHEN type = 'motorway_link' THEN 71
                    WHEN type = 'trunk_link' THEN 72
                    WHEN type = 'primary_link' THEN 73
                    WHEN type = 'secondary_link' THEN 74
                    WHEN type = 'tertiary_link' THEN 75

                    ELSE 255
                END::smallint AS rank,
                geometry
        FROM osm_road_labels_gen0
    ) AS foo
    ORDER BY rank DESC, name_length DESC, is_bridge DESC, is_tunnel DESC, name;




COMMIT;