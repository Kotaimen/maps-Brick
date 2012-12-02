BEGIN;
CREATE OR REPLACE VIEW brick_places AS 
 SELECT planet_osm_point.way, 
        CASE
            WHEN planet_osm_point.place = 'city'::text THEN 0
            WHEN planet_osm_point.place = 'town'::text THEN 1
            WHEN planet_osm_point.place = 'village'::text THEN 2
            ELSE 3
        END AS type, planet_osm_point.name, 
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
        END DESC NULLS LAST;
END;
