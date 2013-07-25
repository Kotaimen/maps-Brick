
///////////////////////////////////////////////////
// Landmass
///////////////////////////////////////////////////

#land_gen1[zoom<10],
#land_full[zoom>=10] {
  polygon-fill: @land-color;
  polygon-gamma: 0.8;
}

///////////////////////////////////////////////////
// Waterbody
///////////////////////////////////////////////////

#bathymetry[zoom<=10] {
  polygon-opacity: 0.1;
  polygon-comp-op: multiply;
  polygon-fill: @water-color;
}


#10m_reefs[zoom>3] {
  line-cap: round;
  line-join: round;
  [zoom<7] { line-width:0.4; }
  [zoom>=7] { line-width:0.7; }
  line-color: @ferry-color;
  line-comp-op: multiply;
  [zoom>=9] { line-smooth: 0.6; }
}


#10m_lakes[zoom<=6],
#waterbody_gen0[zoom>6][zoom<10],
#waterbody_gen1[zoom>=10][zoom<=12],
#waterbody_full[zoom>12] {
  polygon-fill: @water-color;
  [zoom>16] { polygon-smooth: 0.2; }
}

#10m_rivers[zoom<8] {
  [zoom=2][scalerank<=3],
  [zoom=3][scalerank<=4],
  {
  	line-color: @water-color;
  	line-width: 0.25;
  }

  [zoom=4][scalerank<=5],
  [zoom=5][scalerank<=6],
  [zoom=6][scalerank<=7],
  [zoom=7][scalerank<=8],
  {
  	line-color: @water-color;
  	line-width: 0.5;
  }
}

#waterway_gen0[zoom>=8][zoom<=12] {
  line-color: @water-color;
  [zoom=8] { line-width: 0.1; }
  [zoom=9] { line-width: 0.2; }
  [zoom=10]{ line-width: 0.4; }
  [zoom=11]{ line-width: 0.6; }
  [zoom=12]{ line-width: 0.8; }
}

#waterway_gen1[zoom>=13][zoom<=14] {
  line-color: @water-color;
  [waterway_type='river'],
  [waterway_type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom=13]{ line-width: 1; }
    [zoom=14]{ line-width: 1.5; }
  }
  [waterway_type='stream'] {
    [zoom=13]{ line-width: 0.2; }
    [zoom=14]{ line-width: 0.4; }
  }
}

#waterway_full[zoom>=15] {
  line-color: @water-color;
  [waterway_type='river'],
  [waterway_type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom=15]{ line-width: 2; }
    [zoom=16]{ line-width: 3; }
    [zoom=17]{ line-width: 4; }
    [zoom=18]{ line-width: 5; }
    [zoom=19]{ line-width: 6; }
    [zoom>19]{ line-width: 7; }
  }
  [waterway_type='stream'] {
    [zoom=15]{ line-width: 0.6; }
    [zoom=16]{ line-width: 0.8; }
    [zoom=17]{ line-width: 1; }
    [zoom=18]{ line-width: 1.5; }
    [zoom>18]{ line-width: 2; }
  }
  [waterway_type='ditch'],
  [waterway_type='drain'] {
    [zoom=15]{ line-width: 0.1; }
    [zoom=16]{ line-width: 0.3; }
    [zoom=17]{ line-width: 0.5; }
    [zoom=18]{ line-width: 0.7; }
    [zoom=19]{ line-width: 1; }
    [zoom>19]{ line-width: 1.5; }
  }
}


#pier[zoom>11][landusage_type='pier'] {
  [zoom=12] { line-width: 1;}
  [zoom=13] { line-width: 1;}
  [zoom=14] { line-width: 2;}
  [zoom=15] { line-width: 3;}
  [zoom=16] { line-width: 4;}
  [zoom=17] { line-width: 5;}
  [zoom>=18] { line-width: 6;}
  line-color:@land-color;
  line-join: round;
  line-cap: butt;
}

