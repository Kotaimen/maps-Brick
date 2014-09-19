BEGIN;

CREATE INDEX ON osm_landusage_areas(type);
CREATE INDEX ON osm_landusage_areas(area);

CREATE INDEX ON osm_landusages_gen0(type);
CREATE INDEX ON osm_landusages_gen0(area);

CREATE INDEX ON osm_landusages_gen1(type);
CREATE INDEX ON osm_landusages_gen1(area);

CREATE INDEX ON osm_landusage_ways(type);

CREATE INDEX ON osm_admin(admin_level);

CREATE INDEX ON osm_places(type);
CREATE INDEX ON osm_places(population);

-- 
CREATE INDEX ON osm_landusage_area_labels USING gist(ST_PointOnSurface(ST_Multi(geometry)));
CREATE INDEX ON osm_landusage_area_labels_gen0 USING gist(ST_PointOnSurface(ST_Multi(geometry)));
CREATE INDEX ON osm_landusage_area_labels_gen1 USING gist(ST_PointOnSurface(ST_Multi(geometry)));

CREATE INDEX ON osm_roads(class, type, name, ref, tunnel, bridge) WHERE (name IS NOT NULL AND name != '') OR (ref IS NOT NULL AND ref != '');

COMMIT;