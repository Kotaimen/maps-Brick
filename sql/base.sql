BEGIN;

SET search_path TO import, public;

CREATE INDEX ON osm_landusage_areas(type);
CREATE INDEX ON osm_landusage_areas(area);
CREATE INDEX ON osm_landusages_gen0(area);
CREATE INDEX ON osm_landusages_gen1(area);
CREATE INDEX ON brick_waterways_gen1(type);
--CREATE INDEX ON osm_transport_areas(area);

-- landusage, water

CREATE OR REPLACE VIEW brick_landusages_gen1 AS SELECT * FROM osm_landusages_gen1 ORDER BY area DESC NULLS LAST, osm_id;

CREATE OR REPLACE VIEW brick_landusages_gen0 AS SELECT * FROM osm_landusages_gen0 ORDER BY area DESC NULLS LAST, osm_id;

CREATE OR REPLACE VIEW brick_landusage_areas AS SELECT * FROM osm_landusage_areas ORDER BY area DESC NULLS LAST, osm_id;

CREATE OR REPLACE VIEW brick_landusage_ways AS SELECT * FROM osm_landusage_ways;

CREATE OR REPLACE VIEW brick_waterareas AS SELECT * FROM osm_waterareas;
CREATE OR REPLACE VIEW brick_waterareas_gen0 AS SELECT * FROM osm_waterareas_gen0;
CREATE OR REPLACE VIEW brick_waterareas_gen1 AS SELECT * FROM osm_waterareas_gen1;

CREATE OR REPLACE VIEW brick_waterways AS SELECT * FROM osm_waterways;
CREATE OR REPLACE VIEW brick_waterways_gen0 AS SELECT * FROM osm_waterways_gen0;
CREATE OR REPLACE VIEW brick_waterways_gen1 AS SELECT * FROM osm_waterways_gen1 WHERE type='river';


CREATE OR REPLACE VIEW brick_transport_areas AS SELECT * FROM osm_transport_areas;



COMMIT;