#pier[zoom>11][landusage_type='breakwater'] {
  [zoom=12] { line-width: 1;}
  [zoom=13] { line-width: 1;}
  [zoom=14] { line-width: 1;}
  [zoom=15] { line-width: 2;}
  [zoom=16] { line-width: 3;}
  [zoom=17] { line-width: 4;}
  [zoom>=18] { line-width: 5;}
  line-color: @highway-casing-color;
  line-join: round;
  line-cap: butt;
}

///////////////////////////////////////////////////
// Unified landusage
///////////////////////////////////////////////////

#builtuparea[zoom>=4][zoom<=10] {
  polygon-fill: @residential-color;
}

//#landusage_gen0[zoom=6][way_area>100000000],
#landusage_gen0[zoom=7][way_area>50.000000],
#landusage_gen0[zoom=8][way_area>10.000000],
#landusage_gen0[zoom=9][way_area>5.000000],
#landusage_gen1[zoom=10][way_area>1.000000],
#landusage_gen1[zoom=11][way_area>0.500000],
#landusage_gen1[zoom=12][way_area>0.50000],
#landusage_full[zoom>12] {
//  polygon-opacity: 0.5; polygon-fill: orange; line-color: red; line-width: 0.5;
//  ::landusage_type_text[zoom>13] { text-face-name: "Arial Bold";  text-name: "[landusage_type]"; text-fill: blue; text-halo-fill:cyan; text-halo-radius:2;  text-size: 12; text-placement: interior; }

  ///// Background
  [landusage_type='residential'], [landusage_type='allotments']  { polygon-fill: @residential-color; }
  [landusage_type='land'] { polygon-fill: @land-color;}


  ///// Yellow
  [landusage_type='sand'], [landusage_type='desert'], [landusage_type='beach'], [landusage_type='mud'],
   { polygon-fill: @yellow-color; }

  ///// Natural green
  [landusage_type='forest'], [landusage_type='meadow'], [landusage_type='grass'], [landusage_type='grassland'], [landusage_type='wood'],
  [landusage_type='wetland'], [landusage_type='marsh'], [landusage_type='scrub'], [landusage_type='heath'],
  { polygon-fill: @green-color-alt; }

  ///// Manmade green

  [landusage_type='park'], [landusage_type='garden'], [landusage_type='recreation_ground'],
  [landusage_type='village_green'], [landusage_type='zoo'], [landusage_type='dog_park'], [landusage_type='theme_park'],
  [landusage_type='theme_park'], [landusage_type='golf_range'], [landusage_type='golf_course'], [landusage_type='miniature_golf'],
  [landusage_type='funfair'], [landusage_type='water_park'], [landusage_type='greenspace'],
  [landusage_type='farm'], [landusage_type='farm_land'], [landusage_type='farmland'], [landusage_type='farmyard'],
  [landusage_type='orchard'], [landusage_type='vineyard']
  { polygon-fill: @green-color; }

  ///// Special green
  [landusage_type='cemetery'], [landusage_type='grave_yard'],
  { polygon-fill: @green-color;
    line-color: @grey-color-alt;
    line-dasharray: 2,2;
	line-width: 1;
  }

  ///// Educational, religon
  [landusage_type='school'], [landusage_type='university'], [landusage_type='college'], [landusage_type='kindergarten'],
  [landusage_type='highschool'], [landusage_type='educational'],
  [landusage_type='place_of_worship'], [landusage_type='chruch'],
  [landusage_type='arts_centre'], [landusage_type='theatre'],
  [landusage_type='museum'], [landusage_type='library'], [landusage_type='venue'],
  [landusage_type='attraction'], [landusage_type='tourism'], [landusage_type='gallery'], [landusage_type='cinema']
  { polygon-fill: @education-color; }

  ///// Hostpital, military
  [landusage_type='hospital'], [landusage_type='doctors'], [landusage_type='clinc'], [landusage_type='nursery'], [landusage_type='dentist']
  { polygon-fill: @healthcare-color; }

  [landusage_type='military']
  { polygon-fill: @terminal-color;
	polygon-opacity: 0.4;
    line-color: @terminal-color;
    line-dasharray: 2,2;
  }

  ///// Sport
  [landusage_type='pedestrian'], [landusage_type='camp_site'], [landusage_type='sport'],
  [landusage_type='pitch'], [landusage_type='sports_centre'], [landusage_type='stadium'], [landusage_type='playground'],
  { polygon-fill: @sports-color; }

  ///// General
  [landusage_type='retail'], [landusage_type='restaurant'], [landusage_type='hotel'],
  [landusage_type='common'], [landusage_type='commercial'], [landusage_type='service'],
  [landusage_type='courthouse'], [landusage_type='public_building'], [landusage_type='police'],
  [landusage_type='townhall'], [landusage_type='govermnent'], [landusage_type='post_office'],
  [landusage_type='prison']
  { polygon-fill: @grey-color; }

  ///// "Other"
  [landusage_type='industrial'],  [landusage_type='construction'], [landusage_type='recycling'],
  [landusage_type='landfill'], [landusage_type='quarry'], [landusage_type='mine'],
  [landusage_type='brownfield'],   [landusage_type='greenfield'], [landusage_type='special_use'],
  { polygon-fill: @grey-color-alt; }

  ///// NP Boundary
  [landusage_type='nature_reserve'], [landusage_type='conservation'],
  { polygon-fill: @green-color-alt;
	polygon-opacity: 0.3;
    line-color: @green-color-alt;
    line-dasharray: 2,2;
  }

  ///// Airs
  [landusage_type='aerodrome'], [landusage_type='airport'], [landusage_type='boundary'],
  [landusage_type='harbor'], [landusage_type='railway'], [landusage_type='parking'],
  [landusage_type='station'], [landusage_type='bus_station'],
  { polygon-fill: @airport-color; }

  [landusage_type='runway'], [landusage_type='helipad'], [landusage_type='track'],
  { polygon-fill: @aeroway-color; }

  [landusage_type='terminal'], [landusage_type='apron'], [landusage_type='hangar'], [landusage_type='fire_station'],

  { polygon-fill: @terminal-color; }

  ///// Water
  [landusage_type='fountain'], [landusage_type='swimming_pool'], [landusage_type='pond'], [landusage_type='salt_pond']
  { polygon-fill: @water-color; }

}

