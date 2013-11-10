BEGIN;

SET search_path TO import, public;

CREATE INDEX ON osm_roads_gen0(type)
CREATE INDEX ON osm_roads_gen0(class)
CREATE INDEX ON osm_roads_gen1(type)
CREATE INDEX ON osm_roads_gen1(class)


CREATE OR REPLACE VIEW brick_roads_gen0 AS 
    SELECT *, 
        CASE
            WHEN type IN ('motorway', 'trunk') THEN 200
            WHEN type IN ('primary', 'secondary') THEN 199
            WHEN class='railway' THEN 10  
            ELSE 0 
            END AS zorder        
        FROM osm_roads_gen0         
        WHERE type IN ('motorway', 'trunk', 'primary') 
        ORDER BY zorder ;

CREATE OR REPLACE VIEW brick_roads_gen1 AS 
    SELECT *, 
        CASE
            WHEN type IN ('motorway', 'trunk', 'motoway_link', 'trunk_link') THEN 200
            WHEN type='primary' THEN 199
            WHEN type='seconary' THEN 198
            WHEN class='railway' THEN 10  
            ELSE 0 
            END AS zorder        
        FROM osm_roads_gen1      
        WHERE type IN ('motorway', 'trunk', 'motoway_link', 'trunk_link', 'primary', 'secondary', 'rail') 
        ORDER BY zorder;



COMMIT;
