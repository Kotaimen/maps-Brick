BEGIN;

-- SET search_path TO import, public;


-- full set of roads
CREATE OR REPLACE VIEW brick_roads_stage AS 
    SELECT  osm_id, class, tunnel, bridge, oneway, access, service,
            CASE    -- roads category
                    WHEN type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
                    WHEN type IN ('primary', 'primary_link') THEN 'primary'
                    WHEN type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
                    WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
                    WHEN type IN ('path', 'track', 'footway', 'bridleway', 'cycleway', 'pedestrian', 'living_street', 'service') THEN 'path'
                    WHEN type IN ('construction', 'proposed') THEN 'proposed'
                    
                    -- railway category
                    WHEN type IN ('rail') THEN 'rail'
                    WHEN type IN ('subway', 'light_rail') THEN 'subway'
                    WHEN type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
                    ELSE 'path'
            END AS type,
            CASE    
                    -- link flag
                    WHEN type ~~ '%_link' THEN 1
                    ELSE 0
            END AS link,
            CASE    
                    -- osm layer, explicit hierarchy
                    WHEN layer IS NULL THEN 0
            	    ELSE layer
            END AS layer, 
            CASE    
                    -- rank of roads, implicit hierarchy
                    -- motorway
                    WHEN type = 'motorway' THEN 0
	    	        WHEN type = 'motorway_link' THEN 1
                	WHEN type = 'trunk' THEN 20
                	WHEN type = 'trunk_link' THEN 21
                	
                	-- all railways 
                	WHEN class = 'railway' THEN 30
                	
                	-- primary roads
                	WHEN type = 'primary' THEN 40
                	WHEN type = 'primary_link' THEN 41 
                	
                	-- secondary roads
                	WHEN type = 'secondary' THEN 50
                	WHEN type = 'secondary_link' THEN 51
                	
                	WHEN type = 'tertiary' THEN 60
                	WHEN type = 'tertiary_link' THEN 61
                
                   	-- minor roads
                	WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
                	
                	-- path
                	ELSE 255
            END AS rank,
            geometry
    FROM osm_roads;


-- osm_roads_gen1 contains a small set of roads in osm_roads, select logic is same as above
CREATE OR REPLACE VIEW brick_roads_stage_gen1 AS 
    SELECT  osm_id, class, tunnel, bridge, oneway, access, service,
            CASE    -- roads category
                    WHEN type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
                    WHEN type IN ('primary', 'primary_link') THEN 'primary'
                    WHEN type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
                    WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
                    WHEN type IN ('path', 'track', 'footway', 'bridleway', 'cycleway', 'pedestrian', 'living_street', 'service') THEN 'path'
                    WHEN type IN ('construction', 'proposed') THEN 'proposed'
                    
                    -- railway category
                    WHEN type IN ('rail') THEN 'rail'
                    WHEN type IN ('subway', 'light_rail') THEN 'subway'
                    WHEN type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
                    ELSE 'path'
            END AS type,
            CASE    
                    -- link flag
                    WHEN type ~~ '%_link' THEN 1
                    ELSE 0
            END AS link,
            CASE    
                    -- osm layer, explicit hierarchy
                    WHEN layer IS NULL THEN 0
            	    ELSE layer
            END AS layer, 
            CASE    
                    -- rank of roads, implicit hierarchy
                    -- motorway
                    WHEN type = 'motorway' THEN 0
	    	        WHEN type = 'motorway_link' THEN 1
                	WHEN type = 'trunk' THEN 20
                	WHEN type = 'trunk_link' THEN 21
                	
                	-- all railways 
                	WHEN class = 'railway' THEN 30
                	
                	-- primary roads
                	WHEN type = 'primary' THEN 40
                	WHEN type = 'primary_link' THEN 41 
                	
                	-- secondary roads
                	WHEN type = 'secondary' THEN 50
                	WHEN type = 'secondary_link' THEN 51
                	
                	WHEN type = 'tertiary' THEN 60
                	WHEN type = 'tertiary_link' THEN 61
                
                   	-- minor roads
                	WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
                	
                	-- path
                	ELSE 255
            END AS rank,
            geometry
    FROM osm_roads_gen1;


