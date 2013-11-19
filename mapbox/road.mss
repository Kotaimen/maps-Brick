
//// road overview
#road_gen0[zoom>=5][zoom<=8] {
  line-cap: round;
  line-join: round;
  line-clip: false;

  [type='motorway'], [type='trunk'] {
    line-color: @motorway-line;
  }
  [type='primary'] {
    line-color: @primary-line;
  }
  [type='secondary'] {
    line-color: @secondary-line;
  }

  [zoom=5] {
    [type='motorway'],[type='trunk'] { line-width: 0.5; }
    [type='primary'],[type='secondary'] { line-width: 0.1; }
  }
  [zoom=6] {
    [type='motorway'],[type='trunk'] { line-width: 0.6; }
    [type='primary'],[type='secondary'] { line-width: 0.2; }
  }
  [zoom=7] {
    [type='motorway'],[type='trunk'] { line-width: 0.8; }
    [type='primary'],[type='secondary'] { line-width: 0.3; }
  }
  [zoom=8] {
    [type='motorway'],[type='trunk'] { line-width: 1; }
    [type='primary'],[type='secondary'] { line-width: 0.4; }
  }
}

//// high level roads

#road_gen1[zoom>=9][zoom<=11][class='highway'] {
  [render='casing'] {
    line-cap: round;
    line-join: round;
  }
  [render='inline'] {
    line-join: round;
    line-cap: round;
  }
  line-width: 0;
  line-clip: false;

  [type='motorway'],[type='trunk'],
  [type='motoway_link'],[type='trunk_link'] {
  [render='casing'] { line-color: @motorway-casing; }
  [render='inline'] { line-color: @motorway-fill; }
    [zoom=9] {
      [render='casing'] { line-width: 3; }
      [render='inline'] { line-width: 1; }
    }
    [zoom>=10] {
      [render='casing'] { line-width: 4; }
      [render='inline'] { line-width: 2; }
    }
  }

  [type='primary'], [type='primary_link'] {
    [render='casing'] { line-color: @primary-casing; }
    [render='inline'][zoom<=10] { line-color: @primary-line; }
    [render='inline'][zoom>=11] { line-color: @primary-fill; }
    [zoom=9] {
      [render='inline'] { line-width: 0.75; }
    }
    [zoom=10] {
      [render='inline'] { line-width: 1; }
    }
    [zoom>=11] {
      [render='casing'] { line-width: 3; }
      [render='inline'] { line-width: 1; }
    }
  }

  [type='secondary'], [type='secondary_link'] {
  [render='inline'] { line-color: @primary-line; }
    [zoom=9] {
      [render='inline'] { line-width: 0.4; }
    }
    [zoom=10] {
      [render='inline'] { line-width: 0.6; }
    }
    [zoom>=11] {
      [render='inline'] { line-width: 0.8; }
    }
  }

  [type='tertiary'], [type='tertiary_link'] {
    [render='inline'] { line-color: @minor-line; }
    [zoom>=11] {
      [render='inline'] { line-width: 0.4; }
    }
  }
}

#road_gen1[zoom>=9][zoom<=11][class='railway'] {
  [render='inline'] {
    line-width: 0.5;
    line-color: @rail-line;
    line-dasharray: 1, 1;
  }
}

//// all road/rail links

// WARNING from Kotaimen: road style is *very* complex
// class: highway
// type:
//   motorway, trunk -> motorway
//   primary -> primary
//   secondary, tertiary -> secondary
//   residential, unclassfied, road, minor -> minor
//   path, track, service, footway, bridleway, cycleway, setps, predestrian,
//   living_street, raceway -> path
// every road link is rendered three times: outline=>casing=>inline
//   plus one time for one-way marker
//
// class: railway
// type:
//    rail -> default rail style
//    metro, light_rail -> dashed line
//    monorail, etc -> single line
// every rail link is rendered four times:
//   casing/casing fill=>inline/inline dash
//
// extra rules:
//   road bridges have slightly thicker casing
//   road links are slightly thinner
//   rail bridges have extra casing
//   tunnels are semi-transparent
//
// the link render order is decided in road.sql by explicit and implict
// orderering rank and does not necessary follow osm link layer,
//
// ps: unlike osm/mapbox we don’t render pedestrian links as dashed line
//     unlike google/bing we cares about road/rail render order

