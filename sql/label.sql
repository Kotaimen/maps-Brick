BEGIN;

SET search_path TO import, public;

CREATE INDEX ON osm_places(type);
CREATE INDEX ON osm_places(population);

CREATE INDEX ON osm_landusage_areas(name);
CREATE INDEX ON osm_landusage_areas(area);

CREATE INDEX ON osm_roads(name);


CREATE OR REPLACE VIEW import.brick_places AS
    SELECT *,
        CASE
        	WHEN type = 'county' THEN 1
        	WHEN type = 'region' THEN 2
        	WHEN type = 'state' THEN 3
        	WHEN type = 'city' THEN 4
        	WHEN type = 'town' THEN 5
        	WHEN type = 'suburb' THEN 6
        	WHEN type = 'village' THEN 7
        	WHEN type = 'hamlet' THEN 8
        	WHEN type = 'locality' THEN 9
        	ELSE 10
        END AS rank
    FROM osm_places
    ORDER BY rank, population DESC NULLS LAST;




CREATE OR REPLACE VIEW import.brick_landusage_area_labels AS 
    SELECT brick_landusage_areas.id, 
	brick_landusage_areas.osm_id, 
	brick_landusage_areas.name, 
	brick_landusage_areas.class, 
	brick_landusage_areas.type, 
	brick_landusage_areas.area, 
	st_pointonsurface(brick_landusage_areas.geometry)::geometry(Point,3857) AS geometry
    FROM import.brick_landusage_areas
    WHERE brick_landusage_areas.area > 1024::double precision AND brick_landusage_areas.name IS NOT NULL AND brick_landusage_areas.name::text <> ''::text AND st_isvalid(brick_landusage_areas.geometry)
    ORDER BY brick_landusage_areas.area DESC;


CREATE OR REPLACE VIEW import.brick_landusage_area_labels_gen0 AS 
    SELECT brick_landusage_areas.id, 
	brick_landusage_areas.osm_id, 
	brick_landusage_areas.name, 
	brick_landusage_areas.class, 
	brick_landusage_areas.type, 
	brick_landusage_areas.area, 
	st_pointonsurface(brick_landusage_areas.geometry)::geometry(Point,3857) AS geometry
    FROM import.brick_landusage_areas
    WHERE brick_landusage_areas.area > 1024000000::double precision AND brick_landusage_areas.name IS NOT NULL AND brick_landusage_areas.name::text <> ''::text AND st_isvalid(brick_landusage_areas.geometry)
    ORDER BY brick_landusage_areas.area DESC;


CREATE OR REPLACE VIEW import.brick_landusage_area_labels_gen1 AS 
    SELECT brick_landusage_areas.id, 
	brick_landusage_areas.osm_id, 
	brick_landusage_areas.name, 
	brick_landusage_areas.class, 
	brick_landusage_areas.type, 
	brick_landusage_areas.area, 
	st_pointonsurface(brick_landusage_areas.geometry)::geometry(Point,3857) AS geometry
    FROM import.brick_landusage_areas
    WHERE brick_landusage_areas.area > 10240000::double precision AND brick_landusage_areas.name IS NOT NULL AND brick_landusage_areas.name::text <> ''::text AND st_isvalid(brick_landusage_areas.geometry)
    ORDER BY brick_landusage_areas.area DESC;



CREATE OR REPLACE VIEW import.brick_road_labels AS 
    SELECT osm_roads.class, osm_roads.type, regexp_replace(osm_roads.name::text, '(.*)\(.*\)'::text, '\1'::text) AS name, 
            CASE
                WHEN sin(pi() / 2::double precision - st_azimuth(st_startpoint(osm_roads.geometry), st_endpoint(osm_roads.geometry))) > 0::double precision THEN 1
                ELSE (-1)
            END AS direction, osm_roads.geometry,
            CASE
                WHEN osm_roads.type::text = 'motorway'::text THEN 0::smallint
                WHEN osm_roads.type::text = 'motorway_link'::text THEN 1::smallint
                WHEN osm_roads.type::text = 'trunk'::text THEN 2::smallint
                WHEN osm_roads.type::text = 'trunk_link'::text THEN 3::smallint
                WHEN osm_roads.type::text = 'primary'::text THEN 5::smallint
                WHEN osm_roads.type::text = 'primary_link'::text THEN 6::smallint
                WHEN osm_roads.type::text = 'secondary'::text THEN 7::smallint
                WHEN osm_roads.type::text = 'secondary_link'::text THEN 8::smallint
                WHEN osm_roads.type::text = 'tertiary'::text THEN 9::smallint
                WHEN osm_roads.type::text = 'tertiary_link'::text THEN 10::smallint
                WHEN osm_roads.type::text = ANY (ARRAY['residential'::character varying::text, 'unclassified'::character varying::text, 'road'::character varying::text, 'minor'::character varying::text]) THEN 11::smallint
                WHEN osm_roads.class::text = 'railway'::text THEN 12::smallint
                
                ELSE 99::smallint
            END AS rank
       FROM import.osm_roads
      WHERE osm_roads.name IS NOT NULL AND osm_roads.name::text <> ''::text
      ORDER BY 
           rank DESC;


COMMIT;