-- osm_roads_gen0 contains a small set of roads in osm_roads_gen0, select logic is same as above
CREATE OR REPLACE VIEW brick_roads_stage_gen0 AS 
    SELECT  osm_id, class, tunnel, bridge, oneway, access, service,
            CASE    -- roads category
                    WHEN type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN 'motorway'
                    WHEN type IN ('primary', 'primary_link') THEN 'primary'
                    WHEN type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN 'secondary'
                    WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 'minor'
                    WHEN type IN ('path', 'track', 'footway', 'bridleway', 'cycleway', 'pedestrian', 'living_street', 'service') THEN 'path'
                    WHEN type IN ('construction', 'proposed') THEN 'proposed'
                    
                    -- railway category
                    WHEN type IN ('rail') THEN 'rail'
                    WHEN type IN ('subway', 'light_rail') THEN 'subway'
                    WHEN type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN 'monorail'
                    ELSE 'path'
            END AS type,
            CASE    
                    -- link flag
                    WHEN type ~~ '%_link' THEN 1
                    ELSE 0
            END AS link,
            CASE    
                    -- osm layer, explicit hierarchy
                    WHEN layer IS NULL THEN 0
            	    ELSE layer
            END AS layer, 
            CASE    
                    -- rank of roads, implicit hierarchy
                    -- motorway
                    WHEN type = 'motorway' THEN 0
	    	        WHEN type = 'motorway_link' THEN 1
                	WHEN type = 'trunk' THEN 20
                	WHEN type = 'trunk_link' THEN 21
                	
                	-- all railways 
                	WHEN class = 'railway' THEN 30
                	
                	-- primary roads
                	WHEN type = 'primary' THEN 40
                	WHEN type = 'primary_link' THEN 41 
                	
                	-- secondary roads
                	WHEN type = 'secondary' THEN 50
                	WHEN type = 'secondary_link' THEN 51
                	
                	WHEN type = 'tertiary' THEN 60
                	WHEN type = 'tertiary_link' THEN 61
                
                   	-- minor roads
                	WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN 70
                	
                	-- path
                	ELSE 255
            END AS rank,
            geometry
    FROM osm_roads_gen0;


-- All Roads with hierarchy effect
CREATE OR REPLACE VIEW brick_roads AS 
    SELECT * FROM (
	    SELECT 'outline' AS render, 1 AS outline, 0 AS render_order, * FROM brick_roads_stage
        UNION ALL 
        SELECT 'casing' AS render, 0 AS outline, 1 AS render_order, * FROM brick_roads_stage
        UNION ALL 
        SELECT 'inline' AS render, 0 AS outline, 2 AS render_order, * FROM brick_roads_stage
        UNION ALL 
        SELECT 'marker' AS render, 0 AS outline, 3 AS render_order, * FROM brick_roads_stage
    ) foo
    ORDER BY
    -- 1. Draw all the outline first.
    foo.outline DESC, 
    
    -- 2. explicit hierarchy
    foo.layer ASC, 
    
    -- 3. implicit hierarchy by road properties
    foo.tunnel DESC NULLS LAST, 
    foo.bridge NULLS FIRST, 
    foo.render_order ASC, 
    
    -- 4. implicit hierarchy by road type
    foo.rank DESC;


-- It is not necessary to draw outline and marker in mid-level
CREATE OR REPLACE VIEW brick_roads_gen1 AS 
    SELECT *
    FROM (         
    	SELECT 'casing' AS render, 1 AS outline, 0 AS render_order, * FROM brick_roads_stage_gen1
        UNION ALL 
        SELECT 'inline' AS render, 0 AS outline, 1 AS render_order, * FROM brick_roads_stage_gen1
    ) foo
    ORDER BY 
    foo.outline DESC, 
    foo.layer ASC, 
    foo.tunnel DESC NULLS LAST, 
    foo.bridge NULLS FIRST, 
    foo.render_order ASC, 
    foo.rank DESC;


-- Road Overview
CREATE OR REPLACE VIEW brick_roads_gen0 AS 
    SELECT *
    FROM brick_roads_stage_gen0
    ORDER BY 
    rank DESC;


COMMIT;