/// road style
#road_all[zoom>=12][class='highway'][render!='marker'] {

  // line render options
  line-clip: false;

  [render='casing'] {
    line-join: round;
    line-gamma: 1.5;
  }
  [render='inline'] {
    line-join: round;
    line-cap: round;
  }
  [render='outline'] {
    line-join: round;
    line-cap: round;
    line-gamma: 1.2;
  }

  // smooth link a bit so links look less jagged at higher zoom,
  // too much smooth cause road links don’t match
  // road labels, which don’t support line smooth yet
  [zoom=17][link=0]  { line-smooth: 0; }
  [zoom=17][link=1]  { line-smooth: 0.1; }
  [zoom>=18][link=0] { line-smooth: 0.05; }
  [zoom>=18][link=1] { line-smooth: 0.4; }


  // for tunnel links we have three solution
  // 1. dashed link casing
  // 2. semi transparent link
  // 3. transprent link fill but not casing,
  //    requries post processing in mason composer
  // here we are using 2
  [render='casing'] { [tunnel=1] { line-opacity: 0.5; } }
  [render='inline']  { [tunnel=1] { line-comp-op: soft-light; } }
  // [render='casing'] { [tunnel=1] { line-dasharray: @road-dash; } }
  // [render='inline'] { [tunnel=1] { line-comp-op: dst-out; line-opacity: 0.95; } }
  
  
  // line color defined by road type
  [type='motorway'],[type='trunk'] {
    [render='inline']  { line-color: @motorway-fill; }
    [render='casing']  { line-color: @motorway-casing; }
    [render='outline'] { line-color: @motorway-casing; }
  }

  [type='motorway_link'],[type='trunk_link'] {
    [render='inline']  { line-color: @motorway-link; }
    [render='casing']  { line-color: @motorway-casing; }
    [render='outline'] { line-color: @motorway-casing; }
  }

  [type='primary'],[type='primary_link']  {
    [render='inline']  { line-color: @primary-fill; }
    [render='casing']  { line-color: @primary-casing; }
    [render='outline'] { line-color: @primary-casing; }
  }

  [type='secondary'],[type='secondary_link'],
  [type='tertiary'], [type='tertiary_link'] {
    [render='inline']  { line-color: @secondary-fill; }
    [render='casing']  { line-color: @secondary-casing; }
    [render='outline'] { line-color: @secondary-casing; }
  }

  [type='residential'], [type='road'], [type='minor'],
  [type='unclassified'], {
    [zoom>=14][render='inline']  { line-color: @minor-fill; }
    [zoom<=13][render='inline']  { line-color: @minor-line; }
    [render='casing']  { line-color: @minor-casing; }
    [render='outline'] { line-color: @minor-casing; }
  }

  [type='path'], [type='track'], [type='footway'],
  [type='bridleway'], [type='cycleway'],
  [type='pedestrian'], [type='living_street'], [type='service'], {
    [zoom>=16][render='inline']  { line-color: @path-fill; }
    [zoom<=15][render='inline']  { line-color: @path-line; }
    [render='casing']  { line-color: @path-casing; }
    [render='outline'] { line-color: @path-casing; }
  }
  
  [type='construction'], [type='proposed'] {
    line-cap: butt;
    line-dasharray: @road-dash;
    [zoom>=16][render='inline']  { line-color: @path-fill; }
    [zoom<=15][render='inline']  { line-color: @path-line; }
    [render='casing']  { line-color: @path-casing; }
    [render='outline'] { line-color: @path-casing; }    
  }

}

/// road width, copied from osmbright and adjusted a bit

@rdz12_maj: 2.5; @rdz12_med: 1.2; @rdz12_min: 0.8;
@rdz13_maj: 3;   @rdz13_med: 1.5; @rdz13_min: 1;
@rdz14_maj: 4;   @rdz14_med: 2.5; @rdz14_min: 1.6;
@rdz15_maj: 6;   @rdz15_med: 4;   @rdz15_min: 2;
@rdz16_maj: 8;   @rdz16_med: 6;   @rdz16_min: 3;
@rdz17_maj: 12;  @rdz17_med: 8;   @rdz17_min: 6;
@rdz18_maj: 22;  @rdz18_med: 14;  @rdz18_min: 10;

