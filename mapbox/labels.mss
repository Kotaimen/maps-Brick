
///////////////////////////////////////////////////
// Highlevel country/state names
///////////////////////////////////////////////////

#labels_continents[zoom<4] {
  ::text {
    text-face-name: @label-font-italic;
    text-name: '[name]';    
	text-size: 14;
//    text-transform: uppercase;
    text-placement: point;
    text-fill: @label-color;
    text-halo-fill: @land-color;
    text-halo-radius: @smart-halo-raidus;    
  }
}

#labels_oceans
{
  ::text
    [zoom<4][scalerank<1],
    [zoom>3][zoom<6][scalerank<3],
    [zoom>=6][zoom<9][scalerank<4],
    [zoom>=9][scalerank<8],    
  {
    text-face-name: @label-font-italic;
    text-name: '[name]';    
	[scalerank<2] { text-size: 14; }
	[scalerank>=2] { text-size: 12; }    
    text-transform: capitalize;
    text-placement: interior;
    text-fill: darken(@ferry-color, 10%);
    text-halo-fill: @land-color;
    text-halo-radius: @smart-halo-raidus;    
    text-wrap-width: 60;
  }
}


#labels_admin0[zoom<9] {
//  ::DEBUG { polygon-opacity:0.5; polygon-fill: lightgreen; }  
  ::text {
    text-face-name: @label-font-heavy;
    text-name: '';
    
    [zoom=3] { text-size: 11; text-name: '[label_z3]'; }
    [zoom=4] { text-size: 14; text-name: '[label_z5]'; }
    [zoom=5] { text-size: 16; text-name: '[label_z6]'; }
    [zoom=6] { text-size: 22; text-name: '[label_z7]'; }    
    [zoom>6] { text-size: 32; text-name: '[name]'; 
      text-character-spacing: 2; 
      text-placements: 'X,28,24';
      text-placement-type: simple;    
    }    
   
    text-placement: point;
    text-fill: @label-color;
    text-halo-fill: @land-color;
    text-halo-radius: @smart-halo-raidus;    
    text-label-position-tolerance: 16;
    text-wrap-width: 120;
//    text-allow-overlap: true;
  }
}

#labels_admin1[zoom<9] {
  ::text {
    text-face-name: @label-font-heavy;
    text-name: '';    
    [zoom=4] { text-size: 12; text-name: '[label_z4]'; }
    [zoom=5] { text-size: 12; text-name: '[label_z5]'; }
    [zoom=6] { text-size: 14; text-name: '[label_z6]'; }    
    [zoom>=7] { text-size: 16; text-name: '[label_z7]'; }    
    
    text-placement: point;
    text-fill: @boundary-color;
    text-halo-fill: @land-color;
    text-halo-radius: @smart-halo-raidus;    
    text-label-position-tolerance: 10;
  }
}

#labels_places_gen0 {
  ::marker
    ['zoom_start'<=4][zoom=4], 
    ['zoom_start'<=5][zoom=5],
    ['zoom_start'<=6][zoom=6],
  {
    [font_size=18] { marker-width:6+@smart-halo-raidus;}
    [font_size=12] { marker-width:5+@smart-halo-raidus;}    
	marker-fill: @label-color;
	marker-line-color: @land-color;
  }  
  ::text {
    text-face-name: @label-font;
    text-name: '';
    ['zoom_start'<=4][zoom=4] { text-size: 14; text-name: '[name]'; }
    ['zoom_start'<=5][zoom=5] { text-size: 16; text-name: '[name]' ;}
    ['zoom_start'<=6][zoom=6] { 
      [font_size=18] {text-size: 20; text-dx: 5; text-dy: 5;}
      [font_size=12] {text-size: 16; text-dx: 4; text-dy: 4; }
      text-name: '[name]'; 
    }    
    [font_size=18] {text-dx: 5; text-dy: 5;}
    [font_size=12] {text-dx: 4; text-dy: 4; }    
    text-fill: @label-color;
    text-halo-fill: @land-color;
    text-halo-radius: @smart-halo-raidus;
	text-placement-type: simple;
    text-placement: point;    
    text-placements: 'NE,SE,SW,W,N,E';

  }  
}

