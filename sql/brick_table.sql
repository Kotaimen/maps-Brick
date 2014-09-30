BEGIN;

CREATE SCHEMA IF NOT EXISTS "brick";

SET search_path TO brick, public;


-- import functions
DROP FUNCTION IF EXISTS road_type(class TEXT, type TEXT) CASCADE;
CREATE FUNCTION road_type(class TEXT, type TEXT) RETURNS text AS $$
DECLARE
	road_type text;
BEGIN
    CASE
        WHEN class = 'highway' AND type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link') THEN road_type := 'motorway';
        WHEN class = 'highway' AND type IN ('primary', 'primary_link') THEN road_type := 'primary';
        WHEN class = 'highway' AND type IN ('secondary', 'secondary_link', 'tertiary', 'tertiary_link') THEN road_type := 'secondary';
        WHEN class = 'highway' AND type IN ('residential', 'unclassified', 'road', 'minor') THEN road_type := 'minor';
        WHEN class = 'highway' AND type IN ('path', 'track', 'living_street', 'service') THEN road_type := 'path';
        WHEN class = 'highway' AND type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN road_type := 'pedestrian';
        WHEN class = 'highway' AND type IN ('construction', 'proposed') THEN road_type := 'proposed';
        WHEN class = 'railway' AND type = 'rail' THEN road_type := 'rail';
        WHEN class = 'railway' AND type IN ('subway', 'light_rail') THEN road_type := 'subway';
        WHEN class = 'railway' AND type IN ('monorail', 'tram', 'narrow_gauage', 'disused', 'preserved', 'funicular') THEN road_type := 'monorail';
        WHEN class = 'railway' THEN road_type := 'monorail';
        ELSE road_type := 'path';
    END CASE;
	RETURN road_type;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS road_rank(class TEXT, type TEXT) CASCADE;
CREATE FUNCTION road_rank(class TEXT, type TEXT) RETURNS smallint AS $$
DECLARE
	road_rank smallint;
BEGIN
    CASE
        WHEN type = 'motorway' THEN road_rank := 0;
        WHEN type = 'trunk' THEN road_rank := 20;
        WHEN class = 'railway' THEN road_rank := 30;
        WHEN type = 'primary' THEN road_rank := 40;
        WHEN type = 'secondary' THEN road_rank := 50;
        WHEN type = 'tertiary' THEN road_rank := 60;
        
        WHEN type IN ('residential', 'unclassified', 'road', 'minor') THEN road_rank := 70;
        WHEN type IN ('path', 'track', 'living_street', 'service') THEN road_rank := 80;
        WHEN type IN ('footway', 'bridleway', 'cycleway', 'pedestrian', 'steps') THEN road_rank := 90;
        WHEN type IN ('construction', 'proposed') THEN road_rank := 100;

        WHEN type = 'motorway_link' THEN road_rank := 71;
        WHEN type = 'trunk_link' THEN road_rank := 72;
        WHEN type = 'primary_link' THEN road_rank := 73;
        WHEN type = 'secondary_link' THEN road_rank := 74;
        WHEN type = 'tertiary_link' THEN road_rank := 75;

        ELSE road_rank := 255;
    END CASE;
	RETURN road_rank;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS landuse_maki(class TEXT, type TEXT) CASCADE;
CREATE FUNCTION landuse_maki(class TEXT, type TEXT) RETURNS text AS $$
DECLARE
	maki text;
