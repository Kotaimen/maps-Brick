
BEGIN;

DROP TABLE IF EXISTS "brick_skeleton";


CREATE TABLE brick_skeleton AS 
	SELECT 
		osm_id,
		( CASE 
			WHEN ref ~ E'^I ?[[:digit:]]+' THEN regexp_replace(ref, '^I ?([[:digit:]]+).*', E'\\1')
			WHEN ref ~ E'^US ?[[:digit:]]+' THEN regexp_replace(ref, '^US ?([[:digit:]]+).*', E'\\1')
			WHEN ref ~ E'^[[:alpha:]]+ ?[[:alnum:]]+' THEN regexp_replace(ref, '^([[:alpha:]]+) ?([[:alnum:]]+).*', E'\\1\\2')
			ELSE NULL
		END ) AS ref,
		( CASE 
			WHEN ref ~ E'^I ?[[:digit:]]+' THEN 'US/I'
			WHEN ref ~ E'^US ?[[:digit:]]+' THEN 'US/US'
			WHEN CHAR_LENGTH(ref) <=5 THEN 'US/STATE'
			ELSE NULL
		END) AS category,
		st_simplifypreservetopology(way, 50) AS way
	FROM planet_osm_line
		WHERE highway IN ('motorway', 'trunk')
	ORDER BY z_order
;

CREATE INDEX ON brick_skeleton USING gist(way);

END;