#road_all[zoom>=12][class='highway'][render!='marker'] {
  // supress rendering for links we don’t mentioned here
  line-width: 0;


  // z=12 --------------------------------------------------

  [zoom=12] {
    [type='motorway'], [type='trunk'] {
      [render='inline'] { line-width: @rdz12_maj; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz12_maj + 2; }
        [bridge=1] { line-width: @rdz12_maj + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz12_maj + 2; }
      }
    }

    [type='motorway_link'], [type='trunk_link'] {
      [render='inline'] { line-width: @rdz12_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz12_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz12_maj / 2 + 1.5; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz12_maj / 2 + 1; }
      }
    }

    [type='primary'] {
      [render='inline']
        { line-width: @rdz12_med; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz12_med + 2; }
        [bridge=1] { line-width: @rdz12_med + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz12_med + 3; }
      }
    }
    [type='primary_link'] {
      [render='inline']
        { line-width: @rdz12_med / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz12_med / 2+ 1; }
        [bridge=1] { line-width: @rdz12_med / 2+ 1.5; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz12_med / 2 + 1; }
      }
    }

    [type='secondary'],[type='secondary_link'],
    [type='tertiary'], [type='tertiary_link'] {
      [render='inline']
        { line-width: @rdz12_min; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz12_min + 2; }
        [bridge=1] { line-width: @rdz12_min + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz12_min + 2; }
      }
    }

    [type='residential'], [type='road'], [type='minor'],
    [type='unclassified'], {
      [render='inline'] { line-width: 0.4; }
    }

