Map {
  background-color: @land;
}

////// Land

#shoreline_300[zoom<=9],
#processed_p[zoom>=10],
{
  polygon-fill: @land;
  polygon-gamma: 0.75;
}


#10m_reef[zoom>=4] {
  [zoom<6] { line-width: 0.25; }
  [zoom>=6] { line-width: 0.5; }
  line-dasharray: 1, 1;
  line-color: @ferry-line;
}

#10m_urbanareas[zoom<=11] {
  polygon-fill: @residential;
}

#10m_snow[zoom<=10] {
  polygon-fill: lighten(@land, 7%);
}


////// Water

#10m_river[zoom<=7],
#10m_river_eu[zoom<=7],
#10m_river_us[zoom<=7],
{
  [zoom=2][scalerank<=3],
  [zoom=3][scalerank<=4],
  {
  	line-color: @water;
  	line-width: 0.25;
  }

  [zoom=4][scalerank<=5],
  [zoom=5][scalerank<=6],
  [zoom=6][scalerank<=7],
  [zoom>=7][scalerank<=99],
  {
  	line-color: @water;
  	line-width: 0.5;
  }
}

#waterway_gen0[zoom>=8][zoom<=11][type="river"] {
  line-color: @water;
  [zoom=8] { line-width: 0.1; }
  [zoom=9] { line-width: 0.2; }
  [zoom=10]{ line-width: 0.4; }
  [zoom=11]{ line-width: 0.6; }
  [zoom=12]{ line-width: 0.8; }
}

#waterway_gen1[zoom>=12][zoom<14] {
  [type='river'],
  [type='canal'] {
    line-color: @water;
    line-cap: round;
    line-join: round;
    [zoom<=12]{ line-width: 1; }
    [zoom>=13]{ line-width: 1.5; }
  }
  [type='stream'] {
    line-color: @water;
    [zoom<=12]{ line-width: 0.2; }
    [zoom>=13]{ line-width: 0.4; }
  }
}

#waterway[zoom>=14] {
  line-color: @water;
  [type='river'],
  [type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom<=15]{ line-width: 2; }
    [zoom=16]{ line-width: 3; }
    [zoom=17]{ line-width: 4; }
    [zoom=18]{ line-width: 5; }
    [zoom=19]{ line-width: 6; }
    [zoom>19]{ line-width: 7; }
  }
  [type='stream'] {
    [zoom=15]{ line-width: 0.6; }
    [zoom=16]{ line-width: 0.8; }
    [zoom=17]{ line-width: 1; }
    [zoom=18]{ line-width: 1.5; }
    [zoom>18]{ line-width: 2; }
  }
  [type='ditch'],
  [type='drain'] {
    [zoom=15]{ line-width: 0.1; }
    [zoom=16]{ line-width: 0.3; }
    [zoom=17]{ line-width: 0.5; }
    [zoom=18]{ line-width: 0.7; }
    [zoom=19]{ line-width: 1; }
    [zoom>19]{ line-width: 1.5; }
  }
}

#10m_sea[zoom<=7],
#sea[zoom>=8],
#10m_lake[zoom<=7],
#10m_lake_us[zoom<=9],
//#10m_lake_eu[zoom<=9],
//#waterbody_gen0[zoom>=8][zoom<=9],
#waterbody_gen1[zoom>=8][zoom<=11],
#waterbody[zoom>=12] {

  polygon-fill: @water;
  [zoom>=16] { polygon-smooth: 0.25; }

  ::effect_emboss {
    polygon-fill: grey;
    image-filters: 'x-gradient, blur';
    comp-op: soft-light;
    [zoom>=16] { polygon-smooth: 0.25; }
  }

}

