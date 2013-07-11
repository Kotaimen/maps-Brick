BEGIN;

CREATE INDEX ON planet_osm_line("highway");
CREATE INDEX ON planet_osm_line("railway");


CREATE OR REPLACE VIEW brick_road AS 
SELECT
	*,
	regexp_replace(foo.name, '(.*)\(.*\)' , '\1' ) AS road_name, 
	CASE
		WHEN foo.name ~* '\mavenue$'  THEN regexp_replace(foo.name, '\m(ave)nue$' , '\1' , 'i' )
		WHEN foo.name ~* '\mboulevard$'  THEN regexp_replace(foo.name, '\m(b)oulevard$' , '\1lvd' , 'i' )
		WHEN foo.name ~* '\mexpressway$'  THEN regexp_replace(foo.name, '\m(E)xpressway$' , '\1xpwy' , 'i' )
		WHEN foo.name ~* '\mhighway$'  THEN regexp_replace(foo.name, '\m(h)ighway$' , '\1wy' , 'i' )
		WHEN foo.name ~* '\mparkway$'  THEN regexp_replace(foo.name, '\m(p)arkway$' , '\1kwy' , 'i' )
		WHEN foo.name ~* '\mcourt$'  THEN regexp_replace(foo.name, '\m(c)ourt$' , '\1t' , 'i' )
		WHEN foo.name ~* '\mdrive$'  THEN regexp_replace(foo.name, '\m(dr)ive$' , '\1' , 'i' )
		WHEN foo.name ~* '\mplace$'  THEN regexp_replace(foo.name, '\m(pl)ace$' , '\1' , 'i' )
		WHEN foo.name ~* '\mlane$'  THEN regexp_replace(foo.name, '\m(l)ane$' , '\1n' , 'i' )
		WHEN foo.name ~* '\mroad$'  THEN regexp_replace(foo.name, '\m(r)oad$' , '\1d' , 'i' )
		WHEN foo.name ~* '\mstreet$'  THEN regexp_replace(foo.name, '\m(st)reet$' , '\1' , 'i' )
		WHEN foo.name ~* '\mtrail$'  THEN regexp_replace(foo.name, '\m(tr)ail$' , '\1' , 'i' )
		WHEN foo.name ~* '\mway$'  THEN regexp_replace(foo.name, '\m(w)ay$' , '\1y' , 'i' )
		ELSE foo.name
	END AS road_name_abbr, 
	CASE
		WHEN foo.oneway = ANY (ARRAY['yes' , 'true' ]) THEN 1
		WHEN foo.oneway = ANY (ARRAY['no' , 'false' ]) THEN 0
		WHEN foo.oneway = '-1'  THEN (-1)
		ELSE 0
	END AS is_oneway, 
	CASE
		WHEN foo.highway ~~ '%_link'  THEN 1
		ELSE 0
	END AS is_link, 
	CASE
		WHEN foo.tunnel = ANY (ARRAY['yes' , 'true' ]) THEN 1
		ELSE 0
	END AS is_tunnel, 
	CASE
		WHEN foo.bridge = ANY (ARRAY['yes' , 'true' ]) THEN 1
		ELSE 0
	END AS is_bridge, 
	CASE
		WHEN foo.layer ~ '^-?[[:digit:]]+(\.[[:digit:]]+)?$'  THEN foo.layer::double precision
		ELSE 0::double precision
	END AS explicit_layer, 
	CASE
		WHEN foo.tunnel = ANY (ARRAY['yes' , 'true' ]) THEN (-1)
		WHEN foo.bridge = ANY (ARRAY['yes' , 'true' ]) THEN 1
		ELSE 0
	END AS implied_layer, 
	CASE
		WHEN foo.highway = 'motorway'  THEN 0::numeric
		WHEN foo.railway IS NOT NULL THEN 0.5
		WHEN foo.highway = 'trunk'  THEN 1::numeric
		WHEN foo.highway = 'primary'  THEN 2::numeric
		WHEN foo.highway = 'secondary'  THEN 3::numeric
		WHEN foo.highway = 'tertiary'  THEN 4::numeric
		WHEN foo.highway ~~ '%_link'  THEN 5::numeric
		WHEN foo.highway = ANY (ARRAY['residential' , 'unclassified' , 'road' ]) THEN 6::numeric
		WHEN foo.highway = ANY (ARRAY['service' , 'minor' ]) THEN 7::numeric
		ELSE 99::numeric
	END AS priority
FROM 
	(         
	SELECT 
		CASE
			WHEN highway = ANY (ARRAY['motorway', 'motorway_link']) THEN 'highway'
			WHEN highway = ANY (ARRAY['trunk', 'trunk_link']) THEN 'trunk'
			WHEN highway = ANY (ARRAY['primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link']) THEN 'major_road'
			WHEN highway = ANY (ARRAY['residential', 'unclassified', 'road', 'minor']) THEN 'minor_road'
			WHEN highway = ANY (ARRAY['service', 'footpath', 'track', 'footway', 'steps', 'pedestrian', 'path', 'cycleway']) THEN 'path'
			ELSE NULL
		END AS road_class, highway AS road_type, *
		FROM planet_osm_line
		WHERE highway IS NOT NULL
	UNION ALL 
		SELECT 'rail' AS road_class, railway AS road_type, *
		FROM planet_osm_line
		WHERE railway IS NOT NULL
	) foo;
	

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