//    [type='path'], [type='track'], [type='footway'],
//    [type='bridleway'], [type='cycleway'],
//    [type='pedestrian'], [type='living_street'], [type='service'], 
//    [type='construction'] {
//      [render='inline'] { line-width: 0.2; }
//    }
  }
  
  // z=13 --------------------------------------------------  

  [zoom=13] {
    [type='motorway'], [type='trunk'] {
      [render='inline'] { line-width: @rdz13_maj; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz13_maj + 2; }
        [bridge=1] { line-width: @rdz13_maj + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz13_maj + 2; }
      }
    }

    [type='motorway_link'], [type='trunk_link'] {
      [render='inline'] { line-width: @rdz13_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz13_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz13_maj / 2 + 1.5; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz13_maj / 2 + 1; }
      }
    }

    [type='primary'] {
      [render='inline']
        { line-width: @rdz13_med; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz13_med + 2; }
        [bridge=1] { line-width: @rdz13_med + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz13_med + 2; }
      }
    }
    [type='primary_link'] {
      [render='inline']
        { line-width: @rdz13_med / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz13_med / 2+ 1; }
        [bridge=1] { line-width: @rdz13_med / 2+ 1.5; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz13_med / 2 + 1; }
      }
    }

    [type='secondary'],[type='secondary_link'],
    [type='tertiary'], [type='tertiary_link'] {
      [render='inline']
        { line-width: @rdz13_min; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz13_min + 2; }
        [bridge=1] { line-width: @rdz13_min + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz13_min + 2; }
      }
    }

    [type='residential'], [type='road'], [type='minor'],
    [type='unclassified'], {
      [render='inline'] { line-width: 0.75; }
    }

    [type='path'], [type='track'], [type='footway'],
    [type='bridleway'], [type='cycleway'],
    [type='pedestrian'], [type='living_street'], [type='service'] {
      [render='inline'] { line-width: 0.4; }
    }
  }

  // z=14 --------------------------------------------------
  
  [zoom=14] {
    [type='motorway'], [type='trunk'] {
      [render='inline'] { line-width: @rdz14_maj; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz14_maj + 2; }
        [bridge=1] { line-width: @rdz14_maj + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz14_maj + 2; }
      }
    }

    [type='motorway_link'], [type='trunk_link'] {
      [render='inline'] { line-width: @rdz14_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz14_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz14_maj / 2 + 1.5; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz14_maj / 2 + 1; }
      }
    }

    [type='primary'] {
      [render='inline']
        { line-width: @rdz14_med; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz14_med + 2; }
        [bridge=1] { line-width: @rdz14_med + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz14_med + 2; }
      }
    }
    [type='primary_link'] {
      [render='inline']
        { line-width: @rdz14_med / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz14_med / 2+ 1; }
        [bridge=1] { line-width: @rdz14_med / 2+ 1.5; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz14_med / 2 + 1; }
      }
    }

    [type='secondary'],[type='secondary_link'],
    [type='tertiary'], [type='tertiary_link'] {
      [render='inline']
        { line-width: @rdz14_min; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz14_min + 2; }
        [bridge=1] { line-width: @rdz14_min + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz14_min + 2; }
      }
    }

    [type='residential'], [type='road'], [type='minor'],
    [type='unclassified'], {
      [render='inline']
        { line-width: @rdz14_min; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz14_min + 2; }
        [bridge=1] { line-width: @rdz14_min + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz14_min + 2; }
      }
    }

    [type='path'], [type='track'], [type='footway'],
    [type='bridleway'], [type='cycleway'],
    [type='pedestrian'], [type='living_street'], [type='service'], {
      [render='inline'] { line-width: 0.5; }
    }
  }

  // z=15 --------------------------------------------------

  [zoom=15] {
    [type='motorway'], [type='trunk'] {
      [render='inline'] { line-width: @rdz15_maj; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz15_maj + 2; }
        [bridge=1] { line-width: @rdz15_maj + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz15_maj + 2; }
      }
    }

    [type='motorway_link'], [type='trunk_link'] {
      [render='inline'] { line-width: @rdz15_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz15_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz15_maj / 2 + 1.5; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz15_maj / 2 + 1; }
      }
    }
    [type='primary'] {
      [render='inline'] { line-width: @rdz15_maj; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz15_maj + 2; }
        [bridge=1] { line-width: @rdz15_maj + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz15_maj + 2; }
      }
    }

    [type='primary_link'] {
      [render='inline'] { line-width: @rdz15_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz15_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz15_maj / 2 + 1.5; }
        [tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz15_maj / 2 + 1; }
      }
    }
    [type='secondary'],[type='secondary_link'],
    [type='tertiary'], [type='tertiary_link'] {
      [render='inline']
        { line-width: @rdz15_med; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz15_med + 2; }
        [bridge=1] { line-width: @rdz15_med + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz15_med + 2; }
      }
    }

    [type='residential'], [type='road'], [type='minor'],
      [type='unclassified'], {
      [render='inline']
        { line-width: @rdz15_min; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz15_min + 2; }
        [bridge=1] { line-width: @rdz15_min + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz15_min + 2; }
      }
    }

    [type='path'], [type='track'], [type='footway'],
    [type='bridleway'], [type='cycleway'],
    [type='pedestrian'], [type='living_street'], [type='service'],     
    [type='construction'], [type='proposed']  {
      [render='inline'] { line-width: 0.8; }
    }
  }
  
  // z=16 --------------------------------------------------  

  [zoom=16] {
    [type='motorway'], [type='trunk'] {
      [render='inline'] { line-width: @rdz16_maj * 1.2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz16_maj * 1.2 + 2; }
        [bridge=1] { line-width: @rdz16_maj * 1.2 + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz16_maj * 1.2 + 2; }
      }
    }

    [type='motorway_link'], [type='trunk_link'] {
      [render='inline'] { line-width: @rdz16_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz16_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz16_maj / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz16_maj / 2 + 1; }
      }
    }
    [type='primary'] {
      [render='inline'] { line-width: @rdz16_maj; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz16_maj + 2; }
        [bridge=1] { line-width: @rdz16_maj + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz16_maj + 2; }
      }
    }

    [type='primary_link'] {
      [render='inline'] { line-width: @rdz16_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz16_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz16_maj / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz16_maj / 2 + 1; }
      }
    }
    [type='secondary'],[type='secondary_link'],
     [type='tertiary'], [type='tertiary_link'] {
      [render='inline']
        { line-width: @rdz16_med; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz16_med + 2; }
        [bridge=1] { line-width: @rdz16_med + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz16_med + 2; }
      }
    }

    [type='residential'], [type='road'], [type='minor'],
      [type='unclassified'], {
      [render='inline']
        { line-width: @rdz16_min; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz16_min + 2; }
        [bridge=1] { line-width: @rdz16_min + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz16_min + 2; }
      }
    }

    [type='path'], [type='track'], [type='footway'],
    [type='bridleway'], [type='cycleway'],
    [type='pedestrian'], [type='living_street'], [type='service'],
    [type='construction'], [type='proposed'] {
      [render='inline']
        { line-width: @rdz16_min  / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz16_min / 2 + 1; }
        [bridge=1] { line-width: @rdz16_min / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz16_min / 2 + 1; }
      }
    }
  }

  // z=17 --------------------------------------------------
  
  [zoom=17] {
    [type='motorway'], [type='trunk'] {
      [render='inline'] { line-width: @rdz17_maj * 1.2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz17_maj * 1.2 + 3; }
        [bridge=1] { line-width: @rdz17_maj * 1.2 + 4; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz17_maj * 1.2 + 3; }
      }
    }

    [type='motorway_link'], [type='trunk_link'] {
      [render='inline'] { line-width: @rdz17_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz17_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz17_maj / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz17_maj / 2 + 1; }
      }
    }
    [type='primary'] {
      [render='inline'] { line-width: @rdz17_maj; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz17_maj + 2; }
        [bridge=1] { line-width: @rdz17_maj + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz17_maj + 2; }
      }
    }

    [type='primary_link'] {
      [render='inline'] { line-width: @rdz17_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz17_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz17_maj / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz17_maj / 2 + 1; }
      }
    }
    [type='secondary'],[type='secondary_link'],
    [type='tertiary'], [type='tertiary_link'] {
      [render='inline']
        { line-width: @rdz17_med; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz17_med + 2; }
        [bridge=1] { line-width: @rdz17_med + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz17_med + 2; }
      }
    }

    [type='residential'], [type='road'], [type='minor'],
      [type='unclassified'], {
      [render='inline']
        { line-width: @rdz17_min; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz17_min + 2; }
        [bridge=1] { line-width: @rdz17_min + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz17_min + 2; }
      }
    }

    [type='path'], [type='track'], [type='footway'],
    [type='bridleway'], [type='cycleway'],
    [type='pedestrian'], [type='living_street'], [type='service'],
    [type='construction'], [type='proposed'] {
      [render='inline']
        { line-width: @rdz17_min  / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz17_min / 2 + 1; }
        [bridge=1] { line-width: @rdz17_min / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz17_min / 2 + 1; }
      }
    }
  }
  // z>=18 --------------------------------------------------

  [zoom>=18] {
    [type='motorway'], [type='trunk'] {
      [render='inline'] { line-width: @rdz18_maj * 1.2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz18_maj * 1.2 + 3; }
        [bridge=1] { line-width: @rdz18_maj * 1.2 + 4; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz18_maj * 1.2 + 3; }
      }
    }

    [type='motorway_link'], [type='trunk_link'] {
      [render='inline'] { line-width: @rdz18_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz18_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz18_maj / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz18_maj / 2 + 1; }
      }
    }
    [type='primary'] {
      [render='inline'] { line-width: @rdz18_maj; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz18_maj + 2; }
        [bridge=1] { line-width: @rdz18_maj + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz18_maj + 2; }
      }
    }

    [type='primary_link'] {
      [render='inline'] { line-width: @rdz18_maj / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz18_maj / 2 + 1; }
        [bridge=1] { line-width: @rdz18_maj / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz18_maj / 2 + 1; }
      }
    }
    [type='secondary'],[type='secondary_link'],
    [type='tertiary'], [type='tertiary_link'] {
      [render='inline']
        { line-width: @rdz18_med; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz18_med + 2; }
        [bridge=1] { line-width: @rdz18_med + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz18_med + 2; }
      }
    }

    [type='residential'], [type='road'], [type='minor'],
      [type='unclassified'], {
      [render='inline']
        { line-width: @rdz18_min; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz18_min + 2; }
        [bridge=1] { line-width: @rdz18_min + 3; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz18_min + 2; }
      }
    }

    [type='path'], [type='track'], [type='footway'],
    [type='bridleway'], [type='cycleway'],
    [type='pedestrian'], [type='living_street'], [type='service'],
    [type='construction'], [type='proposed'] {
      [render='inline']
        { line-width: @rdz18_min  / 2; }
      [render='casing'] {
        [bridge=0] { line-width: @rdz18_min / 2 + 1; }
        [bridge=1] { line-width: @rdz18_min / 2 + 2; }
      }
      [render='outline'] {
        [tunnel=0] { line-width: @rdz18_min / 2 + 1; }
      }
    }
  }

}

