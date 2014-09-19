BEGIN;

CREATE SCHEMA IF NOT EXISTS "brick";

SET search_path TO brick, public;


DROP TABLE IF EXISTS label_shields CASCADE;
CREATE TABLE label_shields AS
    SELECT	class, 
			type,
			ref,
			length(ref) AS ref_length,
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
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            CASE
	                WHEN ref ~ '^I ?\d+' THEN regexp_replace(ref, '^I ?(\d+).*', 'I \1')
	                WHEN ref ~ '^US ?\d+' THEN regexp_replace(ref, '^US ?(\d+).*', 'US \1')
	                WHEN ref ~ '^[[:alpha:]]+ ?\d+' THEN regexp_replace(ref, '^([[:alpha:]]+) ?(\d+).*', '\1 \2')
	                WHEN ref ~ '^[[:alpha:]]+-\d+' THEN regexp_replace(ref, '^([[:alpha:]]+)-(\d+).*', '\1 \2')
	                WHEN ref ~ '^\d+$' THEN ref
	                ELSE ref
	            END AS ref,
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
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            CASE
	                WHEN ref ~ '^I ?\d+' THEN regexp_replace(ref, '^I ?(\d+).*', 'I \1')
	                WHEN ref ~ '^US ?\d+' THEN regexp_replace(ref, '^US ?(\d+).*', 'US \1')
	                WHEN ref ~ '^[[:alpha:]]+ ?\d+' THEN regexp_replace(ref, '^([[:alpha:]]+) ?(\d+).*', '\1 \2')
	                WHEN ref ~ '^[[:alpha:]]+-\d+' THEN regexp_replace(ref, '^([[:alpha:]]+)-(\d+).*', '\1 \2')
	                WHEN ref ~ '^\d+$' THEN ref
	                ELSE ref
	            END AS ref,
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
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            CASE
	                WHEN ref ~ '^I ?\d+' THEN regexp_replace(ref, '^I ?(\d+).*', 'I \1')
	                WHEN ref ~ '^US ?\d+' THEN regexp_replace(ref, '^US ?(\d+).*', 'US \1')
	                WHEN ref ~ '^[[:alpha:]]+ ?\d+' THEN regexp_replace(ref, '^([[:alpha:]]+) ?(\d+).*', '\1 \2')
	                WHEN ref ~ '^[[:alpha:]]+-\d+' THEN regexp_replace(ref, '^([[:alpha:]]+)-(\d+).*', '\1 \2')
	                WHEN ref ~ '^\d+$' THEN ref
	                ELSE ref
	            END AS ref,
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
			    FROM osm_roads_gen1
			    WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'))
				GROUP BY class, type, ref
	) AS foo
    ORDER BY rank, ref_length, ref;
		
		
SELECT POPULATE_GEOMETRY_COLUMNS('label_shields_gen1'::regclass, true);
CREATE INDEX ON label_shields_gen1 USING gist(geometry);
CREATE INDEX ON label_shields_gen1(type);

/*
CREATE TABLE label_roads AS
	SELECT class, type, name, length(name) AS name_length, ref, length(ref) AS ref_length,
		is_tunnel,
		is_bridge,
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
	FROM (
	    SELECT  class, type,
				regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
	            CASE
	                WHEN ref ~ '^I ?\d+' THEN regexp_replace(ref, '^I ?(\d+).*', 'I \1')
	                WHEN ref ~ '^US ?\d+' THEN regexp_replace(ref, '^US ?(\d+).*', 'US \1')
	                WHEN ref ~ '^[[:alpha:]]+ ?\d+' THEN regexp_replace(ref, '^([[:alpha:]]+) ?(\d+).*', '\1 \2')
	                WHEN ref ~ '^[[:alpha:]]+-\d+' THEN regexp_replace(ref, '^([[:alpha:]]+)-(\d+).*', '\1 \2')
	                WHEN ref ~ '^\d+$' THEN ref
	                ELSE ref
	            END AS ref,
				tunnel AS is_tunnel,
				bridge AS is_bridge,
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(
	                        ST_CollectionExtract(ST_Collect(geometry), 2)))))
	                        .geom)::Geometry('MultiLineString', 3857) AS geometry
	    FROM osm_roads			
		WHERE (name IS NOT NULL AND name != '') OR (ref IS NOT NULL AND ref != '') 
		GROUP BY class, type, name, ref, is_tunnel, is_bridge
        UNION ALL
        SELECT 'ferry' AS class, 'ferry' AS type, 
				name,
				NULL AS ref,
				0 AS is_tunnel,
				0 AS is_bridge,
                ST_Multi(geometry)::Geometry('MultiLineString', 3857) AS geometry
        FROM osm_landusage_ways
        WHERE type='ferry'
	
	) AS foo;
	
SELECT POPULATE_GEOMETRY_COLUMNS('label_roads'::regclass, true);
CREATE INDEX ON label_roads USING gist(geometry);
CREATE INDEX ON label_roads(name);
CREATE INDEX ON label_roads(ref);
CREATE INDEX ON label_roads(rank);

*/

COMMIT;