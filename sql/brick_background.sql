BEGIN;

-- waterway
CREATE INDEX ON planet_osm_line("waterway");

CREATE OR REPLACE VIEW brick_waterway AS
       SELECT 'waterway'::text AS waterway_class, waterway AS waterway_type, *
       FROM planet_osm_line 
       WHERE waterway IN ('river', 'canal', 'stream', 'ditch', 'drain');

CREATE OR REPLACE VIEW brick_waterway_gen1 AS
       SELECT 'waterway'::text AS waterway_class, waterway AS waterway_type, *
       FROM planet_osm_line
       WHERE waterway IN ('river', 'canal', 'stream');

CREATE OR REPLACE VIEW brick_waterway_gen0 AS
       SELECT 'waterway'::text AS waterway_class, waterway AS waterway_type, *
       FROM planet_osm_line
       WHERE waterway IN ('river', 'canal');


-- waterbody
CREATE INDEX ON planet_osm_polygon("waterway");
CREATE INDEX ON planet_osm_polygon("way_area");

CREATE OR REPLACE VIEW brick_waterbody AS 
       SELECT * FROM
       (
       SELECT 'natural'::text AS waterbody_class, "natural" AS waterbody_type, *
       FROM planet_osm_polygon
       WHERE "natural" IN ('water', 'pond')

       UNION ALL

       SELECT 'waterway'::text AS waterbody_class, "waterway" AS waterbody_type, * 
       FROM planet_osm_polygon
       WHERE "waterway" IN ('basin', 'canal', 'mill_pond', 'pond', 'riverbank', 'stream')

       UNION ALL

       SELECT 'landuse'::text AS waterbody_class, "landuse" AS waterbody_type, *
       FROM planet_osm_polygon 
       WHERE landuse IN ('basin', 'reservoir')
       ) AS FOO;


CREATE OR REPLACE VIEW brick_waterbody_gen1 AS
       SELECT * FROM brick_waterbody WHERE way_area > 1000;

CREATE OR REPLACE VIEW brick_waterbody_gen0 AS
       SELECT * FROM brick_waterbody WHERE way_area > 10000;


-- landusage area
CREATE INDEX ON planet_osm_polygon(landuse, leisure, "natural", highway, amenity, tourism, aeroway);


CREATE OR REPLACE VIEW brick_landusage_area AS 
       SELECT 'landuse'::text AS landusage_class, COALESCE(landuse, leisure, "natural", highway, amenity, tourism, aeroway) AS landusage_type, *
       FROM planet_osm_polygon
       ORDER BY way_area DESC, osm_id DESC NULLS LAST;

CREATE OR REPLACE VIEW brick_landusage_area_gen1 AS
       SELECT * FROM brick_landusage_area
       WHERE way_area > 10000
       ORDER BY way_area DESC;

CREATE OR REPLACE VIEW brick_landusage_area_gen0 AS
       SELECT * FROM brick_landusage_area
       WHERE way_area > 100000
       ORDER BY way_area DESC;


-- building
CREATE INDEX ON planet_osm_polygon("building");

CREATE OR REPLACE VIEW brick_building AS
       SELECT 'building'::text AS building_class, building AS building_type, *
       FROM planet_osm_polygon 
       WHERE building NOT IN ('0','false', 'no', '') 
       ORDER BY ST_YMin(ST_Envelope(way)) DESC;


-- landusage line
CREATE INDEX ON planet_osm_line("aeroway");
CREATE INDEX ON planet_osm_line("man_made");
CREATE INDEX ON planet_osm_line("route");


CREATE OR REPLACE VIEW brick_aeroway AS
       SELECT 'aeroway'::text AS landusage_class, aeroway AS landusage_type, *
       FROM planet_osm_line 
       WHERE aeroway IN ('apron', 'runway', 'taxiway');

CREATE OR REPLACE VIEW brick_pier AS
       SELECT 'man_made'::text AS landusage_class, man_made AS landusage_type, *
       FROM planet_osm_line
       WHERE man_made IN ('pier', 'breakwater');

CREATE OR REPLACE VIEW brick_ferry AS
       SELECT 'route'::text AS landusage_class, route AS landusage_type, *
       FROM planet_osm_line
       WHERE route IN ('ferry');


END;
