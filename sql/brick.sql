BEGIN;

CREATE SCHEMA IF NOT EXISTS "brick";

SET search_path TO brick, public;


-- landuse

DROP VIEW IF EXISTS landuse_areas_gen1;
DROP VIEW IF EXISTS landuse_areas_gen0;
DROP VIEW IF EXISTS landuse_areas;
CREATE OR REPLACE VIEW landuse_areas AS SELECT osm_id AS gid, class, type, area, geometry FROM osm_landusage_areas ORDER BY area DESC NULLS LAST, gid;
CREATE OR REPLACE VIEW landuse_areas_gen0 AS SELECT osm_id AS gid, class, type, area, geometry FROM osm_landusages_gen1 ORDER BY area DESC NULLS LAST, gid;
CREATE OR REPLACE VIEW landuse_areas_gen1 AS SELECT osm_id AS gid, class, type, area, geometry FROM osm_landusages_gen0 ORDER BY area DESC NULLS LAST, gid;

DROP VIEW IF EXISTS landuse_ways;
CREATE OR REPLACE VIEW landuse_ways AS SELECT osm_id AS gid, class, type, geometry FROM osm_landusage_ways;

-- water
DROP VIEW IF EXISTS waterareas_gen1;
DROP VIEW IF EXISTS waterareas_gen0;
DROP VIEW IF EXISTS waterareas;
CREATE OR REPLACE VIEW waterareas AS (
    SELECT osm_id AS gid, 'natural'::text AS class, type, area, geometry
        FROM osm_waterareas
    UNION ALL 
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_landusage_areas WHERE type IN ('water', 'pond', 'salt_pond', 'water_reservoir', 'reservoir')
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );
CREATE OR REPLACE VIEW waterareas_gen0 AS (
    SELECT osm_id AS gid, 'natural'::text AS class, type, area, geometry
        FROM osm_waterareas_gen1
    UNION ALL 
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_landusages_gen1 WHERE type IN ('water', 'pond', 'salt_pond', 'water_reservoir', 'reservoir')
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );
CREATE OR REPLACE VIEW waterareas_gen1 AS (
    SELECT osm_id AS gid, 'natural'::text AS class, type, area, geometry
        FROM osm_waterareas_gen0
    UNION ALL 
    SELECT osm_id AS gid, class, type, area, geometry
        FROM osm_landusages_gen0 WHERE type IN ('water', 'pond', 'salt_pond', 'water_reservoir', 'reservoir')
    UNION ALL
    SELECT id AS gid, 'natural'::text AS class, 'sea'::text AS type, 0 AS area, geometry
        FROM thirdparty.water_polygons
    );

DROP VIEW IF EXISTS waterways_gen1;
DROP VIEW IF EXISTS waterways_gen0;
DROP VIEW IF EXISTS waterways;
CREATE OR REPLACE VIEW waterways AS SELECT osm_id AS gid, 'natural'::text AS class, type, geometry FROM osm_waterways;
CREATE OR REPLACE VIEW waterways_gen0 AS SELECT osm_id AS gid, 'natural'::text AS class, type, geometry FROM osm_waterways_gen1 WHERE type='river';
CREATE OR REPLACE VIEW waterways_gen1 AS SELECT osm_id AS gid, 'natural'::text AS class, type, geometry FROM osm_waterways_gen0;

-- transport
DROP VIEW IF EXISTS transport_areas;
DROP VIEW IF EXISTS transport_points;
DROP VIEW IF EXISTS aeroways;
DROP VIEW IF EXISTS barrierways;
CREATE OR REPLACE VIEW transport_areas AS SELECT osm_id AS gid, 'transport'::text AS class, type, geometry FROM osm_transport_areas;
CREATE OR REPLACE VIEW transport_points AS SELECT osm_id AS gid, 'transport'::text AS class, type, geometry FROM osm_transport_points;
CREATE OR REPLACE VIEW aeroways AS SELECT osm_id AS gid, 'transport'::text AS class, type, geometry FROM osm_aeroways;
CREATE OR REPLACE VIEW barrierways AS SELECT osm_id AS gid, 'transport'::text AS class, type, geometry FROM osm_barrierways;