BEGIN
    CASE
        WHEN type IN ( 'hospital', 'doctors', 'clinic', 'nursery', 'dentist') THEN maki := 'hospital';
        WHEN type IN ('university','college') THEN maki := 'college';
        WHEN type = 'museum' THEN maki := 'museum';
        WHEN type IN ('arts_centre', 'gallery') THEN maki := 'art-gallery';
        WHEN type = 'library' THEN maki := 'library';
        WHEN type = 'theatre' THEN maki := 'theatre';
        WHEN type = 'cinema' THEN maki := 'cinema';
        WHEN type = 'school' THEN maki := 'school';
        WHEN type = 'post_office' THEN maki := 'post';
        WHEN type IN ('townhall','public_building', 'courthouse') THEN maki := 'town-hall';
        WHEN type IN ('prison', 'police') THEN maki := 'police';
        WHEN type IN ('hotel', 'motel') THEN maki := 'town';
        WHEN type = 'fire_station' THEN maki := 'fire-station';
        WHEN type = 'zoo' THEN maki := 'zoo';
        WHEN type IN ('stadium', 'sports_centre') THEN maki := 'soccer';
        WHEN type = 'cemetery' THEN maki := 'cemetery';
        WHEN type = 'industrial' THEN maki := 'industrial';
        WHEN type = 'landfill' THEN maki := 'waste-basket';
        WHEN type IN ('retail', 'commercial') THEN maki := 'grocery';
        WHEN type = 'playground'  THEN maki := 'playground';
        WHEN type IN ('recreation_ground', 'pitch') THEN maki := 'pitch';
        WHEN type IN ('golf_range', 'golf_course', 'miniature_golf') THEN maki := 'golf';
        WHEN type IN ('forest', 'meadow', 'grass', 'grassland', 'wood', 'wetland', 'marsh', 'scrub', 'heath', 'park') THEN maki := 'park2';
        WHEN type IN ('garden', 'village_green', 'greenspace')  THEN maki := 'garden';
        WHEN type IN ('railway', 'railroad') THEN maki := 'rail';
        WHEN type IN ('aerodrome', 'airport') THEN maki := 'airport';
        WHEN type = 'airfield' THEN maki := 'airfield';
        WHEN type = 'marina' THEN maki := 'harbor';
        WHEN type IN ('nature_reserve', 'conservation', 'national_park') THEN maki := 'park';
        WHEN type = 'pharmacy' THEN maki := 'pharmacy';
        WHEN type = 'bank' THEN maki := 'bank';
        WHEN type = 'bar' THEN maki := 'bar';
        WHEN type = 'cafe' THEN maki := 'cafe';
        WHEN type = 'parking' THEN maki := 'parking';
        ELSE maki := 'square';
    END CASE;
	RETURN maki;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS place_rank(type TEXT) CASCADE;
CREATE FUNCTION place_rank(type TEXT) RETURNS smallint AS $$
DECLARE
	place_rank smallint;
BEGIN
	CASE WHEN type = 'country' THEN place_rank := 1;
	     WHEN type = 'region' THEN place_rank := 2;
	     WHEN type = 'state' THEN place_rank := 3;
	     WHEN type = 'city' THEN place_rank := 4;
	     WHEN type = 'town' THEN place_rank := 5;
	     WHEN type = 'suburb' THEN place_rank := 6;
	     WHEN type = 'village' THEN place_rank := 7;
	     WHEN type = 'hamlet' THEN place_rank := 8;
	     WHEN type = 'locality' THEN place_rank := 9;
	     ELSE place_rank := 255;
	END CASE;
	RETURN place_rank;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS abbreviate_road_name(class TEXT, type TEXT, name TEXT) CASCADE;
CREATE FUNCTION abbreviate_road_name(class TEXT, type TEXT, name TEXT) RETURNS text AS $$
DECLARE
	abbr text;
BEGIN
	CASE
	    WHEN name ~* '\mavenue$'::text THEN abbr := regexp_replace("name", '\m(ave)nue$'::text, '\1'::text, 'i'::text);
	    WHEN name ~* '\mboulevard$'::text THEN abbr := regexp_replace("name", '\m(b)oulevard$'::text, '\1lvd'::text, 'i'::text);
	    WHEN name ~* '\mexpressway$'::text THEN abbr := regexp_replace("name", '\m(E)xpressway$'::text, '\1xpwy'::text, 'i'::text);
	    WHEN name ~* '\mhighway$'::text THEN abbr := regexp_replace("name", '\m(h)ighway$'::text, '\1wy'::text, 'i'::text);
	    WHEN name ~* '\mparkway$'::text THEN abbr := regexp_replace("name", '\m(p)arkway$'::text, '\1kwy'::text, 'i'::text);
	    WHEN name ~* '\mcourt$'::text THEN abbr := regexp_replace("name", '\m(c)ourt$'::text, '\1t'::text, 'i'::text);
	    WHEN name ~* '\mdrive$'::text THEN abbr := regexp_replace("name", '\m(dr)ive$'::text, '\1'::text, 'i'::text);
	    WHEN name ~* '\mplace$'::text THEN abbr := regexp_replace("name", '\m(pl)ace$'::text, '\1'::text, 'i'::text);
	    WHEN name ~* '\mlane$'::text THEN abbr := regexp_replace("name", '\m(l)ane$'::text, '\1n'::text, 'i'::text);
	    WHEN name ~* '\mroad$'::text THEN abbr := regexp_replace("name", '\m(r)oad$'::text, '\1d'::text, 'i'::text);
	    WHEN name ~* '\mstreet$'::text THEN abbr := regexp_replace("name", '\m(st)reet$'::text, '\1'::text, 'i'::text);
	    WHEN name ~* '\mtrail$'::text THEN abbr := regexp_replace("name", '\m(tr)ail$'::text, '\1'::text, 'i'::text);
	    WHEN name ~* '\mway$'::text THEN abbr := regexp_replace("name", '\m(w)ay$'::text, '\1y'::text, 'i'::text);
	    ELSE abbr := name;
	END CASE;
	RETURN abbr;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS normalize_shield_name(class TEXT, type TEXT, ref TEXT) CASCADE;
