BEGIN;

DROP VIEW IF EXISTS brick_road_label;

CREATE VIEW brick_road_label AS

	SELECT 	"name", 
		brick_kind AS kind,
		CASE
		    WHEN highway ~~ '%_link'::text THEN 1
		    ELSE 0
		END AS is_link,
		CASE
                    WHEN tunnel = ANY (ARRAY['yes'::text, 'true'::text]) THEN 1
                    ELSE 0
                END AS is_tunnel,
                CASE
		    WHEN bridge = ANY (ARRAY['yes'::text, 'true'::text]) THEN 1
	            ELSE 0
		END AS is_bridge,
		CASE
		    WHEN "name" ~* '\mavenue$'::text THEN regexp_replace("name", '\m(ave)nue$'::text, '\1'::text, 'i'::text)
		    WHEN "name" ~* '\mboulevard$'::text THEN regexp_replace("name", '\m(b)oulevard$'::text, '\1lvd'::text, 'i'::text)
		    WHEN "name" ~* '\mexpressway$'::text THEN regexp_replace("name", '\m(E)xpressway$'::text, '\1xpwy'::text, 'i'::text)
		    WHEN "name" ~* '\mhighway$'::text THEN regexp_replace("name", '\m(h)ighway$'::text, '\1wy'::text, 'i'::text)
		    WHEN "name" ~* '\mparkway$'::text THEN regexp_replace("name", '\m(p)arkway$'::text, '\1kwy'::text, 'i'::text)
		    WHEN "name" ~* '\mcourt$'::text THEN regexp_replace("name", '\m(c)ourt$'::text, '\1t'::text, 'i'::text)
		    WHEN "name" ~* '\mdrive$'::text THEN regexp_replace("name", '\m(dr)ive$'::text, '\1'::text, 'i'::text)
		    WHEN "name" ~* '\mplace$'::text THEN regexp_replace("name", '\m(pl)ace$'::text, '\1'::text, 'i'::text)
		    WHEN "name" ~* '\mlane$'::text THEN regexp_replace("name", '\m(l)ane$'::text, '\1n'::text, 'i'::text)
		    WHEN "name" ~* '\mroad$'::text THEN regexp_replace("name", '\m(r)oad$'::text, '\1d'::text, 'i'::text)
		    WHEN "name" ~* '\mstreet$'::text THEN regexp_replace("name", '\m(st)reet$'::text, '\1'::text, 'i'::text)
		    WHEN "name" ~* '\mtrail$'::text THEN regexp_replace("name", '\m(tr)ail$'::text, '\1'::text, 'i'::text)
		    WHEN "name" ~* '\mway$'::text THEN regexp_replace("name", '\m(w)ay$'::text, '\1y'::text, 'i'::text)
		    ELSE "name"
		END AS name_abbr,
		CASE
		    WHEN z10 IS NOT NULL THEN 10
		    WHEN z11 IS NOT NULL THEN 11
		    WHEN z12 IS NOT NULL THEN 12
		    WHEN z13 IS NOT NULL THEN 13
		    WHEN z14 IS NOT NULL THEN 14
		    WHEN z15 IS NOT NULL THEN 15
		    ELSE 99
		END AS min_zoom,
		priority,
		way
	FROM brick_road_rail
	WHERE brick_road_rail.highway is not NULL
	ORDER BY priority, st_length(way) DESC, osm_id DESC;

END; 