-- buildings
DROP VIEW IF EXISTS buildings;
CREATE OR REPLACE VIEW buildings AS SELECT osm_id AS gid, 'building'::text AS class, type, geometry FROM osm_buildings ORDER BY ST_YMin(ST_Envelope(geometry)) DESC;

-- administration
DROP VIEW IF EXISTS admins;
CREATE OR REPLACE VIEW admins AS SELECT osm_id AS gid, 'admin'::text AS class, type, geometry FROM osm_admin WHERE admin_level<=4;


-- roads
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



DROP VIEW IF EXISTS roads_gen1;
DROP VIEW IF EXISTS roads_gen0;
DROP VIEW IF EXISTS roads;
CREATE OR REPLACE VIEW roads AS 
    SELECT 
        osm_id AS gid,
        class,
        road_type(class, type) AS type,
        tunnel AS is_tunnel,
        bridge AS is_bridge,
        oneway AS is_oneway,
        CASE
            WHEN type ~~ '%_link' THEN 1
            ELSE 0
        END::smallint AS is_link,
        CASE
            WHEN layer IS NULL THEN 0
            ELSE layer
        END::smallint AS layer,
        road_rank(class, type) AS rank,
        geometry
    FROM osm_roads
      ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
CREATE OR REPLACE VIEW roads_gen0 AS 
    SELECT 
        osm_id AS gid,
        class,
        road_type(class, type) AS type,
        tunnel AS is_tunnel,
        bridge AS is_bridge,
        oneway AS is_oneway,
        CASE
            WHEN type ~~ '%_link' THEN 1
            ELSE 0
        END::smallint AS is_link,
        CASE
            WHEN layer IS NULL THEN 0
            ELSE layer
        END::smallint AS layer,
        road_rank(class, type) AS rank,
        geometry
    FROM osm_roads_gen1
    ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
CREATE OR REPLACE VIEW roads_gen1 AS 
    SELECT 
        osm_id AS gid,
        class,
        road_type(class, type) AS type,
        tunnel AS is_tunnel,
        bridge AS is_bridge,
        oneway AS is_oneway,
        CASE
            WHEN type ~~ '%_link' THEN 1
            ELSE 0
        END::smallint AS is_link,
        CASE
            WHEN layer IS NULL THEN 0
            ELSE layer
        END::smallint AS layer,
        road_rank(class, type) AS rank,
        geometry
    FROM osm_roads_gen0
    ORDER BY layer, is_tunnel DESC NULLS LAST, is_bridge NULLS FIRST, rank DESC, gid;
        

-- labels
DROP VIEW IF EXISTS label_places;
CREATE OR REPLACE VIEW label_places AS
    SELECT 
        osm_id AS gid,
        name,
        type,
        place_rank(type) AS rank,
        population,
        geometry
    FROM osm_places
    ORDER BY rank, population DESC NULLS LAST, osm_id;


DROP VIEW IF EXISTS label_landuse_areas;
CREATE OR REPLACE VIEW label_landuse_areas AS
    SELECT osm_id AS gid, class, type, name, area,
    landuse_maki(class, type) AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landusage_area_labels
    WHERE class != 'place'
    ORDER BY area DESC, gid;


DROP VIEW IF EXISTS label_landuse_areas_gen0;
CREATE OR REPLACE VIEW label_landuse_areas_gen0 AS
    SELECT osm_id AS gid, class, type, name, area,
    landuse_maki(class, type) AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landusage_area_labels_gen1
    WHERE class != 'place'
    ORDER BY area DESC, gid;


DROP VIEW IF EXISTS label_landuse_areas_gen1;
CREATE OR REPLACE VIEW label_landuse_areas_gen1 AS
    SELECT osm_id AS gid, class, type, name, area,
    landuse_maki(class, type) AS maki,
    ST_PointOnSurface(ST_Multi(geometry)) AS geometry
    FROM osm_landusage_area_labels_gen0
    WHERE class != 'place'
    ORDER BY area DESC, gid;
    



COMMIT;