CREATE FUNCTION normalize_shield_name(class TEXT, type TEXT, ref TEXT) RETURNS text AS $$
DECLARE
	normalized text;
BEGIN
    CASE
        WHEN ref ~ '^I ?\d+' THEN normalized := regexp_replace(ref, '^I ?(\d+).*', 'I \1');
        WHEN ref ~ '^US ?\d+' THEN normalized := regexp_replace(ref, '^US ?(\d+).*', 'US \1');
        WHEN ref ~ '^[[:alpha:]]+ ?\d+' THEN normalized := regexp_replace(ref, '^([[:alpha:]]+) ?(\d+).*', '\1 \2');
        WHEN ref ~ '^[[:alpha:]]+-\d+' THEN normalized := regexp_replace(ref, '^([[:alpha:]]+)-(\d+).*', '\1 \2');
        ELSE normalized := ref;
    END CASE;
	RETURN normalized;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS road_direction(geom Geometry) CASCADE;
CREATE FUNCTION road_direction(geom Geometry) RETURNS smallint AS $$
DECLARE
	dir smallint;
BEGIN
    CASE
        WHEN sin(pi() / 2 - st_azimuth(st_startpoint(geom), st_endpoint(geom))) > 0 THEN dir := 1;
        ELSE dir := (-1);
    END CASE;
	RETURN dir;
END;
$$ LANGUAGE plpgsql;


-- roads
CREATE INDEX ON public.osm_roads(type);
CREATE INDEX ON public.osm_roads(name) WHERE name IS NOT NULL AND name != '';
CREATE INDEX ON public.osm_roads(class, type, ref) WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'));

