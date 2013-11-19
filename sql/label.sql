BEGIN;

SET search_path TO import, public;

CREATE INDEX ON osm_places(type);
CREATE INDEX ON osm_places(population);

CREATE INDEX ON osm_landusage_areas(name);
CREATE INDEX ON osm_landusage_areas(area);

CREATE INDEX ON osm_landusage_areas USING gist(st_centroid(geometry)) 
WHERE area > 1024 AND area <= 10240000  AND name IS NOT NULL AND name <> '' AND st_isvalid(geometry);

CREATE INDEX ON osm_landusages_gen0 USING gist(st_pointonsurface(geometry)) 
WHERE area > 1024000000 AND name IS NOT NULL AND name <> '' AND st_isvalid(geometry);

CREATE INDEX ON osm_landusages_gen1 USING gist(st_pointonsurface(geometry)) 
WHERE area > 10240000 AND name IS NOT NULL AND name <> '' AND st_isvalid(geometry);


CREATE INDEX ON osm_roads(name);
CREATE INDEX ON osm_roads_gen1(name);


CREATE OR REPLACE VIEW import.brick_places AS
    SELECT *,
        CASE
        	WHEN type = 'county' THEN 1
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
    ORDER BY rank, population DESC NULLS LAST;

CREATE OR REPLACE VIEW import.brick_landusage_area_labels AS 
    SELECT osm_id, name, class, type, area, 
        st_centroid(geometry)::geometry(Point,3857) AS geometry
    FROM import.osm_landusage_areas
    WHERE area > 1024::double precision AND area <= 10240000 AND name IS NOT NULL AND name::text <> ''::text AND st_isvalid(geometry)
    ORDER BY area DESC;


CREATE OR REPLACE VIEW import.brick_landusage_area_labels_gen0 AS 
    SELECT osm_id, name, class, type, area, 
	st_pointonsurface(geometry)::geometry(Point,3857) AS geometry
    FROM import.osm_landusages_gen0
    WHERE area > 1024000000::double precision AND name IS NOT NULL AND name::text <> ''::text AND st_isvalid(geometry)
    ORDER BY area DESC;


CREATE OR REPLACE VIEW import.brick_landusage_area_labels_gen1 AS 
    SELECT osm_id, name, class, type, area, 
	st_pointonsurface(geometry)::geometry(Point,3857) AS geometry
    FROM import.osm_landusages_gen1
    WHERE area > 10240000::double precision AND name IS NOT NULL AND name::text <> ''::text AND st_isvalid(geometry)
    ORDER BY area DESC;

