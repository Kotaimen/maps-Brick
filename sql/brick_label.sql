BEGIN;

CREATE OR REPLACE VIEW brick_places AS 
 SELECT 'place'::text AS place_class, place AS place_type, regexp_replace(name, '(.*)\(.*\)'::text, '\1'::text) AS place_name, 
        CASE
            WHEN population ~ '^\d+$'::text THEN population::integer
            ELSE 0
        END AS place_population, 
        CASE
            WHEN place = 'city'::text THEN 0
            WHEN place = 'town'::text THEN 1
            WHEN place = 'village'::text THEN 2
            ELSE 3
        END AS place_priority,	
        *
   FROM planet_osm_point
  WHERE place = ANY (ARRAY['city'::text, 'town'::text, 'village'::text, 'hamlet'::text, 'suburb'::text, 'neighbourhood'::text, 'locality'::text])
  ORDER BY 
        place_priority, 
        place_population DESC NULLS LAST,
        planet_osm_point.osm_id DESC;
		
		
CREATE OR REPLACE VIEW brick_road_label AS 
	SELECT *
	FROM brick_road
	WHERE road_name IS NOT NULL AND road_class IS NOT NULL
	ORDER BY brick_road.priority, st_length(brick_road.way) DESC NULLS LAST;
	

CREATE OR REPLACE VIEW brick_road_label_overview AS 
	SELECT *
	FROM brick_road_label
	WHERE brick_road_label.priority <= 2;


-- do not filter landusage with no name
CREATE OR REPLACE VIEW brick_landusage_area_label AS 
SELECT 	landusage_class, 
	landusage_type,
	name AS landusage_name,
	ST_AREA(ST_COLLECT(way)) AS way_area,
	ST_PointOnSurface(ST_COLLECT(way)) AS way
FROM brick_landusage_area
WHERE (name IS NOT NULL OR amenity = 'parking') AND ST_ISVALID(way)
GROUP BY landusage_class, landusage_type, name
ORDER BY st_area(st_collect(way)) DESC;


CREATE TABLE brick_shield_table AS 
	SELECT 
		( CASE 
			WHEN ref ~ E'^I ?\\d+' THEN regexp_replace(ref, E'^I ?(\\d+).*', E'\\1')
			WHEN ref ~ E'^US ?\\d+' THEN regexp_replace(ref, E'^US ?(\\d+).*', E'\\1')
			WHEN ref ~ E'^[[:alpha:]]+ ?\\d+' THEN regexp_replace(ref, E'^([[:alpha:]]+) ?(\\d+).*', E'\\1\\2')
			WHEN ref ~ E'^[[:alpha:]]+-\\d+' THEN regexp_replace(ref, E'^([[:alpha:]]+)-(\\d+).*', E'\\1\\2')
			WHEN ref ~ E'^\\d+$' THEN ref
			ELSE ''
		END ) AS ref,
		ref as org_ref,
		( CASE 
			WHEN ref ~ E'^I ?\\d+' THEN 'US/I'
			WHEN ref ~ E'^US ?\\d+' THEN 'US/US'
			WHEN ref != '' THEN 'INTL/ALL'
			ELSE ''
		END) AS shield_class, 
		length(ref) AS strlen,
		ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(
			ST_CollectionExtract(ST_Collect(ST_SimplifyPreserveTopology(way, 10)), 2)))))
			.geom) AS way
	FROM brick_road
	WHERE ref IS NOT NULL AND road_type IN ('motorway', 'trunk', 'primary', 'secondary' )
	GROUP BY ref;


CREATE INDEX ON brick_shield_table USING gist(way);
CREATE INDEX ON brick_shield_table(ref);
CREATE INDEX ON brick_shield_table(shield_class);


CREATE TABLE brick_landusage_area_label_table AS SELECT * FROM brick_landusage_area_label;

SELECT POPULATE_GEOMETRY_COLUMNS('brick_landusage_area_label_table'::regclass);

CREATE INDEX ON brick_landusage_area_label_table USING gist(way);
CREATE INDEX ON brick_landusage_area_label_table(way_area);

END;
