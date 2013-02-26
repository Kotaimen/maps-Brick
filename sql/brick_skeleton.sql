
BEGIN;

DROP TABLE IF EXISTS "brick_skeleton";

CREATE TABLE brick_skeleton AS 
	SELECT 
		( CASE 
			WHEN planet_osm_line.ref ~ E'^I ?\\d+' THEN regexp_replace(planet_osm_line.ref, E'^I ?(\\d+).*', E'\\1')
			WHEN planet_osm_line.ref ~ E'^US ?\\d+' THEN regexp_replace(planet_osm_line.ref, E'^US ?(\\d+).*', E'\\1')
			WHEN planet_osm_line.ref ~ E'^[[:alpha:]]+ ?\\d+' THEN regexp_replace(planet_osm_line.ref, E'^([[:alpha:]]+) ?(\\d+).*', E'\\1\\2')
			WHEN planet_osm_line.ref ~ E'^[[:alpha:]]+-\\d+' THEN regexp_replace(planet_osm_line.ref, E'^([[:alpha:]]+)-(\\d+).*', E'\\1\\2')
			WHEN planet_osm_line.ref ~ E'^\\d+$' THEN planet_osm_line.ref
			ELSE ''
		END ) AS ref,
		planet_osm_line.ref as org_ref,
		( CASE 
			WHEN planet_osm_line.ref ~ E'^I ?\\d+' THEN 'US/I'
			WHEN planet_osm_line.ref ~ E'^US ?\\d+' THEN 'US/US'
			WHEN ref != '' THEN 'INTL/ALL'
			ELSE ''
		END) AS category, 
		length(ref) AS strlen,
		ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(
			ST_CollectionExtract(ST_Collect(ST_SimplifyPreserveTopology(planet_osm_line.way, 10)), 2)))))
			.geom) AS way
	FROM planet_osm_line
		WHERE planet_osm_line.ref IS NOT NULL
		and planet_osm_line.highway IN ('motorway', 'trunk', 'primary', 'secondary' )
	GROUP BY planet_osm_line.ref
;

CREATE INDEX ON brick_skeleton USING gist(way);
CREATE INDEX ON brick_skeleton(ref);
CREATE INDEX ON brick_skeleton(category);

END;