CREATE OR REPLACE VIEW import.brick_road_labels AS 
    SELECT * FROM (
        SELECT osm_roads.class, osm_roads.type, regexp_replace(osm_roads.name::text, '(.*)\(.*\)'::text, '\1'::text) AS name, 
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(osm_roads.geometry), st_endpoint(osm_roads.geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction, osm_roads.geometry,
            CASE
                WHEN osm_roads.type::text = 'motorway'::text THEN 0::smallint
                WHEN osm_roads.type::text = 'trunk'::text THEN 2::smallint
                WHEN osm_roads.type::text = 'primary'::text THEN 5::smallint
                WHEN osm_roads.type::text = 'secondary'::text THEN 7::smallint
                WHEN osm_roads.type::text = 'tertiary'::text THEN 9::smallint
                WHEN osm_roads.type::text = ANY (ARRAY['residential'::character varying::text, 'unclassified'::character varying::text, 'road'::character varying::text, 'minor'::character varying::text]) THEN 11::smallint
                WHEN osm_roads.class::text = 'railway'::text THEN 12::smallint
            
                ELSE 99::smallint
            END AS rank,
	    tunnel
        FROM import.osm_roads
        WHERE osm_roads.name IS NOT NULL AND osm_roads.name::text <> ''::text
        UNION ALL
        SELECT 'ferry' AS class, 'ferry' AS type, osm_landusage_ways.name, 
            CASE
                WHEN sin(pi()/2 - st_azimuth(st_startpoint(osm_landusage_ways.geometry), st_endpoint(osm_landusage_ways.geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction,
            osm_landusage_ways.geometry,
            100::smallint as rank,
	    0 AS tunnel 
        FROM osm_landusage_ways
        WHERE type='ferry'
     ) AS foo
      ORDER BY 
           rank DESC;

CREATE OR REPLACE VIEW import.brick_road_labels_gen1 AS 
    SELECT osm_roads_gen1.class, osm_roads_gen1.type, regexp_replace(osm_roads_gen1.name::text, '(.*)\(.*\)'::text, '\1'::text) AS name, 
            CASE
                WHEN sin(pi() / 2 - st_azimuth(st_startpoint(osm_roads_gen1.geometry), st_endpoint(osm_roads_gen1.geometry))) > 0 THEN 1
                ELSE (-1)
            END AS direction, osm_roads_gen1.geometry,
            CASE
                WHEN osm_roads_gen1.type::text = 'motorway'::text THEN 0::smallint
                WHEN osm_roads_gen1.type::text = 'trunk'::text THEN 2::smallint
                WHEN osm_roads_gen1.type::text = 'primary'::text THEN 5::smallint
                WHEN osm_roads_gen1.type::text = 'secondary'::text THEN 7::smallint
                WHEN osm_roads_gen1.type::text = 'tertiary'::text THEN 9::smallint
                WHEN osm_roads_gen1.type::text = ANY (ARRAY['residential'::character varying::text, 'unclassified'::character varying::text, 'road'::character varying::text, 'minor'::character varying::text]) THEN 11::smallint
                WHEN osm_roads_gen1.class::text = 'railway'::text THEN 12::smallint                
                ELSE 99::smallint
            END AS rank,
	    tunnel
       FROM import.osm_roads_gen1
      WHERE osm_roads_gen1.name IS NOT NULL AND osm_roads_gen1.name::text <> ''::text
      ORDER BY 
           rank DESC;


CREATE OR REPLACE VIEW import.brick_road_labels_gen0 AS 
   SELECT osm_roads_gen0.class, osm_roads_gen0.type, regexp_replace(osm_roads_gen0.name::text, '(.*)\(.*\)'::text, '\1'::text) AS name,        
           0 AS direction, osm_roads_gen0.geometry,
           CASE
               WHEN osm_roads_gen0.type::text = 'motorway'::text THEN 0::smallint
               WHEN osm_roads_gen0.type::text = 'trunk'::text THEN 2::smallint
               WHEN osm_roads_gen0.type::text = 'primary'::text THEN 5::smallint
               ELSE 99::smallint
           END AS rank,
	   tunnel
      FROM import.osm_roads_gen0
     WHERE osm_roads_gen0.name IS NOT NULL AND osm_roads_gen0.name::text <> ''::text AND osm_roads_gen0.type::text IN ('motorway', 'trunk', 'primary')
     ORDER BY 
          rank DESC;       


CREATE OR REPLACE VIEW import.brick_shields AS 
 SELECT osm_roads.class, osm_roads.type, 
        CASE
            WHEN osm_roads.ref::text ~ '^I ?\d+'::text THEN regexp_replace(osm_roads.ref::text, '^I ?(\d+).*'::text, 'I \1'::text)
            WHEN osm_roads.ref::text ~ '^US ?\d+'::text THEN regexp_replace(osm_roads.ref::text, '^US ?(\d+).*'::text, 'US \1'::text)
            WHEN osm_roads.ref::text ~ '^[[:alpha:]]+ ?\d+'::text THEN regexp_replace(osm_roads.ref::text, '^([[:alpha:]]+) ?(\d+).*'::text, '\1 \2'::text)
            WHEN osm_roads.ref::text ~ '^[[:alpha:]]+-\d+'::text THEN regexp_replace(osm_roads.ref::text, '^([[:alpha:]]+)-(\d+).*'::text, '\1 \2'::text)
            WHEN osm_roads.ref::text ~ '^\d+$'::text THEN osm_roads.ref::text
            ELSE osm_roads.ref::text
        END AS ref, length(osm_roads.ref::text) AS reflen, osm_roads.geometry
   FROM import.osm_roads
  WHERE osm_roads.ref IS NOT NULL AND osm_roads.ref::text <> ''::text AND (osm_roads.type::text = ANY (ARRAY['motorway'::character varying::text, 'trunk'::character varying::text, 'primary'::character varying::text, 'secondary'::character varying::text, 'tertiary'::character varying::text]))
  ORDER BY 
  	CASE WHEN type='motorway' THEN 0
	     WHEN type='trunk' THEN 1
	     WHEN type='primary' THEN 2
	     WHEN type='secondary' THEN 3
	     WHEN type='tertiary' THEN 4
	     ELSE 99
	END ASC;


	
CREATE OR REPLACE VIEW import.brick_shields_gen0 AS 
 SELECT foo.class, foo.type, foo.ref, length(foo.ref) AS reflen, foo.geometry
   FROM ( SELECT osm_roads_gen1.class, osm_roads_gen1.type, 
                CASE
                    WHEN osm_roads_gen1.ref::text ~ '^I ?\d+'::text THEN regexp_replace(osm_roads_gen1.ref::text, '^I ?(\d+).*'::text, 'I \1'::text)
                    WHEN osm_roads_gen1.ref::text ~ '^US ?\d+'::text THEN regexp_replace(osm_roads_gen1.ref::text, '^US ?(\d+).*'::text, 'US \1'::text)
                    WHEN osm_roads_gen1.ref::text ~ '^[[:alpha:]]+ ?\d+'::text THEN regexp_replace(osm_roads_gen1.ref::text, '^([[:alpha:]]+) ?(\d+).*'::text, '\1 \2'::text)
                    WHEN osm_roads_gen1.ref::text ~ '^[[:alpha:]]+-\d+'::text THEN regexp_replace(osm_roads_gen1.ref::text, '^([[:alpha:]]+)-(\d+).*'::text, '\1 \2'::text)
                    WHEN osm_roads_gen1.ref::text ~ '^\d+$'::text THEN osm_roads_gen1.ref::text
                    ELSE osm_roads_gen1.ref::text
                END AS ref, osm_roads_gen1.geometry
           FROM import.osm_roads_gen1
          WHERE osm_roads_gen1.ref IS NOT NULL AND osm_roads_gen1.ref::text <> ''::text AND (osm_roads_gen1.type::text = ANY (ARRAY['motorway'::character varying::text, 'trunk'::character varying::text, 'primary'::character varying::text, 'secondary'::character varying::text, 'tertiary'::character varying::text]))) foo
 ORDER BY
        CASE WHEN type='motorway' THEN 0
             WHEN type='trunk' THEN 1
             WHEN type='primary' THEN 2
             WHEN type='secondary' THEN 3
             WHEN type='tertiary' THEN 4
             ELSE 99
	END ASC;



COMMIT;