//// railway

// overview

#road_all[zoom>=12][zoom<=13][class='railway'][render!='marker'] {
  [type='rail'], [type='subway'], [type='lightrail'] {
    line-cap: butt;
    line-join: round;
    line-width: 0;
    [render='inline'] {
      [tunnel=1] {
        line-opacity: 0.5;
        dash/line-opacity: 0.5;
      }
      line-color: @rail-line;
      line-width: 0.6;
      dash/line-dasharray: 4, 4;
      dash/line-color: @rail-casing;
      dash/line-width: 0.4;
    }
  }
}

// class: railway

#road_all[zoom>=14][class='railway'][render!='marker'] {
  line-cap: butt;
  line-join: round;
  line-width: 0;

  [render='inline'] {
    [tunnel=1] {
      line-opacity: 0.5;
      dash/line-opacity: 0.5;
    }
  }

  [zoom<=15] {
    [render='casing'][bridge=1] {
      line-color: @rail-line;
      line-width: 5;
      fill/line-color: @land;
      fill/line-width: 3;
    }
    [render='casing'][bridge=0] {
      fill/line-color: @land;
      fill/line-width: 3;
    }
    [render='inline'] {
      [type='monorail'], [type='tram'], [type='narrow_gauage'],
      [type='disused'], [type='preserved'], [type='funicular'] {
        line-color: @rail-line;
        line-width: 0.5;
        dash/line-color: @rail-line;
        dash/line-width: 2;
        dash/line-dasharray: 1, 5;
      }
      [type='subway'], [type='light_rail'] {
        line-color: @rail-casing;
        line-width: 2;
        dash/line-color: @rail-line;
        dash/line-width: 1;
        dash/line-dasharray: 1.5, 1;
      }
      [type='rail'] {
        line-color: @rail-line;
        line-width: 1.5;
        dash/line-color: @rail-casing;
        dash/line-width: 1;
        dash/line-dasharray: 6, 6;
      }
    }
  }
  [zoom=16] {
    [render='casing'][bridge=1] {
      line-color: @rail-line;
      line-width: 7;
      fill/line-color: @land;
      fill/line-width: 5;
    }
    [render='casing'][bridge=0] {
      fill/line-color: @land;
      fill/line-width: 5;
    }
    [render='inline'] {
      [type='monorail'], [type='tram'], [type='narrow_gauage'],
      [type='disused'], [type='preserved'], [type='funicular'] {
        line-color: @rail-line;
        line-width: 1;
        dash/line-color: @rail-line;
        dash/line-width: 3;
        dash/line-dasharray: 1, 7;
      }
      [type='subway'], [type='light_rail'] {
        line-color: @rail-casing;
        line-width: 3;
        dash/line-color: @rail-line;
        dash/line-width: 2;
        dash/line-dasharray: 1.5, 1;
      }
      [type='rail'] {
        line-color: @rail-line;
        line-width: 3;
        dash/line-color: @rail-casing;
        dash/line-width: 2;
        dash/line-dasharray: 8, 8;
      }
    }
  }
  [zoom>=17] {
    [render='casing'][bridge=1] {
      line-color: @rail-line;
      line-width: 10;
      fill/line-color: @land;
      fill/line-width: 7;
    }
    [render='casing'][bridge=0] {
      fill/line-color: @land;
      fill/line-width: 7;
    }
    [render='inline'] {
      [type='monorail'], [type='tram'], [type='narrow_gauage'],
      [type='disused'], [type='preserved'], [type='funicular'] {
        line-color: @rail-line;
        line-width: 1.2;
        dash/line-color: @rail-line;
        dash/line-width: 4;
        dash/line-dasharray: 1, 9;
      }
      [type='subway'], [type='light_rail'] {
        line-color: @rail-casing;
        line-width: 5;
        dash/line-color: @rail-line;
        dash/line-width: 4;
        dash/line-dasharray: 2, 1;
      }
      [type='rail']{
        line-color: @rail-line;
        line-width: 5;
        dash/line-color: @rail-casing;
        dash/line-width: 3;
        dash/line-dasharray: 10, 10;
      }
    }
  }
}

/// oneway makers

#road_all[zoom>=15][oneway!=0][class!='railway'][render='marker'] {
  [zoom=17][link=0]  { marker-smooth: 0; }
  [zoom=17][link=1]  { marker-smooth: 0.1; }
  [zoom>=18][link=0] { marker-smooth: 0.05; }
  [zoom>=18][link=1] { marker-smooth: 0.4; }
  [zoom=15][type='motorway'],
  [zoom=15][type='trunk'],
  [zoom=15][type='primary'],
  [zoom>=16]
  {
    [type='motorway'], [type='motorway_link'],
    [type='trunk'], [type='trunk_link'], {
      marker-fill: @motorway-casing;
    }
    marker-fill: @primary-casing;
    marker-line-width: 0;
    marker-placement: line;
    marker-type: arrow;
    marker-clip: false;
    marker-height: 6;
    marker-file: url("arrow/oneway.svg");
    [oneway=-1] {   marker-file: url("arrow/oneway-reverse.svg") }
    [zoom<=16] { marker-transform: "scale(0.5)"; }

    marker-spacing: 200;
    marker-ignore-placement: true;
  }
}
