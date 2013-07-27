BEGIN;



CREATE OR REPLACE VIEW brick_road AS 
 SELECT planet_osm_line.osm_id, 
        CASE
            WHEN planet_osm_line.highway = ANY (ARRAY['motorway'::text, 'motorway_link'::text]) THEN 'highway'::text
            WHEN planet_osm_line.highway = ANY (ARRAY['trunk'::text, 'trunk_link'::text]) THEN 'trunk'::text
            WHEN planet_osm_line.highway = ANY (ARRAY['primary'::text, 'primary_link'::text, 'secondary'::text, 'secondary_link'::text, 'tertiary'::text, 'tertiary_link'::text]) THEN 'major_road'::text
            WHEN planet_osm_line.highway = ANY (ARRAY['residential'::text, 'unclassified'::text, 'road'::text, 'minor'::text]) THEN 'minor_road'::text
            WHEN planet_osm_line.highway = ANY (ARRAY['service'::text, 'footpath'::text, 'track'::text, 'footway'::text, 'steps'::text, 'pedestrian'::text, 'path'::text, 'cycleway'::text, 'living_street'::text]) THEN 'path'::text
            WHEN planet_osm_line.railway IS NOT NULL THEN 'rail'::text
            ELSE NULL::text
        END AS road_class,
        COALESCE(planet_osm_line.highway, planet_osm_line.railway) AS road_type,
        regexp_replace(planet_osm_line.name, '(.*)\(.*\)'::text, '\1'::text) AS road_name, 
        CASE
            WHEN planet_osm_line.name ~* '\mavenue$'::text THEN regexp_replace(planet_osm_line.name, '\m(ave)nue$'::text, '\1'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mboulevard$'::text THEN regexp_replace(planet_osm_line.name, '\m(b)oulevard$'::text, '\1lvd'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mexpressway$'::text THEN regexp_replace(planet_osm_line.name, '\m(E)xpressway$'::text, '\1xpwy'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mhighway$'::text THEN regexp_replace(planet_osm_line.name, '\m(h)ighway$'::text, '\1wy'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mparkway$'::text THEN regexp_replace(planet_osm_line.name, '\m(p)arkway$'::text, '\1kwy'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mcourt$'::text THEN regexp_replace(planet_osm_line.name, '\m(c)ourt$'::text, '\1t'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mdrive$'::text THEN regexp_replace(planet_osm_line.name, '\m(dr)ive$'::text, '\1'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mplace$'::text THEN regexp_replace(planet_osm_line.name, '\m(pl)ace$'::text, '\1'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mlane$'::text THEN regexp_replace(planet_osm_line.name, '\m(l)ane$'::text, '\1n'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mroad$'::text THEN regexp_replace(planet_osm_line.name, '\m(r)oad$'::text, '\1d'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mstreet$'::text THEN regexp_replace(planet_osm_line.name, '\m(st)reet$'::text, '\1'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mtrail$'::text THEN regexp_replace(planet_osm_line.name, '\m(tr)ail$'::text, '\1'::text, 'i'::text)
            WHEN planet_osm_line.name ~* '\mway$'::text THEN regexp_replace(planet_osm_line.name, '\m(w)ay$'::text, '\1y'::text, 'i'::text)
            ELSE planet_osm_line.name
        END AS road_name_abbr, 
	ref,
        CASE
            WHEN planet_osm_line.oneway = ANY (ARRAY['yes'::text, 'true'::text]) THEN 1
            WHEN planet_osm_line.oneway = ANY (ARRAY['no'::text, 'false'::text]) THEN 0
            WHEN planet_osm_line.oneway = '-1'::text THEN (-1)
            ELSE 0
        END AS is_oneway, 
        CASE
            WHEN planet_osm_line.highway ~~ '%_link'::text THEN 1
            ELSE 0
        END AS is_link, 
        CASE
            WHEN planet_osm_line.tunnel = ANY (ARRAY['yes'::text, 'true'::text]) THEN 1
            ELSE 0
        END AS is_tunnel, 
        CASE
            WHEN planet_osm_line.bridge = ANY (ARRAY['yes'::text, 'true'::text]) THEN 1
            ELSE 0
        END AS is_bridge, 
        CASE
            WHEN planet_osm_line.layer ~ '^-?[[:digit:]]+(\.[[:digit:]]+)?$'::text THEN planet_osm_line.layer::double precision
            ELSE 0::double precision
        END AS explicit_layer, 
        CASE
            WHEN planet_osm_line.tunnel = ANY (ARRAY['yes'::text, 'true'::text]) THEN (-1)
            WHEN planet_osm_line.bridge = ANY (ARRAY['yes'::text, 'true'::text]) THEN 1
            ELSE 0
        END AS implied_layer, 
        CASE
            WHEN planet_osm_line.highway = 'motorway'::text THEN 0::numeric
            WHEN planet_osm_line.railway IS NOT NULL THEN 0.5
            WHEN planet_osm_line.highway = 'trunk'::text THEN 1::numeric
            WHEN planet_osm_line.highway = 'primary'::text THEN 2::numeric
            WHEN planet_osm_line.highway = 'secondary'::text THEN 3::numeric
            WHEN planet_osm_line.highway = 'tertiary'::text THEN 4::numeric
            WHEN planet_osm_line.highway ~~ '%_link'::text THEN 5::numeric
            WHEN planet_osm_line.highway = ANY (ARRAY['residential'::text, 'unclassified'::text, 'road'::text]) THEN 6::numeric
            WHEN planet_osm_line.highway = ANY (ARRAY['service'::text, 'minor'::text]) THEN 7::numeric
            ELSE 99::numeric
        END AS priority, planet_osm_line.way
   FROM planet_osm_line
  WHERE (planet_osm_line.highway = ANY (ARRAY['motorway'::text, 'motorway_link'::text, 'trunk'::text, 'trunk_link'::text, 'primary'::text, 'primary_link'::text, 'secondary'::text, 'secondary_link'::text, 'tertiary'::text, 'tertiary_link'::text, 'residential'::text, 'unclassified'::text, 'road'::text, 'minor'::text, 'service'::text, 'footpath'::text, 'track'::text, 'footway'::text, 'steps'::text, 'pedestrian'::text, 'path'::text, 'cycleway'::text, 'living_street'::text])) OR (planet_osm_line.railway IS NOT NULL AND planet_osm_line.railway != 'platform');


CREATE OR REPLACE VIEW brick_road_gen0 AS 
	SELECT * FROM brick_road;
	
CREATE OR REPLACE VIEW brick_road_gen1 AS 
	SELECT * FROM brick_road
	WHERE road_class = 'highway' OR road_class = 'trunk' OR road_class = 'major_road' OR (brick_road.road_class = 'minor_road' AND brick_road.road_type IN ('residential'::text, 'unclassified'::text, 'road'::text, 'minor'::text)) OR road_class = 'rail';

CREATE OR REPLACE VIEW brick_road_gen2 AS 
	SELECT *
	FROM brick_road
	WHERE road_class = 'highway' AND road_type = 'motorway' OR road_class = 'trunk' AND road_type = 'trunk' OR road_class = 'major_road' AND (road_type = ANY (ARRAY['primary', 'secondary'])) OR road_class = 'rail' AND (road_type = ANY (ARRAY['rail', 'subway']));


CREATE OR REPLACE VIEW brick_road_z15 AS 
	SELECT *
	FROM (
		SELECT 'outline'  AS render, 0 AS render_order, *
		FROM brick_road_gen0
		
		UNION ALL 
		
		SELECT 'casing'  AS render, 1 AS render_order, *
		FROM brick_road_gen0
		
		UNION ALL 
		
		SELECT 'inline'  AS render, 2 AS render_order, *
		FROM brick_road_gen0
	
		UNION ALL 

		SELECT 'marker'  AS render, 3 AS render_order, *
		FROM brick_road_gen0
		) foo
	ORDER BY 
		CASE	WHEN foo.render_order = 0 THEN 0
				ELSE 1
		END, 
		explicit_layer ASC, 
		implied_layer ASC, 
		render_order ASC, 
		priority DESC;


CREATE OR REPLACE VIEW brick_road_z13 AS 
	SELECT *
	FROM (
		SELECT 'outline'  AS render, 0 AS render_order, *
		FROM brick_road_gen1
		
		UNION ALL 
		
		SELECT 'casing'  AS render, 1 AS render_order, *
		FROM brick_road_gen1
		
		UNION ALL 
		
		SELECT 'inline'  AS render, 2 AS render_order, *
		FROM brick_road_gen1
	
		UNION ALL 

		SELECT 'marker'  AS render, 3 AS render_order, *
		FROM brick_road_gen1
		) foo
	ORDER BY 
		CASE	WHEN foo.render_order = 0 THEN 0
				ELSE 1
		END, 
		explicit_layer ASC, 
		implied_layer ASC, 
		render_order ASC, 
		priority DESC;
		
		
CREATE OR REPLACE VIEW brick_road_z10 AS
	SELECT *
	FROM (
		SELECT 'outline'  AS render, 0 AS render_order, *
		FROM brick_road_gen2
		
		UNION ALL 
		
		SELECT 'casing'  AS render, 1 AS render_order, *
		FROM brick_road_gen2
		
		UNION ALL 
		
		SELECT 'inline'  AS render, 2 AS render_order, *
		FROM brick_road_gen2
	
		UNION ALL 

		SELECT 'marker'  AS render, 3 AS render_order, *
		FROM brick_road_gen2
		) foo
	ORDER BY 
		CASE	WHEN foo.render_order = 0 THEN 0
				ELSE 1
		END, 
		explicit_layer ASC, 
		implied_layer ASC, 
		render_order ASC, 
		priority DESC;
		
CREATE OR REPLACE VIEW brick_road_overview AS 
SELECT * FROM planet_osm_roads
WHERE planet_osm_roads.highway = ANY (ARRAY['motorway'::text, 'trunk'::text, 'primary'::text]);


END;
