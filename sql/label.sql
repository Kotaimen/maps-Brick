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



CREATE OR REPLACE VIEW import.brick_landusage_area_labels AS 
    SELECT brick_landusage_areas.id, 
    	   brick_landusage_areas.osm_id, 
	   brick_landusage_areas.name, 
	   brick_landusage_areas.class, 
	   brick_landusage_areas.type, 
	   brick_landusage_areas.area, 
	   st_pointonsurface(brick_landusage_areas.geometry) AS geometry
    FROM import.brick_landusage_areas
    WHERE brick_landusage_areas.name IS NOT NULL AND brick_landusage_areas.name::text <> ''::text
    ORDER BY brick_landusage_areas.area DESC;


COMMIT;