/// landuse
#landuse_gen0[zoom>=5][zoom<=9],
#landuse_gen1[zoom>=10][zoom<=12],
#landuse[zoom>=13] {
  // natural green
  [type='forest'], [type='meadow'], [type='grass'], [type='grassland'],
  [type='wood'], [type='wetland'], [type='marsh'], [type='scrub'],
  [type='heath'] { polygon-fill: @wooded; }

  // manmade green
  [type='park'], [type='garden'], [type='recreation_ground'],
  [type='village_green'], [type='zoo'], [type='dog_park'],
  [type='theme_park'], [type='golf_range'], [type='golf_course'], [type='miniature_golf'],
  [type='funfair'], [type='water_park'], [type='greenspace'],
  { polygon-fill: @park; }

  // agriculture
  [type='farm'], [type='farm_land'], [type='farmland'], [type='farmyard'],
  [type='orchard'], [type='vineyard']
  { polygon-fill: @agriculture; }

  // sandy
  [type='beach'], [type='sand'], [type='desert']
  { polygon-fill: @sand; }

  // sport
  [type='camp_site'], [type='sport'], [type='pitch'],
  [type='sports_centre'], [type='stadium'], [type='playground'],
  { polygon-fill: @sports; }

  // educational
  [type='school'], [type='university'], [type='college'], [type='kindergarten'],
  [type='highschool'], [type='educational'],
  [type='arts_centre'], [type='theatre'],
  [type='museum'], [type='library'], [type='venue'],
  [type='attraction'], [type='tourism'], [type='gallery'], [type='cinema']
  { polygon-fill: @educational; }

  // religous
  [type='place_of_worship'], [type='chruch'],
  [type='cemetery'], [type='grave_yard'],
  { polygon-fill: @religion; }

  // healthcare
  [type='hospital'], [type='doctors'], [type='clinc'], [type='nursery'], [type='dentist']
  { polygon-fill: @healthcare; }

  // zoning
  [type='retail'], [type='restaurant'], [type='hotel'],
  [type='common'], [type='commercial'], [type='service'],
  [type='courthouse'], [type='public_building'], [type='police'],
  [type='townhall'], [type='govermnent'], [type='post_office'],
  [type='prison'], [type='barracks']
  { polygon-fill: @commercial; }

  [type='industrial'], [type='construction'], [type='recycling'],
  [type='landfill'], [type='quarry'], [type='mine'],
  [type='brownfield'], [type='greenfield'], [type='special_use'],

  { polygon-fill: @industrial; }

  [type='residential'], [type='allotments']
  { polygon-fill: @residential; }
  [type='pedestrian'], [type='footway']
  { polygon-fill: @pedestrian; }

  // special
  [type='parking'], [type='caravan_site'],
  [type='camp_site'], { 
    polygon-fill: @parking; 
  }
  [type='land'], [type='island'], [type='pier'] { polygon-fill: @land; }
 // [type='water'], [type='fountain'], [type='swimming_pool'],
 // [type='pond'], [type='salt_pond'],
  [type='fountain'], [type='swimming_pool'], [type='basin'], { 
    polygon-fill: @water; 
  }

  // areas
  [type='nature_reserve'], [type='conservation'],
  [type='national_park'] {
	polygon-fill: @park;
    polygon-opacity: 0.5;
  }
  [type='military'], [type='range'] {
	polygon-fill: @military;
    polygon-opacity: 0.25;
  }

  // transport
  [type='aerodrome'], [type='airport'], [type='boundary'],
  [type='harbor'], [type='railway'],
  { polygon-fill: @airport; }

  [type='runway'], [type='helipad'], [type='track'], 
  { polygon-fill: @aeroway; }

  [type='terminal'], [type='apron'], [type='hangar'], 
  [type='fire_station'], [type='railway'], 
  { polygon-fill: @terminal; }

  // debug
//  polygon-opacity: 0.5; polygon-fill: orange; line-color: red; line-width: 0.5;
//  ::landusage_type_text[zoom>=10] { text-face-name: "Arial Bold";  text-name: "[type]"; text-fill: blue; text-halo-fill:cyan; text-halo-radius:2;  text-size: 10; text-placement: interior; }
}

#landuse_line {

  [type='ferry'][zoom>=7] {
    line-color: @ferry-line;
    [zoom<=9] { line-width: 0.25; }
    [zoom>=10][zoom<=12] { line-width: 0.5; }
    [zoom<=14][zoom>12] { line-width: 0.75; }
    [zoom>=15][zoom<=17] { line-width: 1; line-smooth: 0.2; }
    [zoom>=15][zoom<=17] { line-width: 1.2; line-smooth: 0.4; }
    line-dasharray: @road-dash;
    line-join: round;
  }
  [type='pier'][zoom>=10] {

    [zoom=12] { line-width: 1;}
    [zoom=13] { line-width: 1;}
    [zoom=14] { line-width: 2;}
    [zoom=15] { line-width: 3;}
    [zoom=16] { line-width: 4;}
    [zoom=17] { line-width: 5;}
    [zoom>=18] { line-width: 6;}
    line-color: @land;
    line-join: round;
    line-cap: butt;
  }
  [type='breakwater'][zoom>=10],
  [type='groyne'][zoom>=10] {
    [zoom=12] { line-width: 1;}
    [zoom=13] { line-width: 2;}
    [zoom=14] { line-width: 3;}
    [zoom=15] { line-width: 4;}
    [zoom=16] { line-width: 5;}
    [zoom=17] { line-width: 7;}
    [zoom>=18] { line-width: 8;}
    line-color: @land;
    line-join: round;
    line-cap: butt;
  }

}

#transport[zoom>=8]
{
  [type='station'], [type='bus_station'],
  { polygon-fill: @airport; }
}

#aeroway[zoom>=10] {
  line-color: @aeroway;
  line-cap: butt;
  line-join: miter;
  [type='runway'] {
    [zoom=10]{ line-width:1; }
    [zoom=11]{ line-width:2; }
    [zoom=12]{ line-width:3; }
    [zoom=13]{ line-width:5; }
    [zoom=14]{ line-width:7; }
    [zoom=15]{ line-width:11; }
    [zoom=16]{ line-width:18; }
    [zoom=17]{ line-width:24; }
    [zoom>17]{ line-width:32; }
  }
  [type='taxiway'] {
    [zoom=10]{ line-width:0.2; }
    [zoom=11]{ line-width:0.2; }
    [zoom=12]{ line-width:0.2; }
    [zoom=13]{ line-width:1; }
    [zoom=14]{ line-width:1.5; }
    [zoom=15]{ line-width:2; }
    [zoom=16]{ line-width:3; }
    [zoom=17]{ line-width:4; line-smooth: 0.5; }
    [zoom>17]{ line-width:8; line-smooth: 0.7; }
  }
}

#building[zoom>=12] {
  polygon-fill: @building;
  [zoom>=14] {
    line-color: @barrier;
    line-width:0.25;

  }
  [zoom>=16] {
    line-color: @barrier;
    line-width:0.5;
  }
}

#barrier[zoom>12] {
  line-color: @barrier;
  line-width: 0.5;
}
