BEGIN;

CREATE SCHEMA IF NOT EXISTS "brick";

SET search_path TO brick, public;


DROP TABLE IF EXISTS label_shields CASCADE;
CREATE TABLE label_shields AS
    SELECT	class, 
			type,
			ref,
			length(ref) AS ref_length,
		    road_rank(class, type) AS rank,
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            normalize_shield_name(class, type, ref) AS ref,
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
			    FROM osm_roads
			    WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'))
				GROUP BY class, type, ref
	) AS foo
    ORDER BY rank, ref_length, ref;
SELECT POPULATE_GEOMETRY_COLUMNS('label_shields'::regclass, true);
CREATE INDEX ON label_shields USING gist(geometry);
CREATE INDEX ON label_shields(type);


DROP TABLE IF EXISTS label_shields_gen0 CASCADE;
CREATE TABLE label_shields_gen0 AS
    SELECT	class, 
			type,
			ref,
			length(ref) AS ref_length,
		    road_rank(class, type) AS rank,
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            normalize_shield_name(class, type, ref) AS ref,
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
			    FROM osm_roads_gen0
			    WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'))
				GROUP BY class, type, ref
	) AS foo
    ORDER BY rank, ref_length, ref;
SELECT POPULATE_GEOMETRY_COLUMNS('label_shields_gen0'::regclass, true);
CREATE INDEX ON label_shields_gen0 USING gist(geometry);
CREATE INDEX ON label_shields_gen0(type);


DROP TABLE IF EXISTS label_shields_gen1 CASCADE;
CREATE TABLE label_shields_gen1 AS
    SELECT	class, 
			type,
			ref,
			length(ref) AS ref_length,
		    road_rank(class, type) AS rank,
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            normalize_shield_name(class, type, ref) AS ref,
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
			    FROM osm_roads_gen1
			    WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'))
				GROUP BY class, type, ref
	) AS foo
    ORDER BY rank, ref_length, ref;
SELECT POPULATE_GEOMETRY_COLUMNS('label_shields_gen1'::regclass, true);
CREATE INDEX ON label_shields_gen1 USING gist(geometry);
CREATE INDEX ON label_shields_gen1(type);


DROP TABLE IF EXISTS label_roads_gen0 CASCADE;
CREATE TABLE label_roads_gen0 AS
    SELECT  class, 
			type, 
			name, 
			length(name) AS name_length,
			0 AS is_tunnel,
			0 AS is_bridge,
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction,
            road_rank(class, type) AS rank,
            geometry
    FROM (
         SELECT	class, 
		        road_type(class, type) AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name, 
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom)::Geometry('MultiLineString', 3857) AS geometry
        FROM osm_road_labels_gen1
		GROUP BY class, type, name
    ) AS foo
    ORDER BY rank, name_length, name;
SELECT POPULATE_GEOMETRY_COLUMNS('label_roads_gen0'::regclass, true);
CREATE INDEX ON label_roads_gen0 USING gist(geometry);
CREATE INDEX ON label_roads_gen0(type);
	

DROP TABLE IF EXISTS label_roads_gen1 CASCADE;
CREATE TABLE label_roads_gen1 AS
    SELECT  class, 
			type, 
			name, 
			length(name) AS name_length,
			0 AS is_tunnel,
			0 AS is_bridge,
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction,
            road_rank(class, type) AS rank,
            geometry
    FROM (
         SELECT	class, 
		        road_type(class, type) AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name, 
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom)::Geometry('MultiLineString', 3857) AS geometry
        FROM osm_road_labels_gen0
		GROUP BY class, type, name
    ) AS foo
    ORDER BY rank, name_length, name;
SELECT POPULATE_GEOMETRY_COLUMNS('label_roads_gen1'::regclass, true);
CREATE INDEX ON label_roads_gen1 USING gist(geometry);
CREATE INDEX ON label_roads_gen1(type);


DROP TABLE IF EXISTS label_roads CASCADE;
CREATE TABLE label_roads AS
    SELECT     class, type, name, 
            length(name) AS name_length, 
            tunnel AS is_tunnel, 
            bridge AS is_bridge, 
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction,
            st_segmentize(geometry, 1000) AS geometry
    FROM (
         SELECT     class, 
         		road_type(class, type) AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
                tunnel,
                bridge,
                road_rank(class, type) AS rank,
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

SELECT POPULATE_GEOMETRY_COLUMNS('label_roads'::regclass, true);
CREATE INDEX ON label_roads USING gist(geometry);
CREATE INDEX ON label_roads(class);
CREATE INDEX ON label_roads(type);

COMMIT;