DROP TABLE IF EXISTS public.osm_roads_gen0 CASCADE;
CREATE TABLE public.osm_roads_gen0 AS
	SELECT id, osm_id, class, type, name, "name:en", tunnel, bridge, oneway, ref, layer, ST_Simplify(geometry, 10)::Geometry('LineString', 3857) AS geometry FROM osm_roads WHERE type IN ('motorway', 'motorway_link', 'trunk', 'trunk_link', 'primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'unclassified', 'rail');
SELECT populate_geometry_columns('public.osm_roads_gen0'::regclass, true);
ALTER TABLE public.osm_roads_gen0 ADD PRIMARY KEY (id);
CREATE INDEX ON public.osm_roads_gen0 USING gist(geometry);
CREATE INDEX ON public.osm_roads_gen0(type);
CREATE INDEX ON public.osm_roads_gen0(class, type, name, "name:en") WHERE name IS NOT NULL AND name != '';
CREATE INDEX ON public.osm_roads_gen0(class, type, ref) WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'));

DROP TABLE IF EXISTS public.osm_roads_gen1 CASCADE;
CREATE TABLE public.osm_roads_gen1 AS
	SELECT id, osm_id, class, type, name, "name:en", tunnel, bridge, oneway, ref, layer, ST_Simplify(geometry, 150)::Geometry('LineString', 3857) AS geometry FROM osm_roads WHERE type IN ('motorway', 'trunk', 'primary');
SELECT populate_geometry_columns('public.osm_roads_gen1'::regclass, true);
ALTER TABLE public.osm_roads_gen1 ADD PRIMARY KEY (id);
CREATE INDEX ON public.osm_roads_gen1 USING gist(geometry);
CREATE INDEX ON public.osm_roads_gen1(type);
CREATE INDEX ON public.osm_roads_gen1(class, type, name, "name:en") WHERE name IS NOT NULL AND name != '';
CREATE INDEX ON public.osm_roads_gen1(class, type, ref) WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'));

-- landuse areas
CREATE INDEX ON public.osm_landuse_areas(type);
CREATE INDEX ON public.osm_landuse_areas(area);
CREATE INDEX ON public.osm_landuse_areas USING gist(ST_PointOnSurface(ST_Multi(geometry))) WHERE ST_IsValid(geometry) AND name IS NOT NULL AND name != '';

DROP TABLE IF EXISTS public.osm_landuse_areas_gen0 CASCADE;
CREATE TABLE public.osm_landuse_areas_gen0 AS
	SELECT id, osm_id, class, type, name, "name:en", area, ST_Multi(ST_Simplify(geometry, 10))::Geometry('MultiPolygon', 3857) AS geometry FROM osm_landuse_areas WHERE ST_Area(geometry) > 5000.0;
SELECT populate_geometry_columns('public.osm_landuse_areas_gen0'::regclass, true);
ALTER TABLE public.osm_landuse_areas_gen0 ADD PRIMARY KEY (id);
CREATE INDEX ON public.osm_landuse_areas_gen0 USING gist(geometry);
CREATE INDEX ON public.osm_landuse_areas_gen0(type);
CREATE INDEX ON public.osm_landuse_areas_gen0(area);
CREATE INDEX ON public.osm_landuse_areas_gen0 USING gist(ST_PointOnSurface(ST_Multi(geometry))) WHERE ST_IsValid(geometry) AND name IS NOT NULL AND name != '';

DROP TABLE IF EXISTS public.osm_landuse_areas_gen1 CASCADE;
CREATE TABLE public.osm_landuse_areas_gen1 AS
	SELECT id, osm_id, class, type, name, "name:en", area, ST_Multi(ST_Simplify(geometry, 150))::Geometry('MultiPolygon', 3857) AS geometry FROM osm_landuse_areas WHERE ST_Area(geometry) > 500000.0;
SELECT populate_geometry_columns('public.osm_landuse_areas_gen1'::regclass, true);
ALTER TABLE public.osm_landuse_areas_gen1 ADD PRIMARY KEY (id);
CREATE INDEX ON public.osm_landuse_areas_gen1 USING gist(geometry);
CREATE INDEX ON public.osm_landuse_areas_gen1(type);
CREATE INDEX ON public.osm_landuse_areas_gen1(area);
CREATE INDEX ON public.osm_landuse_areas_gen1 USING gist(ST_PointOnSurface(ST_Multi(geometry))) WHERE ST_IsValid(geometry) AND name IS NOT NULL AND name != '';

-- waterareas
CREATE INDEX ON public.osm_waterareas(area);

DROP TABLE IF EXISTS public.osm_waterareas_gen0 CASCADE;
CREATE TABLE public.osm_waterareas_gen0 AS
	SELECT id, osm_id, class, type, area, ST_multi(geometry)::Geometry('MultiPolygon', 3857) AS geometry 
	FROM osm_waterareas WHERE area > 50000.0;
ALTER TABLE public.osm_waterareas_gen0 ADD PRIMARY KEY (id);
CREATE INDEX ON public.osm_waterareas_gen0 USING gist(geometry);
	
DROP TABLE IF EXISTS public.osm_waterareas_gen1 CASCADE;
CREATE TABLE public.osm_waterareas_gen1 AS
	SELECT id, osm_id, class, type, area, ST_multi(geometry)::Geometry('MultiPolygon', 3857) AS geometry 
	FROM osm_waterareas WHERE area > 500000.0;
ALTER TABLE public.osm_waterareas_gen1 ADD PRIMARY KEY (id);
CREATE INDEX ON public.osm_waterareas_gen1 USING gist(geometry);

-- lable roads
-- class, type, name, name_length, name:en, name:en_length, is_tunnel, is_bridge, direction, geometry
DROP TABLE IF EXISTS label_roads CASCADE;
CREATE TABLE label_roads AS
    SELECT  class, type, name, 
        	length(name) AS name_length,
			"name:en",
			length("name:en") AS "name:en_length", 
            tunnel AS is_tunnel, 
            bridge AS is_bridge, 
            road_direction(geometry) AS direction,
            st_segmentize(geometry, 1000) AS geometry
    FROM (
         SELECT class, 
         		road_type(class, type) AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name,
				"name:en",
                tunnel,
                bridge,
                road_rank(class, type) AS rank,
                geometry
        FROM osm_roads
		WHERE name IS NOT NULL AND name != ''
        UNION ALL
        SELECT  'ferry' AS class, 
                'ferry' AS type, 
                name,
				'' AS "name:en",
                0 AS tunnel,
                0 AS bridge,
                100 as rank,
                geometry
        FROM osm_landuse_ways
        WHERE type='ferry'
    ) AS foo
    ORDER BY rank, name_length, is_bridge DESC, is_tunnel DESC, name;

SELECT POPULATE_GEOMETRY_COLUMNS('label_roads'::regclass, true);
CREATE INDEX ON label_roads USING gist(geometry);
CREATE INDEX ON label_roads(type);

DROP TABLE IF EXISTS label_roads_gen0 CASCADE;
CREATE TABLE label_roads_gen0 AS
    SELECT  class, 
			type, 
			name, 
			length(name) AS name_length,
			"name:en",
			length("name:en") AS "name:en_length",
			0 AS is_tunnel,
			0 AS is_bridge,
            road_direction(geometry) AS direction,
            road_rank(class, type) AS rank,
            geometry::Geometry('MultiLineString', 3857)
    FROM (
         SELECT	class, 
		        road_type(class, type) AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name, 
				"name:en",
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
        FROM osm_roads_gen0
		WHERE name IS NOT NULL AND name != ''
		GROUP BY class, type, name, "name:en"
    ) AS foo
    ORDER BY rank, name_length, name;
SELECT POPULATE_GEOMETRY_COLUMNS('label_roads_gen0'::regclass, true);
CREATE INDEX ON label_roads_gen0 USING gist(geometry);
CREATE INDEX ON label_roads_gen0(type);

DROP TABLE IF EXISTS label_roads_gen1 CASCADE;
CREATE TABLE label_roads_gen1 AS
    SELECT  class, 
			type, 
			name, 
			length(name) AS name_length,
			"name:en",
			length("name:en") AS "name:en_length",
			0 AS is_tunnel,
			0 AS is_bridge,
            road_direction(geometry) AS direction,
            road_rank(class, type) AS rank,
            geometry::Geometry('MultiLineString', 3857)
    FROM (
         SELECT	class, 
		        road_type(class, type) AS type,
                regexp_replace(name, '(.*)\(.*\)', '\1') AS name, 
				"name:en",
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
        FROM osm_roads_gen1
		WHERE name IS NOT NULL AND name != ''
		GROUP BY class, type, name, "name:en"
    ) AS foo
    ORDER BY rank, name_length, name;
SELECT POPULATE_GEOMETRY_COLUMNS('label_roads_gen1'::regclass, true);
CREATE INDEX ON label_roads_gen1 USING gist(geometry);
CREATE INDEX ON label_roads_gen1(type);


-- road shields generations
DROP TABLE IF EXISTS label_shields CASCADE;
CREATE TABLE label_shields AS
    SELECT	class, 
			type,
			ref,
			length(ref) AS ref_length,
		    road_rank(class, type) AS rank,
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            normalize_shield_name(class, type, ref) AS ref,
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
			    FROM osm_roads
			    WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'))
				GROUP BY class, type, ref
	) AS foo
    ORDER BY rank, ref_length, ref;
