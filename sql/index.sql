BEGIN;

-- SET search_path TO import, public;

-- index
CREATE INDEX ON osm_landusage_areas(type);
CREATE INDEX ON osm_landusage_areas(area);

CREATE INDEX ON osm_landusages_gen0(type);
CREATE INDEX ON osm_landusages_gen0(area);

CREATE INDEX ON osm_landusages_gen1(type);
CREATE INDEX ON osm_landusages_gen1(area);

CREATE INDEX ON osm_admin(admin_level);


CREATE INDEX ON osm_roads(type);
CREATE INDEX ON osm_roads(tunnel);
CREATE INDEX ON osm_roads(bridge);
CREATE INDEX ON osm_roads(oneway);
CREATE INDEX ON osm_roads(layer);

CREATE INDEX ON osm_roads_gen0(type);
CREATE INDEX ON osm_roads_gen0(tunnel);
CREATE INDEX ON osm_roads_gen0(bridge);
CREATE INDEX ON osm_roads_gen0(oneway);
CREATE INDEX ON osm_roads_gen0(layer);

CREATE INDEX ON osm_roads_gen1(type);
CREATE INDEX ON osm_roads_gen1(tunnel);
CREATE INDEX ON osm_roads_gen1(bridge);
CREATE INDEX ON osm_roads_gen1(oneway);
CREATE INDEX ON osm_roads_gen1(layer);


CREATE INDEX ON osm_places(type);
CREATE INDEX ON osm_places(population);

CREATE INDEX ON osm_landusage_areas(area);

CREATE INDEX ON osm_landusage_area_labels(area);
CREATE INDEX ON osm_landusage_area_labels_gen0(area);
CREATE INDEX ON osm_landusage_area_labels_gen1(area);

-- Important! Index for centroid point of landusage areas
CREATE INDEX ON osm_landusage_area_labels USING gist((st_centroid(geometry)::geometry(Point,4326)));
CREATE INDEX ON osm_landusage_area_labels_gen0 USING gist((st_centroid(geometry)::geometry(Point,4326)));
CREATE INDEX ON osm_landusage_area_labels_gen1 USING gist((st_centroid(geometry)::geometry(Point,4326)));


CREATE INDEX ON brick_shields USING GIST(geometry);
CREATE INDEX ON brick_shields_gen0 USING GIST(geometry);


UPDATE osm_landusage_areas SET area=st_area(st_transform(geometry, 3857));
UPDATE osm_landusages_gen0 SET area=st_area(st_transform(geometry, 3857));
UPDATE osm_landusages_gen1 SET area=st_area(st_transform(geometry, 3857));


UPDATE osm_landusage_area_labels_gen0 SET area=st_area(st_transform(geometry, 3857));
UPDATE osm_landusage_area_labels_gen1 SET area=st_area(st_transform(geometry, 3857));
UPDATE osm_landusage_area_labels SET area=st_area(st_transform(geometry, 3857));


UPDATE osm_waterareas SET area=st_area(st_transform(geometry, 3857));
UPDATE osm_waterareas_gen0 SET area=st_area(st_transform(geometry, 3857));
UPDATE osm_waterareas_gen1 SET area=st_area(st_transform(geometry, 3857));

COMMIT;