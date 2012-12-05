BEGIN;

DROP VIEW IF EXISTS brick_waterway_gen0;
DROP VIEW IF EXISTS brick_waterway_gen1;
DROP VIEW IF EXISTS brick_waterway;

DROP VIEW IF EXISTS brick_waterbody_gen0;
DROP VIEW IF EXISTS brick_waterbody_gen1;
DROP VIEW IF EXISTS brick_waterbody;

DROP VIEW IF EXISTS brick_landusage_gen0;
DROP VIEW IF EXISTS brick_landusage_gen1;
DROP VIEW IF EXISTS brick_landusage;

DROP VIEW IF EXISTS brick_building;
DROP VIEW IF EXISTS brick_aeroway;
DROP VIEW IF EXISTS brick_ferry;

DROP VIEW IF EXISTS brick_pier;

-- ferry
CREATE OR REPLACE VIEW brick_ferry AS
	SELECT osm_id, route AS type, way FROM planet_osm_line WHERE route IN ('ferry');

-- waterway
CREATE OR REPLACE VIEW brick_waterway_gen0 AS
	SELECT osm_id, waterway AS type, ST_SIMPLIFY(way, 152.874) AS way FROM planet_osm_line WHERE waterway IN ('river', 'canal');


CREATE OR REPLACE VIEW brick_waterway_gen1 AS
	SELECT osm_id, waterway AS type, way FROM planet_osm_line WHERE waterway IN ('river', 'canal', 'stream');


CREATE OR REPLACE VIEW brick_waterway AS
	SELECT osm_id, waterway AS type, way FROM planet_osm_line WHERE waterway IN ('river', 'canal', 'stream', 'ditch', 'drain');


-- waterbody
CREATE OR REPLACE VIEW brick_waterbody_gen0 AS
	SELECT osm_id, way_area AS area, "natural" AS type, way FROM planet_osm_polygon WHERE ("natural" IN ('water', 'pond') OR waterway IN ('basin', 'canal', 'mill_pond', 'pond', 'riverbank', 'stream') OR landuse IN ('basin', 'reservoir')) AND way_area > 10000;


CREATE OR REPLACE VIEW brick_waterbody_gen1 AS
	SELECT osm_id, way_area AS area, "natural" AS type, way FROM planet_osm_polygon WHERE ("natural" IN ('water', 'pond') OR waterway IN ('basin', 'canal', 'mill_pond', 'pond', 'riverbank', 'stream') OR landuse IN ('basin', 'reservoir')) AND way_area > 1000;


CREATE OR REPLACE VIEW brick_waterbody AS
	SELECT osm_id, way_area AS area, "natural" AS type, way FROM planet_osm_polygon WHERE "natural" IN ('water', 'pond') OR waterway IN ('basin', 'canal', 'mill_pond', 'pond', 'riverbank', 'stream') OR landuse IN ('basin', 'reservoir');


-- landusage
CREATE OR REPLACE VIEW brick_landusage_gen0 AS
	SELECT osm_id, way_area AS area, COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) AS type, ST_SIMPLIFY(way, 152.874) AS way FROM planet_osm_polygon  WHERE way_area > 100000 AND (COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) is not NULL) ORDER BY way_area DESC;


CREATE OR REPLACE VIEW brick_landusage_gen1 AS
	SELECT osm_id, way_area AS area, COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) AS type, way FROM planet_osm_polygon  WHERE way_area > 10000 AND (COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) is not NULL) ORDER BY way_area DESC;


CREATE OR REPLACE VIEW brick_landusage AS
	SELECT osm_id, way_area AS area, COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) AS type, way FROM planet_osm_polygon WHERE COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) is not NULL ORDER BY way_area DESC;


-- building
CREATE OR REPLACE VIEW brick_building AS
	SELECT osm_id, building AS type, way FROM planet_osm_polygon WHERE building NOT IN ('0','false', 'no') ORDER BY ST_YMin(ST_Envelope(way)) DESC;


-- aeroway
CREATE OR REPLACE VIEW brick_aeroway AS
	SELECT osm_id, aeroway AS type, way FROM planet_osm_line WHERE aeroway IN ('apron', 'runway', 'taxiway');

-- breakwater
CREATE OR REPLACE VIEW brick_pier AS 
	 SELECT planet_osm_line.osm_id, planet_osm_line.man_made AS type, planet_osm_line.way
	   FROM planet_osm_line
	  WHERE planet_osm_line.man_made = ANY (ARRAY['pier'::text, 'breakwater'::text]);


end;