///////////////////////////////////////////////////
// Dymo static placed names
///////////////////////////////////////////////////

#labels_places_gen1_names
{
  ::text
  [zoom=7][layer=7], 
  [zoom=8][layer=8],
  [zoom=9][layer=9],    
  {
//    ::DEBUG { polygon-opacity:0.5; polygon-fill: yellow; }
    text-clip: false;
    //[capital="yes"] { text-face-name: @label-font-heavy; }
    text-face-name: @label-font;
    text-allow-overlap: true;
    text-name: "[name]";
    text-fill: @label-color;
    text-halo-fill: @land-color;
    text-halo-radius: 0 + @smart-halo-raidus;
    text-placement: interior;
    [font_size<=18] { text-size: 18; }
    [font_size=24] { text-size: 24; }
    [font_size=32] { text-size: 32; }
  }  
}

#labels_places_gen1_points
{
  ::marker
  [zoom=7][layer=7],
  [zoom=8][layer=8],
  [zoom=9][layer=9],    
  {
    [font_size<=18] { marker-width: 5+@smart-halo-raidus; }
    [font_size>18] { marker-width: 6+@smart-halo-raidus; }
    marker-fill:@label-color;
    marker-line-color: @land-color;
    marker-line-width: @smart-halo-raidus;
  }
}

///////////////////////////////////////////////////
// OSM dynamic place names
///////////////////////////////////////////////////


#labels_places_full[zoom>9][zoom<17] {
  text-clip: false;
  text-face-name: @label-font;
  text-allow-overlap: false;
  text-name: "";
  text-fill: @label-color;
  text-halo-fill: @land-color;
  text-halo-radius: 0 + @smart-halo-raidus;
  text-placement: point;
  text-size: 16;
  text-min-distance: 45;
//  text-spacing: 16;
  [type=0][zoom<=15],
  [type>=1] {
	text-name: "[name]";
  }
  [type=3][zoom<15] { text-size: 16; text-wrap-width: 80; }
  [type=3][zoom>=15] { text-size: 20; text-wrap-width: 90;}
  [type=2] { text-size: 20; text-wrap-width: 120; }
  [type=2][zoom>=15] { text-size: 22; text-wrap-width: 100; text-character-spacing: 1;}
  [type=1][zoom<16] { text-size: 24; }
  [type=1][zoom>=15] { text-size: 32; text-character-spacing: 2; }
  [type=0][zoom<=13] { text-size: 32; }
  [type=0][zoom>13][zoom<=15]{ text-size: 42; text-character-spacing: 4; }
}



///////////////////////////////////////////////////
// Landusage labels
///////////////////////////////////////////////////

#labels_landusage[zoom>6] {
  text-clip: false;
  text-face-name: @label-font-alt;
  text-allow-overlap: false;
  text-name: "";
  text-fill: @label-color-alt;
  text-halo-fill: @land-color;
  text-halo-radius: @smart-halo-raidus; //1 + @smart-halo-raidus / 2;
  text-wrap-width: 60;
  text-placement: point;
  text-size: 11;
  text-min-distance: 8;
