BEGIN;

SET search_path TO import, public;


CREATE OR REPLACE VIEW brick_places AS
    SELECT *,
        CASE WHEN type = 'county' THEN 1
        	 WHEN type = 'region' THEN 2
        	 WHEN type = 'state' THEN 3
        	 WHEN type = 'city' THEN 4
        	 WHEN type = 'town' THEN 5
        	 WHEN type = 'suburb' THEN 6
        	 WHEN type = 'village' THEN 7
        	 WHEN type = 'hamlet' THEN 8
        	 WHEN type = 'locality' THEN 9
        	 ELSE 10
        END AS rank
    FROM osm_places
    ORDER BY rank, population DESC NULLS LAST, osm_id;


CREATE OR REPLACE VIEW brick_landusage_area_labels AS
    SELECT osm_id, name, class, type, area, st_centroid(geometry)::geometry(Point,3857) AS geometry
    FROM osm_landusage_area_labels
    ORDER BY area DESC, osm_id;


CREATE OR REPLACE VIEW brick_landusage_area_labels_gen0 AS
    SELECT osm_id, name, class, type, area, st_centroid(geometry)::geometry(Point,3857) AS geometry
    FROM osm_landusage_area_labels_gen0
    ORDER BY area DESC, osm_id;


CREATE OR REPLACE VIEW brick_landusage_area_labels_gen1 AS
    SELECT osm_id, name, class, type, area, st_centroid(geometry)::geometry(Point,3857) AS geometry
    FROM osm_landusage_area_labels_gen1
    ORDER BY area DESC, osm_id;


CREATE OR REPLACE VIEW brick_road_labels AS
    SELECT * FROM (
        SELECT  osm_id, class, type, regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
                CASE
                    WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                    ELSE (-1)
                END AS direction,
                CASE
                    WHEN type = 'motorway' THEN 0
                    WHEN type = 'trunk' THEN 2
                    WHEN type = 'primary' THEN 5
                    WHEN type = 'secondary' THEN 7
                    WHEN type = 'tertiary' THEN 9
                    WHEN type = ANY (ARRAY['residential', 'unclassified', 'road', 'minor']) THEN 11
                    WHEN class = 'railway' THEN 12
                    ELSE 99
                END AS rank,
	            tunnel,
	            geometry
        FROM osm_road_labels
        UNION ALL
        SELECT osm_id, 'ferry' AS class, 'ferry' AS type, name,
                CASE
                    WHEN sin(pi()/2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                    ELSE (-1)
                END AS direction,
                100 as rank,
	            0 AS tunnel,
                geometry
        FROM osm_landusage_ways
        WHERE type='ferry'
    ) AS foo
    ORDER BY rank DESC, osm_id;


CREATE OR REPLACE VIEW brick_road_labels_gen1 AS
    SELECT class, type, regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geometry), st_endpoint(geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction,
            CASE
                WHEN type = 'motorway' THEN 0
                WHEN type = 'trunk' THEN 2
                WHEN type = 'primary' THEN 5
                WHEN type = 'secondary' THEN 7
                WHEN type = 'tertiary' THEN 9
                WHEN type = ANY (ARRAY['residential', 'unclassified', 'road', 'minor']) THEN 11
                WHEN class = 'railway' THEN 12
                ELSE 99
            END AS rank,
	        tunnel,
            geometry
    FROM osm_road_labels_gen1
    ORDER BY rank DESC, osm_id;


CREATE OR REPLACE VIEW brick_road_labels_gen0 AS
    SELECT class, type, regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
           0 AS direction,
           CASE
               WHEN type = 'motorway' THEN 0
               WHEN type = 'trunk' THEN 2
               WHEN type = 'primary' THEN 5
               ELSE 99
           END AS rank,
    	   tunnel,
    	   geometry
    FROM osm_road_labels_gen0
    ORDER BY rank DESC, osm_id;


CREATE TABLE brick_shields AS
    SELECT  class, type,
            CASE
                WHEN ref ~ '^I ?\d+' THEN regexp_replace(ref, '^I ?(\d+).*', 'I \1')
                WHEN ref ~ '^US ?\d+' THEN regexp_replace(ref, '^US ?(\d+).*', 'US \1')
                WHEN ref ~ '^[[:alpha:]]+ ?\d+' THEN regexp_replace(ref, '^([[:alpha:]]+) ?(\d+).*', '\1 \2')
                WHEN ref ~ '^[[:alpha:]]+-\d+' THEN regexp_replace(ref, '^([[:alpha:]]+)-(\d+).*', '\1 \2')
                WHEN ref ~ '^\d+$' THEN ref
                ELSE ref
            END AS ref,
            length(ref) AS reflen,
            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(
                        ST_CollectionExtract(ST_Collect(ST_SimplifyPreserveTopology(geometry, 10)), 2)))))
                        .geom) AS geometry
    FROM osm_roads
    WHERE ref IS NOT NULL AND ref != '' AND (type = ANY (ARRAY['motorway', 'trunk', 'primary', 'secondary', 'tertiary']))
    GROUP BY class, type, ref
    ORDER BY
            CASE WHEN type='motorway' THEN 0
                 WHEN type='trunk' THEN 1
                 WHEN type='primary' THEN 2
                 WHEN type='secondary' THEN 3
                 WHEN type='tertiary' THEN 4
                 ELSE 99
            END ASC,
            reflen ASC;



CREATE table brick_shields_gen0 AS
    SELECT class, type, ref, length(ref) AS reflen,
    	   ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(
                        ST_CollectionExtract(ST_Collect(ST_SimplifyPreserveTopology(geometry, 10)), 2)))))
                        .geom) AS geometry
    
    FROM ( SELECT class, type,
                    CASE
                        WHEN ref ~ '^I ?\d+' THEN regexp_replace(ref, '^I ?(\d+).*', 'I \1')
                        WHEN ref ~ '^US ?\d+' THEN regexp_replace(ref, '^US ?(\d+).*', 'US \1')
                        WHEN ref ~ '^[[:alpha:]]+ ?\d+' THEN regexp_replace(ref, '^([[:alpha:]]+) ?(\d+).*', '\1 \2')
                        WHEN ref ~ '^[[:alpha:]]+-\d+' THEN regexp_replace(ref, '^([[:alpha:]]+)-(\d+).*', '\1 \2')
                        WHEN ref ~ '^\d+$' THEN ref
                        ELSE ref
                    END AS ref,
                    geometry
           FROM osm_roads_gen0
           WHERE ref IS NOT NULL AND ref != '' ) foo
    GROUP BY class, type, ref
    ORDER BY
        CASE WHEN type='motorway' THEN 0
             WHEN type='trunk' THEN 1
             WHEN type='primary' THEN 2
             WHEN type='secondary' THEN 3
             WHEN type='tertiary' THEN 4
             ELSE 99
        END ASC,
        reflen ASC;


COMMIT;