#aeroway[zoom>=10] {
  line-color: @aeroway-color;
  line-cap:butt;
  line-join:miter;
  [landusage_type='runway'] {
    [zoom=10]{ line-width:1; }
    [zoom=11]{ line-width:2; }
    [zoom=12]{ line-width:3; }
    [zoom=13]{ line-width:5; }
    [zoom=14]{ line-width:7; }
    [zoom=15]{ line-width:11; }
    [zoom=16]{ line-width:15; }
    [zoom=17]{ line-width:19; }
    [zoom>17]{ line-width:23; }
  }
  [landusage_type='taxiway'] {
    [zoom=10]{ line-width:0.2; }
    [zoom=11]{ line-width:0.2; }
    [zoom=12]{ line-width:0.2; }
    [zoom=13]{ line-width:1; }
    [zoom=14]{ line-width:1.5; }
    [zoom=15]{ line-width:2; }
    [zoom=16]{ line-width:3; }
    [zoom=17]{ line-width:4; line-smooth: 0.5; }
    [zoom>17]{ line-width:5; line-smooth: 0.7; }
  }
}

#building[zoom>12] {
  polygon-fill:@building-color;
  [zoom>=14] {
    line-color:darken(@building-color,10);
    line-width:0.2;

  }
  [zoom>=16] {
    line-color: darken(@building-color,20);
    line-width:0.4;
  }
  [zoom>=18] {
    ::label {
      text-placement: interior;
      text-name: '[addr:housenumber]';
      text-face-name: @shield-font;
      text-size: 9;
      text-fill: darken(@building-color,20);
    }
  }
}