//  text-line-spacing: -4;
  [type='aerodrome'], [type='railway'], [type='university'], {
    text-size: 12;
  }
  
  //// Render control
  
  [type='nature_reserve'],
  [type='park'], 
  [type='conservation'],
  [type='military'],     
  {
    [zoom=6][area>2000000000],
    [zoom=7][area>1000000000],
    [zoom=8][area>40000000],
    [zoom=9][area>20000000],
    [zoom=10][area>10000000],   
    {
  		text-name: "[name]";
    }
  }
  [type='nature_reserve'],
  [type='park'],    
  [type='conservation'],
  [type='military'],    
  [type='aerodrome'],
  [type='railway'],
  [type='water'],    
  [type='salt_pond'],
  {
	[zoom=11][area>5000000],
  	[zoom=12][area>500000],
    [zoom=13][area>100000],
    {
  		text-name: "[name]";
    }
  }
  [type='nature_reserve'],
  [type='aerodrome'],
  [type='park'],
  [type='conservation'],
  [type='military'],    
  [type='hospital'],
  [type='university'],
  [type='railway'],
  [type='cemetery'],
  [type='water'],
  [type='pond'],
  {
    [zoom=14][area>10000],
    [zoom=15][area>5000],
    {
  		text-name: "[name]";
    }
  }
  [zoom=16][area>1000],
  [zoom>=17],
  {
  	text-name: "[name]";
  }
  
  //// Color control
  
  [type='forest'], [type='grass'], [type='wood'], [type='wetland'],
  [type='golf_course'], [type='conservation'],
  [type='park'], [type='nature_reserve'] {
   	text-fill: desaturate(darken(@green-color, 40%), 5%);
  }

  [type='hospital'] {
  	text-fill: saturate(darken(@healthcare-color, 45%), 40%);
  }

  [type='reservoir'], [type='water'], [type='pond'], [type='salt_water'] {
    text-fill: darken(@ferry-color, 10%);
    text-face-name: @label-font-italic;
  }
  
  [type='aerodrome'], [type='university'], [type='railway'],
  {
    text-fill: @label-color;
  }
  
  //// Marker

  [type='aerodrome'] {
    [zoom=9][area>20000000],
    [zoom=10][area>4000000],
  	[zoom=11][area>1000000],
  	[zoom=12][area>500000],
    [zoom=13][area>50000],
    [zoom>=14]
    {
      ::marker {
        marker-placement: point;
        marker-width: 12;
        marker-height: 12;           
		marker-fill: @label-color;
        marker-file: url("marker/airport.svg");
      }
	  text-placement-type: simple;
      text-dx: 12;
      text-dy: 12;
      text-placements: 'S,E,W,N';
    }  
  }
  [type='railway'] {
  	[zoom=11][area>1000000],
  	[zoom=12][area>500000],
    [zoom=13][area>50000],
    [zoom=14][area>10000],
    [zoom=15][area>5000],
    [zoom>=16]
    {
      ::marker {
        marker-placement: point;
        marker-width: 8;
        marker-height: 8;           
		marker-fill: @label-color;
        marker-file: url("marker/rail.svg");
      }
      text-dy: 8;
    }

  }
  [type='hospital'] {
  	[zoom=12][area>500000],
    [zoom=13][area>50000],
    [zoom=14][area>10000],
    [zoom=15][area>5000],
    [zoom=16][area>1000],
    [zoom>=17],      
    {
      ::marker {
        marker-placement: point;
        marker-width: 8;
        marker-height: 8;        
        marker-file: url("marker/hospital.svg");
		marker-fill: saturate(darken(@healthcare-color, 40%), 40%);        
      }
      text-dy: 7;
    }  
  }
  [type='university'],[type='college'] {
    [zoom=14][area>10000],
    [zoom=15][area>5000],
    [zoom=16][area>1000],
    [zoom>=17],      
    {
      ::marker {
        marker-placement: point;
        marker-width: 11;
        marker-height: 11;        
        marker-file: url("marker/college.svg");
		marker-fill: @label-color;
      }
      text-dy: 12;
    }  
  }  
 [type='school'],[type='highschool'] {
    [zoom=15][area>5000],
    [zoom=16][area>1000],
    [zoom>=17],      
    {
      ::marker {
        marker-placement: point;
        marker-width: 11;
        marker-height: 11;        
        marker-file: url("marker/school.svg");
		marker-fill: @label-color;
      }
      text-dy: 10;
    }  
  } 
  
  [type='nature_reserve'],[type='conservation'],[type='park'] {
    [zoom=6][area>2000000000],
    [zoom=7][area>1000000000],
    [zoom=8][area>40000000],
    [zoom=9][area>20000000],
    [zoom=10][area>10000000],
  	[zoom=11][area>5000000],
  	[zoom=12][area>1000000],
    [zoom=13][area>100000],
    [zoom=14][area>10000],
    [zoom=15][area>5000],
    [zoom=16][area>1000],    
    [zoom>=17]
    {
      ::marker {
        marker-placement: point;
        marker-file: url("marker/tree-1.svg");
        marker-width: 9;
        marker-height: 10;
     	marker-fill: desaturate(darken(@green-color, 45%), 5%);
      }
	  text-placement-type: simple;
      text-dx: 8;
      text-dy: 9;
      text-placements: 'S,E,W';
    }  
  }
  [type='cemetery'] {
    [zoom=14][area>100000],
    [zoom=15][area>10000],  
    [zoom=16][area>5000],    
    [zoom>=17]
    {
      ::marker {
        marker-placement: point;
        marker-file: url("marker/cemetery.svg");
        marker-width: 10;
        marker-height: 10;
		marker-fill: @label-color-alt;
      }
      text-dy: 9;
    }  
  }
}


