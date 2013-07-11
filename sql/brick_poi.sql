BEGIN;
CREATE INDEX ON planet_osm_point("landuse");
CREATE INDEX ON planet_osm_point("leisure");
CREATE INDEX ON planet_osm_point("natural");
CREATE INDEX ON planet_osm_point("highway");
CREATE INDEX ON planet_osm_point("amenity");
CREATE INDEX ON planet_osm_point("tourism");
CREATE INDEX ON planet_osm_point("historic");
CREATE INDEX ON planet_osm_point("military");
CREATE INDEX ON planet_osm_point("shop");
CREATE INDEX ON planet_osm_point("sport");


CREATE OR REPLACE VIEW brick_poi AS 
SELECT * FROM (
    SELECT 'landuse'::text AS poi_class, planet_osm_point.landuse AS poi_type, * 
    FROM planet_osm_point
    WHERE planet_osm_point.landuse IS NOT NULL

    UNION ALL 

    SELECT 'leisure'::text AS poi_class, planet_osm_point.leisure AS poi_type, * 
    FROM planet_osm_point
    WHERE planet_osm_point.leisure IS NOT NULL

    UNION ALL 
    
    SELECT 'natural'::text AS poi_class, planet_osm_point."natural" AS poi_type, *
    FROM planet_osm_point
    WHERE planet_osm_point."natural" IS NOT NULL
                                                        
    UNION ALL 
                                                                 
    SELECT 'highway'::text AS poi_class, planet_osm_point.highway AS poi_type, *
    FROM planet_osm_point
    WHERE planet_osm_point.highway IS NOT NULL
                                                
    UNION ALL 
                                                         
    SELECT 'amenity'::text AS poi_class, planet_osm_point.amenity AS poi_type, *
    FROM planet_osm_point
    WHERE planet_osm_point.amenity IS NOT NULL
                                        
    UNION ALL 
                                                 
    SELECT 'tourism'::text AS poi_class, planet_osm_point.tourism AS poi_type, *
    FROM planet_osm_point
    WHERE planet_osm_point.tourism IS NOT NULL
                                
    UNION ALL 
                                         
    SELECT 'historic'::text AS poi_class, planet_osm_point.historic AS poi_type, *
    FROM planet_osm_point
    WHERE planet_osm_point.shop IS NOT NULL

    UNION ALL 

    SELECT 'military'::text AS poi_class, planet_osm_point.military AS poi_type, *
    FROM planet_osm_point
    WHERE planet_osm_point.military IS NOT NULL

    UNION ALL

    SELECT 'shop'::text AS poi_class, planet_osm_point.shop AS poi_type, *
    FROM planet_osm_point
    WHERE planet_osm_point.shop IS NOT NULL

    UNION ALL
    
    SELECT 'sport'::text AS poi_class, planet_osm_point.sport AS poi_type, *
    FROM planet_osm_point
    WHERE planet_osm_point.sport IS NOT NULL) foo2
    
ORDER BY 
    CASE
        WHEN foo2.poi_class = 'natural'::text THEN 0
        WHEN foo2.poi_class = 'historic'::text THEN 1
        WHEN foo2.poi_class = 'tourism'::text THEN 2
        WHEN foo2.poi_class = 'military'::text THEN 3
        WHEN foo2.poi_class = 'landuse'::text THEN 4
        WHEN foo2.poi_class = 'sport'::text THEN 5
        WHEN foo2.poi_class = 'amenity'::text THEN 6
        WHEN foo2.poi_class = 'leisure'::text THEN 7
        WHEN foo2.poi_class = 'shop'::text THEN 8
        WHEN foo2.poi_class = 'highway'::text THEN 9
        ELSE NULL::integer
    END;

ALTER TABLE brick_poi
  OWNER TO postgres;

END;