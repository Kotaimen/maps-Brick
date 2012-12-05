BEGIN;
DROP TABLE IF EXISTS brick_ferry_table;
DROP TABLE IF EXISTS brick_landusage_gen0_table;
DROP TABLE IF EXISTS brick_landusage_label_table;
DROP TABLE IF EXISTS brick_road_label_gen1;
DROP TABLE IF EXISTS brick_waterbody_gen0_table;
DROP TABLE IF EXISTS brick_waterway_gen0_table;
DROP TABLE IF EXISTS brick_pier_table;
END;

CREATE INDEX ON planet_osm_line(bridge);
CREATE INDEX ON planet_osm_line(highway);
CREATE INDEX ON planet_osm_line(railway);
CREATE INDEX ON planet_osm_line(route);
CREATE INDEX ON planet_osm_line(tunnel);

CREATE INDEX ON planet_osm_polygon(amenity);
CREATE INDEX ON planet_osm_polygon(landuse);
CREATE INDEX ON planet_osm_polygon(leisure);
CREATE INDEX ON planet_osm_polygon(way_area);
CREATE INDEX ON planet_osm_polygon(z_order);


BEGIN;
CREATE TABLE brick_ferry_table AS SELECT * FROM brick_ferry;
SELECT POPULATE_GEOMETRY_COLUMNS('brick_ferry_table'::regclass);
CREATE INDEX ON brick_ferry_table USING gist(way);
END;

BEGIN;
CREATE TABLE brick_landusage_gen0_table AS SELECT * FROM brick_landusage_gen0;
SELECT POPULATE_GEOMETRY_COLUMNS('brick_landusage_gen0_table'::regclass);
CREATE INDEX ON brick_landusage_gen0_table USING gist(way);
END;

BEGIN;
CREATE TABLE brick_landusage_label_table AS SELECT * FROM brick_landusage_label;
SELECT POPULATE_GEOMETRY_COLUMNS('brick_landusage_label_table'::regclass);
CREATE INDEX ON brick_landusage_label_table USING gist(way);
END;

BEGIN;
CREATE TABLE brick_road_label_gen1 AS SELECT * FROM brick_road_label WHERE priority <= 2;
SELECT POPULATE_GEOMETRY_COLUMNS('brick_road_label_gen1'::regclass);
CREATE INDEX ON brick_road_label_gen1 USING gist(way);
CREATE INDEX ON brick_road_label_gen1(priority);
END;

BEGIN;
CREATE TABLE brick_waterbody_gen0_table AS SELECT * FROM brick_waterbody_gen0;
SELECT POPULATE_GEOMETRY_COLUMNS('brick_waterbody_gen0_table'::regclass);
CREATE INDEX ON brick_waterbody_gen0_table USING gist(way);
END;

BEGIN;
CREATE TABLE brick_waterway_gen0_table AS SELECT * FROM brick_waterway_gen0;
SELECT POPULATE_GEOMETRY_COLUMNS('brick_waterway_gen0_table'::regclass);
CREATE INDEX ON brick_waterway_gen0_table USING gist(way);
END;

BEGIN;
CREATE TABLE brick_pier_table AS SELECT * FROM brick_pier;
SELECT POPULATE_GEOMETRY_COLUMNS('brick_pier_table'::regclass);
CREATE INDEX ON brick_pier_table USING gist(way);
END;