///////////////////////////////////////////////////
// Road shields, labels
///////////////////////////////////////////////////


#road_shields[zoom>9][zoom<=17] {
//  ::DEBUG { line-color: orange; line-comp-op: multiply; line-opacity: 0.5; line-width: 6; line-cap: round;}
  [category='US/I'] {
    shield-file: url('shield/us-0.svg');
    shield-placement: line;    
	shield-clip: false;    
    shield-face-name: @road-font;
    shield-name: '[ref]';
    shield-fill: white;
    shield-text-dy: 1;
    shield-size: 10;
    shield-allow-overlap: false;
    shield-spacing: 200;
    [zoom<13] { shield-min-distance: 60; }
    [zoom=13] { shield-min-distance: 80; }
    [zoom=14] { shield-min-distance: 100; }    
    [zoom=15] { shield-min-distance: 120; }
    [zoom=16] { shield-min-distance: 140; }    
    [zoom>=17] { shield-min-distance: 160; } 
  }
  [category='US/US'] {
    shield-file: url('shield/us-1.svg');
    shield-placement: line;    
    shield-clip: false;
    shield-face-name: @road-font;
    shield-name: '[ref]';
    shield-fill: black;
    shield-text-dy: 1;
    shield-size: 9;
    shield-allow-overlap: false;
    shield-spacing: 200;
    [zoom<13] { shield-min-distance: 60; }
    [zoom=13] { shield-min-distance: 80; }
    [zoom=14] { shield-min-distance: 100; }    
    [zoom=15] { shield-min-distance: 120; }
    [zoom=16] { shield-min-distance: 140; }    
    [zoom>=17] { shield-min-distance: 160; }    
  }
  [category='INTL/ALL'][zoom>11][ref!='']  {
    shield-file: url('shield/us-2.svg');
    shield-placement: line;    
    shield-clip: false;
    shield-face-name: @road-font;
    shield-name: '[ref]';
    shield-fill: black;
    shield-size: 8;
    shield-allow-overlap: false;
    shield-spacing: 200;
    [zoom<13] { shield-min-distance: 60; }
    [zoom=13] { shield-min-distance: 80; }
    [zoom=14] { shield-min-distance: 100; }    
    [zoom=15] { shield-min-distance: 120; }
    [zoom=16] { shield-min-distance: 140; }    
    [zoom>=17] { shield-min-distance: 160; }    
  }
}

#labels_roads_gen1[zoom>=10][zoom<14][is_link=0],
#labels_roads[zoom>=14][is_link=0] {
  text-clip: false;
  text-face-name: @road-font;
  text-allow-overlap: false;
  text-name: "";
  text-fill: @label-color;
  [category='highway'], [category='trunk'] {  text-halo-fill: @highway-body-color;}
  [category='major_road'] {  text-halo-fill: @major_road-body-color;}
  [category='minor_road'] {  text-halo-fill: @minor_road-body-color;}  
  text-halo-fill: @path-body-color;
  
  text-halo-radius: 1;
  text-placement: line;
  text-min-distance: 16;
  [zoom<16] { text-spacing: 100; }
  [zoom=16] { text-spacing: 100; }  
  [zoom=17] { text-spacing: 150; }
  [zoom=18] { text-spacing: 200; }  
  text-label-position-tolerance: 16;
  text-max-char-angle-delta: 20;
  
  [zoom>=17] { text-size: 11;  }

  [priority<=3] { text-transform: uppercase; }
  [priority>=3] { text-fill: @label-color-alt; }

  [zoom<14][priority<=1] { text-name: "[name_abbr]"; }
  [zoom=14][priority<=3] { text-name: "[name_abbr]"; }
  [zoom=15][priority<=6] { text-name: "[name_abbr]"; }
  [zoom=16][priority<=7] { text-name: "[name]"; }
  [zoom>=17] { text-name: "[name]"; }
}