SELECT POPULATE_GEOMETRY_COLUMNS('label_shields'::regclass, true);
CREATE INDEX ON label_shields USING gist(geometry);
CREATE INDEX ON label_shields(type);


DROP TABLE IF EXISTS label_shields_gen0 CASCADE;
CREATE TABLE label_shields_gen0 AS
    SELECT	class, 
			type,
			ref,
			length(ref) AS ref_length,
		    road_rank(class, type) AS rank,
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            normalize_shield_name(class, type, ref) AS ref,
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
			    FROM osm_roads_gen0
			    WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'))
				GROUP BY class, type, ref
	) AS foo
    ORDER BY rank, ref_length, ref;
SELECT POPULATE_GEOMETRY_COLUMNS('label_shields_gen0'::regclass, true);
CREATE INDEX ON label_shields_gen0 USING gist(geometry);
CREATE INDEX ON label_shields_gen0(type);


DROP TABLE IF EXISTS label_shields_gen1 CASCADE;
CREATE TABLE label_shields_gen1 AS
    SELECT	class, 
			type,
			ref,
			length(ref) AS ref_length,
		    road_rank(class, type) AS rank,
			geometry::Geometry('MultiLineString', 3857)
	FROM (
		SELECT	class,
				type,
	            normalize_shield_name(class, type, ref) AS ref,
	            ST_Multi((ST_Dump(ST_Multi(ST_LineMerge(ST_CollectionExtract(ST_Collect(geometry), 2))))).geom) AS geometry
			    FROM osm_roads_gen1
			    WHERE ref IS NOT NULL AND ref != '' AND (type IN ('motorway', 'trunk', 'primary', 'secondary', 'tertiary'))
				GROUP BY class, type, ref
	) AS foo
    ORDER BY rank, ref_length, ref;
SELECT POPULATE_GEOMETRY_COLUMNS('label_shields_gen1'::regclass, true);
CREATE INDEX ON label_shields_gen1 USING gist(geometry);
CREATE INDEX ON label_shields_gen1(type);


COMMIT;