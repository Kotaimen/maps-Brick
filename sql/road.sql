BEGIN;

SET search_path TO import, public;

CREATE INDEX ON osm_roads(type);
CREATE INDEX ON osm_roads(class);
CREATE INDEX ON osm_roads(tunnel);
CREATE INDEX ON osm_roads(bridge);
CREATE INDEX ON osm_roads(oneway);
CREATE INDEX ON osm_roads(layer);

CREATE INDEX ON osm_roads_gen0(type);
CREATE INDEX ON osm_roads_gen0(class);
CREATE INDEX ON osm_roads_gen0(tunnel);
CREATE INDEX ON osm_roads_gen0(bridge);
CREATE INDEX ON osm_roads_gen0(oneway);
CREATE INDEX ON osm_roads_gen0(layer);

CREATE INDEX ON osm_roads_gen1(type);
CREATE INDEX ON osm_roads_gen1(class);
CREATE INDEX ON osm_roads_gen1(tunnel);
CREATE INDEX ON osm_roads_gen1(bridge);
CREATE INDEX ON osm_roads_gen1(oneway);
CREATE INDEX ON osm_roads_gen1(layer);


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
            WHEN type::text = 'motorway'::text THEN 0::smallint
	    WHEN type::text = 'motorway_link'::text THEN 1::smallint
            WHEN type::text = 'trunk'::text THEN 2::smallint
            WHEN type::text = 'trunk_link'::text THEN 3::smallint
            WHEN class::text = 'railway'::text THEN 4::smallint
            WHEN type::text = 'primary'::text THEN 5::smallint
            WHEN type::text = 'primary_link'::text THEN 6::smallint 
            WHEN type::text = 'secondary'::text THEN 7::smallint
            WHEN type::text = 'secondary_link'::text THEN 8::smallint
            WHEN type::text = 'tertiary'::text THEN 9::smallint
            WHEN type::text = 'tertiary_link'::text THEN 10::smallint
            WHEN type::text = ANY (ARRAY['residential'::character varying::text, 'unclassified'::character varying::text, 'road'::character varying::text, 'minor'::character varying::text]) THEN 11::smallint
            ELSE 99::smallint
        END AS rank, osm_roads.geometry
    FROM import.osm_roads;


CREATE OR REPLACE VIEW import.brick_roads_stage_gen0 AS 
 SELECT osm_roads_gen0.osm_id, osm_roads_gen0.class, osm_roads_gen0.type, osm_roads_gen0.tunnel, osm_roads_gen0.bridge, osm_roads_gen0.oneway, 
        CASE
            WHEN osm_roads_gen0.type::text ~~ '%_link'::text THEN 1::smallint
            ELSE 0::smallint
        END AS link, osm_roads_gen0.access, osm_roads_gen0.service, 
        CASE
            WHEN osm_roads_gen0.layer IS NULL THEN 0::smallint
            ELSE osm_roads_gen0.layer::smallint
        END AS layer, 
        CASE
            WHEN type::text = 'motorway'::text THEN 0::smallint
	    WHEN type::text = 'motorway_link'::text THEN 1::smallint
            WHEN type::text = 'trunk'::text THEN 2::smallint
            WHEN type::text = 'trunk_link'::text THEN 3::smallint
            WHEN class::text = 'railway'::text THEN 4::smallint
            WHEN type::text = 'primary'::text THEN 5::smallint
            WHEN type::text = 'primary_link'::text THEN 6::smallint 
            WHEN type::text = 'secondary'::text THEN 7::smallint
            WHEN type::text = 'secondary_link'::text THEN 8::smallint
            WHEN type::text = 'tertiary'::text THEN 9::smallint
            WHEN type::text = 'tertiary_link'::text THEN 10::smallint
            WHEN type::text = ANY (ARRAY['residential'::character varying::text, 'unclassified'::character varying::text, 'road'::character varying::text, 'minor'::character varying::text]) THEN 11::smallint
            ELSE 99::smallint
        END  AS rank, osm_roads_gen0.geometry
   FROM import.osm_roads_gen0;


CREATE OR REPLACE VIEW import.brick_roads_stage_gen1 AS 
 SELECT osm_roads_gen1.osm_id, osm_roads_gen1.class, osm_roads_gen1.type, osm_roads_gen1.tunnel, osm_roads_gen1.bridge, osm_roads_gen1.oneway, 
        CASE
            WHEN osm_roads_gen1.type::text ~~ '%_link'::text THEN 1::smallint
            ELSE 0::smallint
        END AS link, osm_roads_gen1.access, osm_roads_gen1.service, 
        CASE
            WHEN osm_roads_gen1.layer IS NULL THEN 0::smallint
            ELSE osm_roads_gen1.layer::smallint
        END AS layer, 
        CASE
            WHEN type::text = 'motorway'::text THEN 0::smallint
	    WHEN type::text = 'motorway_link'::text THEN 1::smallint
            WHEN type::text = 'trunk'::text THEN 2::smallint
            WHEN type::text = 'trunk_link'::text THEN 3::smallint
            WHEN class::text = 'railway'::text THEN 4::smallint
            WHEN type::text = 'primary'::text THEN 5::smallint
            WHEN type::text = 'primary_link'::text THEN 6::smallint 
            WHEN type::text = 'secondary'::text THEN 7::smallint
            WHEN type::text = 'secondary_link'::text THEN 8::smallint
            WHEN type::text = 'tertiary'::text THEN 9::smallint
            WHEN type::text = 'tertiary_link'::text THEN 10::smallint
            WHEN type::text = ANY (ARRAY['residential'::character varying::text, 'unclassified'::character varying::text, 'road'::character varying::text, 'minor'::character varying::text]) THEN 11::smallint
            ELSE 99::smallint
        END  AS rank, osm_roads_gen1.geometry
   FROM import.osm_roads_gen1;




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
    SELECT brick_roads_stage_gen0.osm_id, 
    	   brick_roads_stage_gen0.class, 
	   brick_roads_stage_gen0.type, 
	   brick_roads_stage_gen0.tunnel, 
	   brick_roads_stage_gen0.bridge, 
	   brick_roads_stage_gen0.oneway, 
	   brick_roads_stage_gen0.link, 
	   brick_roads_stage_gen0.access, 
	   brick_roads_stage_gen0.service, 
	   brick_roads_stage_gen0.layer, 
	   brick_roads_stage_gen0.rank, 
	   brick_roads_stage_gen0.geometry
    FROM import.brick_roads_stage_gen0
    ORDER BY brick_roads_stage_gen0.rank DESC;



CREATE OR REPLACE VIEW import.brick_roads_gen1 AS 
    SELECT *
    FROM (         
    	SELECT 'casing'::text AS render, 1 AS outline, 0 AS render_order, * FROM import.brick_roads_stage_gen1
        UNION ALL 
        SELECT 'inline'::text AS render, 0 AS outline, 1 AS render_order, * FROM import.brick_roads_stage_gen1
    ) foo
    ORDER BY foo.outline DESC, 
    	     foo.layer ASC, 
	     foo.tunnel DESC NULLS LAST, 
	     foo.bridge NULLS FIRST, 
	     foo.render_order ASC, 
	     foo.rank DESC;



COMMIT;
