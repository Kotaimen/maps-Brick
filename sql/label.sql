BEGIN;

SET search_path TO import, public;

CREATE INDEX ON osm_places(type);
CREATE INDEX ON osm_places(population);

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

COMMIT;
