BEGIN;

SET search_path TO import, public;

CREATE INDEX ON osm_roads(type);
CREATE INDEX ON osm_roads(class);
CREATE INDEX ON osm_roads(tunnel);
CREATE INDEX ON osm_roads(bridge);
CREATE INDEX ON osm_roads(oneway);
CREATE INDEX ON osm_roads(layer);


CREATE OR REPLACE VIEW import.brick_roads_stage AS 
    SELECT osm_roads.id, osm_roads.osm_id, osm_roads.class, osm_roads.type, osm_roads.tunnel, osm_roads.bridge, osm_roads.oneway, 
        CASE
            WHEN osm_roads.type::text ~~ '%_link'::text THEN 1::smallint
            ELSE 0::smallint
        END AS link, osm_roads.access, osm_roads.service, 
        CASE
            WHEN osm_roads.layer IS NULL THEN 0::smallint
            ELSE osm_roads.layer::smallint
        END AS layer, 
        CASE
            WHEN osm_roads.class::text = 'highway'::text AND osm_roads.type::text = 'motorway'::text THEN 0::smallint
            WHEN osm_roads.class::text = 'highway'::text AND osm_roads.type::text = 'trunk'::text THEN 1::smallint
            WHEN osm_roads.class::text = 'railway'::text THEN 2::smallint
            WHEN osm_roads.class::text = 'highway'::text AND osm_roads.type::text = 'primary'::text THEN 3::smallint
            WHEN osm_roads.class::text = 'highway'::text AND osm_roads.type::text = 'secondary'::text THEN 4::smallint
            WHEN osm_roads.class::text = 'highway'::text AND osm_roads.type::text = 'tertiary'::text THEN 5::smallint
            WHEN osm_roads.class::text = 'highway'::text AND osm_roads.type::text ~~ '%_link'::text THEN 6::smallint
            WHEN osm_roads.class::text = 'highway'::text AND (osm_roads.type::text = ANY (ARRAY['residential'::character varying, 'unclassified'::character varying, 'road'::character varying, 'minor'::character varying]::text[])) THEN 7::smallint
            ELSE 8::smallint
        END AS rank, osm_roads.geometry
    FROM import.osm_roads;


CREATE OR REPLACE VIEW import.brick_roads AS 
    SELECT * FROM (
	SELECT 'outline'::text AS render, 1 AS outline, 0 AS render_order, * FROM import.brick_roads_stage
        UNION ALL 
        SELECT 'casing'::text AS render, 0 AS outline, 1 AS render_order, * FROM import.brick_roads_stage
        UNION ALL 
        SELECT 'inline'::text AS render, 0 AS outline, 2 AS render_order, * FROM import.brick_roads_stage
        UNION ALL 
        SELECT 'marker'::text AS render, 0 AS outline, 3 AS render_order, * FROM import.brick_roads_stage
    ) foo
    ORDER BY 
    	  foo.outline DESC, 
    	  foo.layer ASC, 
	  foo.tunnel DESC NULLS LAST, 
	  foo.bridge NULLS FIRST, 
	  foo.render_order ASC, 
	  foo.rank DESC;


CREATE OR REPLACE VIEW import.brick_roads_gen0 AS 
    SELECT brick_roads_stage.id, 
    	   brick_roads_stage.osm_id, 
	   brick_roads_stage.class, 
	   brick_roads_stage.type, 
	   brick_roads_stage.tunnel, 
	   brick_roads_stage.bridge, 
	   brick_roads_stage.oneway, 
	   brick_roads_stage.link, 
	   brick_roads_stage.access, 
	   brick_roads_stage.service, 
	   brick_roads_stage.layer, 
	   brick_roads_stage.rank, 
	   brick_roads_stage.geometry
    FROM import.brick_roads_stage
    WHERE brick_roads_stage.type::text = ANY (ARRAY['motorway'::character varying::text, 'trunk'::character varying::text, 'primary'::character varying::text, 'secondary'::character varying::text])
    ORDER BY brick_roads_stage.rank DESC;


CREATE OR REPLACE VIEW import.brick_roads_gen1 AS 
    SELECT brick_roads.render, 
    	   brick_roads.outline, 
	   brick_roads.render_order, 
	   brick_roads.id, 
	   brick_roads.osm_id, 
	   brick_roads.class, 
	   brick_roads.type, 
	   brick_roads.tunnel, 
	   brick_roads.bridge, 
	   brick_roads.oneway, 
	   brick_roads.link, 
	   brick_roads.access, 
	   brick_roads.service, 
	   brick_roads.layer, 
	   brick_roads.rank, 
	   brick_roads.geometry
   FROM import.brick_roads
   WHERE (brick_roads.type::text = ANY (ARRAY['motorway'::character varying, 'motorway_link'::character varying, 'trunk'::character varying, 'trunk_link'::character varying, 'primary'::character varying, 'primary_link'::character varying, 'secondary'::character varying, 'secondary_link'::character varying, 'tertiary'::character varying, 'tertiary_link'::character varying, 'rail'::character varying]::text[])) AND render IN ('casing'::character varying, 'inline'::character varying) ;


COMMIT;
