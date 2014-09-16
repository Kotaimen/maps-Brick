-- View: brick_roads_all

-- DROP VIEW brick_roads_all;

CREATE OR REPLACE VIEW brick_roads_all AS 
 SELECT osm_roads.osm_id,
    osm_roads.class,
    osm_roads.tunnel,
    osm_roads.bridge,
    osm_roads.oneway,
        CASE
            WHEN osm_roads.type = ANY (ARRAY['motorway', 'motorway_link', 'trunk', 'trunk_link']) THEN 'motorway'
            WHEN osm_roads.type = ANY (ARRAY['primary', 'primary_link']) THEN 'primary'
            WHEN osm_roads.type = ANY (ARRAY['secondary', 'secondary_link', 'tertiary', 'tertiary_link']) THEN 'secondary'
            WHEN osm_roads.type = ANY (ARRAY['residential', 'unclassified', 'road', 'minor']) THEN 'minor'
            WHEN osm_roads.type = ANY (ARRAY['path', 'track', 'living_street', 'service']) THEN 'path'
            WHEN osm_roads.type = ANY (ARRAY['footway', 'bridleway', 'cycleway', 'pedestrian', 'steps']) THEN 'pedestrian'
            WHEN osm_roads.type = ANY (ARRAY['construction', 'proposed']) THEN 'proposed'
            WHEN osm_roads.type = 'rail' THEN 'rail'
            WHEN osm_roads.type = ANY (ARRAY['subway', 'light_rail']) THEN 'subway'
            WHEN osm_roads.type = ANY (ARRAY['monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular']) THEN 'monorail'
            ELSE 'path'
        END AS type,
        CASE
            WHEN osm_roads.type ~~ '%_link' THEN 1
            ELSE 0
        END AS link,
        CASE
            WHEN osm_roads.layer IS NULL THEN 0
            ELSE osm_roads.layer
        END AS layer,
        CASE
	    WHEN osm_roads.type = 'motorway' THEN 0
--            WHEN osm_roads.type = 'motorway_link' THEN 1
            WHEN osm_roads.type = 'trunk' THEN 20
--            WHEN osm_roads.type = 'trunk_link' THEN 21
            WHEN osm_roads.class = 'railway' THEN 30
            WHEN osm_roads.type = 'primary' THEN 40
--            WHEN osm_roads.type = 'primary_link' THEN 41
            WHEN osm_roads.type = 'secondary' THEN 50
--            WHEN osm_roads.type = 'secondary_link' THEN 51
            WHEN osm_roads.type = 'tertiary' THEN 60
            
            WHEN osm_roads.type = ANY (ARRAY['residential', 'unclassified', 'road', 'minor']) THEN 70
            WHEN osm_roads.type = ANY (ARRAY['path', 'track', 'living_street', 'service']) THEN 80
            WHEN osm_roads.type = ANY (ARRAY['footway', 'bridleway', 'cycleway', 'pedestrian', 'steps']) THEN 90
            WHEN osm_roads.type = ANY (ARRAY['construction', 'proposed']) THEN 100

            WHEN osm_roads.type = 'motorway_link' THEN 265
	    WHEN osm_roads.type = 'trunk_link' THEN 266
	    WHEN osm_roads.type = 'primary_link' THEN 267
            WHEN osm_roads.type = 'secondary_link' THEN 268
            WHEN osm_roads.type = 'tertiary_link' THEN 269

            ELSE 255
        END AS rank,
    osm_roads.geometry
   FROM osm_roads
  ORDER BY
        CASE
            WHEN osm_roads.layer IS NULL THEN 0
            ELSE osm_roads.layer
        END, 
        osm_roads.tunnel DESC NULLS LAST, 
        osm_roads.bridge NULLS FIRST, 
        rank DESC;

ALTER TABLE brick_roads_all
  OWNER TO postgres;
