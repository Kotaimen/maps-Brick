/*

///////////////////////////////////////////////////
// Landmass
///////////////////////////////////////////////////


#bathymetry[zoom<7] {
  polygon-opacity: 0.1;
  polygon-comp-op: multiply;
  polygon-fill: @water-color;
}

#land[zoom>=0][zoom<5],
#shoreline_300[zoom>=5][zoom<10],
#processed_p[zoom>=10] {
  polygon-fill: @land-color;
  polygon-gamma: 0.75;
}



#pier[zoom>11][type='pier'] {
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
#pier[zoom>11][type='breakwater'] {
  [zoom=12] { line-width: 1;}
  [zoom=13] { line-width: 1;}
  [zoom=14] { line-width: 1;}
  [zoom=15] { line-width: 2;}
  [zoom=16] { line-width: 3;}
  [zoom=17] { line-width: 4;}
  [zoom>=18] { line-width: 5;}
  line-color:@ferry-color;
  line-join: round;
  line-cap: butt;
}



///////////////////////////////////////////////////
// Waterbody
///////////////////////////////////////////////////

#10m_lakes[zoom<=4],
#waterbody_gen0[zoom>5][zoom<=9],
#waterbody_gen1[zoom>9][zoom<=12],
#waterbody[zoom>12] {
  polygon-fill: @water-color;
}

#10m_rivers[zoom<8] {
  [zoom=2][scalerank<=3],
  [zoom=3][scalerank<=4],
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
  [type='river'],
  [type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom=13]{ line-width: 1; }
    [zoom=14]{ line-width: 1.5; }
  }
  [type='stream'] {
    [zoom=13]{ line-width: 0.2; }
    [zoom=14]{ line-width: 0.4; }
  }
}

#waterway[zoom>=15] {
  line-color: @water-color;
  [type='river'],
  [type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom=15]{ line-width: 2; }
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

///////////////////////////////////////////////////
// Unified landusage
///////////////////////////////////////////////////
//#landusage_gen0[zoom=4][area>640000000],
#landusage_gen0[zoom=6][area>100000000],
#landusage_gen0[zoom=7][area>50000000],
#landusage_gen0[zoom=8][area>10000000],
#landusage_gen0[zoom=9][area>5000000],
#landusage_gen1[zoom=10][area>1000000],
#landusage_gen1[zoom=11][area>500000],
#landusage_gen1[zoom=12][area>50000],
#landusage[zoom>12] {
  //polygon-opacity: 0.4; polygon-fill: cyan; line-color: blue;
  //::type { text-face-name: "Arial Bold";  text-name: "[type]"; text-fill: blue; text-size: 16; }
  [type='residential']   { polygon-fill: @residential-color; }

  [type='forest'], [type='meadow'], [type='grass'], [type='wood'], 
  [type='wetland'], [type='scrub']
  { polygon-fill: @green-color-alt; }

  [type='park'],  [type='golf_course'], 
  [type='garden'], [type='recreation_ground'],
  [type='village_green'], [type='zoo'], 
  [type='farm'], [type='farm_land'], [type='farm'] 
  { polygon-fill: @green-color; }
  
  [type='cemetery'], [type='grave_yard'], 
  { polygon-fill: @green-color; 
    line-color: @green-color-alt;
    line-dasharray: 5,3;
	line-width: 1.5;    
  }
 
  [type='school'], [type='university'], [type='college'], 
  [type='highschool'], 
  [type='place_of_worship'], [type='chruch']
  { polygon-fill: @education-color; }

  [type='hospital']
  { polygon-fill: @healthcare-color; }

  [type='pitch'], [type='pedestrian'], 
  [type='sports_centre'], [type='stadium'], [type='track'],
  [type='arts_centre'], [type='theatre'], [type='beach'], 
  [type='museum'], [type='library'], [type='restaurant'], 
  { polygon-fill: @sports-color; }

  [type='retail'], 
  [type='common'], [type='commercial'], [type='service'], 
  [type='courthouse'], [type='attraction'],
  { polygon-fill: @grey-color; }

  [type='industrial'], [type='police'], [type='construction'],
  [type='landfill'], [type='quarry'], [type='mine'], 
  { polygon-fill: @grey-color-alt; }

  [type='nature_reserve'], [type='conservation'], 
  { polygon-fill: @green-color-alt;
	polygon-opacity: 0.3;
    line-color: @green-color-alt;
    line-dasharray: 5,3; 
  }
  [type='military']
  { polygon-fill: @healthcare-color; 
	polygon-opacity: 0.3;
    line-color: @healthcare-color;
    line-dasharray: 5,3;  
  }

  [type='aerodrome'], [type='airport'], [type='boundary'], [type='station'],
  [type='harbor'], [type='railway'], [type='parking'],
  { polygon-fill: @airport-color; }

  [type='runway'], [type='helipad'],
  { polygon-fill: @aeroway-color; }

  [type='terminal'] [type='apron']
  { polygon-fill: @terminal-color; }
}

#aeroway[zoom>=10] {
  line-color: @aeroway-color;
  line-cap:butt;
  line-join:miter;
  [type='runway'] {
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
  [type='taxiway'] {
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

#builtuparea[zoom>=4][zoom<10] {
  polygon-fill: @residential-color;
}

*/