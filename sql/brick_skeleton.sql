
BEGIN;

DROP TABLE IF EXISTS "brick_skeleton";


CREATE TABLE brick_skeleton AS 
	SELECT 
		( CASE 
			WHEN ref ~ E'^I ?[[:digit:]]+' THEN regexp_replace(ref, '^I ?([[:digit:]]+).*', E'\\1')
			WHEN ref ~ E'^US ?[[:digit:]]+' THEN regexp_replace(ref, '^US ?([[:digit:]]+).*', E'\\1')
			WHEN ref ~ E'^[[:alpha:]]+ ?[[:alpha:]]?[[:digit:]]+' THEN regexp_replace(ref, '^([[:alpha:]]+) ?([[:alnum:]]+).*', E'\\1\\2')
			ELSE NULL
		END ) AS ref,
		( CASE 
			WHEN ref ~ E'^I ?[[:digit:]]+' THEN 'US/I'
			WHEN ref ~ E'^US ?[[:digit:]]+' THEN 'US/US'
			WHEN CHAR_LENGTH(ref) <=5 THEN 'US/STATE'
			ELSE NULL
		END) AS category, 
		--st_simplify(way, 6) as way
		ST_Segmentize(ST_SimplifyPreserveTopology(ST_LineMerge(st_collect(way)), 6), 5000) AS way
	FROM planet_osm_line
		WHERE highway IN ('motorway', 'trunk')
	GROUP BY ref
	--ORDER BY z_order
;

CREATE INDEX ON brick_skeleton USING gist(way);

END;

