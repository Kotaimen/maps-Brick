BEGIN;

DROP VIEW IF EXISTS brick_places;
DROP VIEW IF EXISTS brick_landusage_label;


CREATE OR REPLACE VIEW brick_places AS 
 SELECT planet_osm_point.way, 
        CASE
            WHEN planet_osm_point.place = 'city'::text THEN 0
            WHEN planet_osm_point.place = 'town'::text THEN 1
            WHEN planet_osm_point.place = 'village'::text THEN 2
            ELSE 3
        END AS type, 
        regexp_replace(planet_osm_point.name, '(.*)\(.*\)'::text, E'\\1') AS name, 
        
        CASE
            WHEN planet_osm_point.population ~ '^\d+$'::text THEN planet_osm_point.population::integer
            ELSE 0
        END AS population
   FROM planet_osm_point
  WHERE planet_osm_point.place = ANY (ARRAY['city'::text, 'town'::text, 'village'::text, 'hamlet'::text, 'suburb'::text, 'neighbourhood'::text, 'locality'::text])
  ORDER BY planet_osm_point.place, 
        CASE
            WHEN planet_osm_point.population ~ '^\d+$'::text THEN planet_osm_point.population::integer
            ELSE 0 
        END DESC NULLS LAST,
        planet_osm_point.osm_id DESC;


CREATE OR REPLACE VIEW brick_landusage_label AS
	SELECT 
		osm_id, 
		name, 
		way_area AS area, 
		COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) AS type, 
		ST_PointOnSurface(way) AS way
	FROM planet_osm_polygon WHERE COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) is not NULL AND name IS NOT NULL AND ST_ISVALID(way) ORDER BY way_area DESC;        
END;
