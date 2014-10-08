BEGIN;

CREATE SCHEMA IF NOT EXISTS "brick";

SET search_path TO brick, public;


-- landuse
DROP VIEW IF EXISTS landuse_areas;
DROP VIEW IF EXISTS landuse_areas_gen0;
DROP VIEW IF EXISTS landuse_areas_gen1;
CREATE OR REPLACE VIEW landuse_areas AS 
	SELECT osm_id AS gid, class, type, area, geometry 
	FROM osm_landuse_areas 
	ORDER BY area DESC NULLS LAST, gid;
CREATE OR REPLACE VIEW landuse_areas_gen0 AS 
	SELECT osm_id AS gid, class, type, area, geometry 
	FROM osm_landuse_areas_gen0 
    WHERE type NOT IN ('water')
	ORDER BY area DESC NULLS LAST, gid;
CREATE OR REPLACE VIEW landuse_areas_gen1 AS 
	SELECT osm_id AS gid, class, type, area, geometry 
	FROM osm_landuse_areas_gen1 
    WHERE type NOT IN ('forest', 'meadow', 'grass', 'grassland', 'wood', 'heath', 'farmland', 'farm_land', 'farm')
    AND class NOT IN ('place', 'natural')
	ORDER BY area DESC NULLS LAST, gid;

DROP VIEW IF EXISTS landuse_ways;
CREATE OR REPLACE VIEW landuse_ways AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_landuse_ways;


-- water
DROP VIEW IF EXISTS waterareas;
DROP VIEW IF EXISTS waterareas_gen0;
DROP VIEW IF EXISTS waterareas_gen1;
CREATE OR REPLACE VIEW waterareas AS (
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_waterareas
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );
CREATE OR REPLACE VIEW waterareas_gen0 AS (
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_waterareas_gen0
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );
CREATE OR REPLACE VIEW waterareas_gen1 AS (
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_waterareas_gen1
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );

DROP VIEW IF EXISTS waterways;
DROP VIEW IF EXISTS waterways_gen0;
DROP VIEW IF EXISTS waterways_gen1;
CREATE OR REPLACE VIEW waterways AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_waterways;
CREATE OR REPLACE VIEW waterways_gen0 AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_waterways_gen0;
CREATE OR REPLACE VIEW waterways_gen1 AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_waterways_gen1;


-- transports
DROP VIEW IF EXISTS transport_areas;
DROP VIEW IF EXISTS transport_points;
DROP VIEW IF EXISTS aeroways;
DROP VIEW IF EXISTS barrierways;
CREATE OR REPLACE VIEW transport_areas AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_transport_areas;
CREATE OR REPLACE VIEW transport_points AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_transport_points;
CREATE OR REPLACE VIEW aeroways AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_aeroways;
CREATE OR REPLACE VIEW barrierways AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_barrierways;


-- buildings
DROP VIEW IF EXISTS buildings;
CREATE OR REPLACE VIEW buildings AS 
	SELECT osm_id AS gid, class, type, geometry 
	FROM osm_buildings 
	ORDER BY ST_YMin(ST_Envelope(geometry)) DESC;

-- administration
DROP VIEW IF EXISTS admins;
CREATE OR REPLACE VIEW admins AS 
	SELECT osm_id AS gid, class, type, admin_level, geometry 
	FROM osm_boundary 
	WHERE type='administrative';

-- roads
DROP VIEW IF EXISTS roads;
DROP VIEW IF EXISTS roads_gen0;
DROP VIEW IF EXISTS roads_gen1;
CREATE OR REPLACE VIEW roads AS 
    SELECT 
        osm_id AS gid,
        class,
        road_type(class, type) AS type,
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
        road_rank(class, type) AS rank,
        geometry
    FROM osm_roads
    ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
CREATE OR REPLACE VIEW roads_gen0 AS 
    SELECT 
        osm_id AS gid,
        class,
        road_type(class, type) AS type,
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
        road_rank(class, type) AS rank,
        geometry
    FROM osm_roads_gen0
    ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
CREATE OR REPLACE VIEW roads_gen1 AS 
    SELECT 
        osm_id AS gid,
        class,
        road_type(class, type) AS type,
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
        road_rank(class, type) AS rank,
        geometry
    FROM osm_roads_gen1
    ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
        

-- labels
DROP VIEW IF EXISTS label_places;
CREATE OR REPLACE VIEW label_places AS
    SELECT 
        osm_id AS gid,
        name,
        type,
        place_rank(type) AS rank,
        population,
        geometry
    FROM osm_places
    ORDER BY rank, population DESC NULLS LAST, gid;


DROP VIEW IF EXISTS label_landuse_areas;
CREATE OR REPLACE VIEW label_landuse_areas AS
    SELECT osm_id AS gid, class, type, name, area,
    landuse_maki(class, type) AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landuse_areas
    WHERE ST_IsValid(geometry) AND name IS NOT NULL AND name != '' AND class != 'place'
    ORDER BY area DESC, gid;


DROP VIEW IF EXISTS label_landuse_areas_gen0;
CREATE OR REPLACE VIEW label_landuse_areas_gen0 AS
    SELECT osm_id AS gid, class, type, name, area,
    landuse_maki(class, type) AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landuse_areas_gen0
    WHERE ST_IsValid(geometry) AND name IS NOT NULL AND name != '' AND class != 'place'
    ORDER BY area DESC, gid;


DROP VIEW IF EXISTS label_landuse_areas_gen1;
CREATE OR REPLACE VIEW label_landuse_areas_gen1 AS
    SELECT osm_id AS gid, class, type, name, area,
    landuse_maki(class, type) AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landuse_areas_gen1
    WHERE ST_IsValid(geometry) AND name IS NOT NULL AND name != '' AND class != 'place'
    ORDER BY area DESC, gid;
    



COMMIT;