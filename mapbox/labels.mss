/*

///////////////////////////////////////////////////
// Dymo pre-placed names
///////////////////////////////////////////////////

#labels-z4[zoom=4],
#labels-z5[zoom=5],
#labels-z6[zoom=6],
#labels-z7[zoom=7],
#labels-z8[zoom=8],
#labels-z9[zoom=9],
#labels-z10[zoom=10],
{
  //::DEBUG { polygon-opacity:0.5; polygon-fill: orange; }
  text-clip: false;
  //[capital="yes"] { text-face-name: @label-font-heavy; }
  text-face-name: @label-font;
  text-allow-overlap: true;
  text-name: "[name]";
  text-fill: @label-color;
  text-halo-fill: @land-color;
  text-halo-radius: 0 + @smart-halo-raidus;
  text-placement: interior;
  [font_size=18] { text-size: 18; }
  [font_size=24] { text-size: 22; }
  [font_size=32] { text-size: 30; }
}

#places-z4[zoom=4],
#places-z5[zoom=5],
#places-z6[zoom=6],
#places-z7[zoom=7],
#places-z8[zoom=8],
#places-z9[zoom=9],
#places-z10[zoom=10],
{
  [point_size=5] { marker-width: 5+@smart-halo-raidus; }
  [point_size=7] { marker-width: 6+@smart-halo-raidus; }
  marker-fill:@label-color;
  marker-line-color: @land-color;
  marker-line-width: @smart-halo-raidus;
}


///////////////////////////////////////////////////
// Normal place names
///////////////////////////////////////////////////


#places-all[zoom>=11] {
  text-clip: false;
  text-face-name: @label-font;
  text-allow-overlap: false;
  text-name: "";
  text-fill: @label-color;
  text-halo-fill: @land-color;
  text-halo-radius: 0 + @smart-halo-raidus;
  text-placement: point;
  text-size: 16;
  text-min-distance: 30;
//  text-spacing: 16;
  [type=0][zoom<17],
  [type>=1] {
	text-name: "[name]";
  }
  [type=3][zoom<15] { text-size: 16; text-wrap-width: 80; }
  [type=3][zoom>=15] { text-size: 18; text-wrap-width: 0; }
  [type=2] { text-size: 20; text-wrap-width: 120; }
  [type=2][zoom>=15] { text-size: 22; text-wrap-width: 0; }
  [type=1][zoom<16] { text-size: 24; }
  [type=1][zoom>=15] { text-size: 32; text-character-spacing: 4;}
  [type=0][zoom<=13] { text-size: 32; }
  [type=0][zoom>13][zoom<=15]{ text-size: 42; text-character-spacing: 4; }
}


///////////////////////////////////////////////////
// Road names
///////////////////////////////////////////////////

#road-label-gen1[zoom>=10][zoom<14][is_link=0],
#road-label[zoom>=14][is_link=0] {
  text-clip: false;
  text-face-name: @road-font;
  text-allow-overlap: false;
  text-name: "";
  text-fill: @label-color;
  text-halo-fill: @land-color;
  text-halo-radius: 1.5;
  text-placement: line;
  text-min-distance: 50;
//  text-spacing: 16;
  text-label-position-tolerance: 16;
  text-max-char-angle-delta: 20;

  [zoom>=17] { text-size: 11; text-min-distance:120; }

  [priority<=3] { text-transform: uppercase; }
  [priority>=3] { text-fill: @label-color-alt; }

  [zoom<14][priority<=1] { text-name: "[name_abbr]"; }
  [zoom=14][priority<=3] { text-name: "[name_abbr]"; }
  [zoom=15][priority<=6] { text-name: "[name_abbr]"; }
  [zoom=16][priority<=7] { text-name: "[name]"; }
  [zoom>=17] { text-name: "[name]"; }
}


#landusage-label[zoom>5] {
  text-clip: false;
  text-face-name: @label-font-alt;
  text-allow-overlap: false;
  text-name: "";
  text-fill: @label-color-alt;
  text-halo-fill: @land-color;
  text-halo-radius: 1 + @smart-halo-raidus / 2;
  text-wrap-width: 60;
//  text-placement: point;
  text-size: 12;
  text-min-distance: 16;

  [type='aerodrome'],[type='railway'] {
    text-size: 14;
  }
  
  //// Render control
  
  [type='nature_reserve'],
  [type='park'],
  {
    [zoom=5][area>640000000],
    [zoom=6][area>400000000],
    [zoom=7][area>100000000],
    [zoom=8][area>40000000],
    [zoom=9][area>20000000],
    [zoom=10][area>4000000],
    {
  		text-name: "[name]";
    }
  }
  [type='nature_reserve'],
  [type='park'],    
  [type='aerodrome'],
  [type='railway'],
  {
  	[zoom=11][area>1000000],
  	[zoom=12][area>100000],
    [zoom=13][area>50000],
    {
  		text-name: "[name]";
    }
  }
  [type='nature_reserve'],
  [type='aerodrome'],
  [type='park'],
  [type='hospital'],
  [type='university'],
  [type='railway'],
  {
    [zoom=14][area>10000],
    [zoom=15][area>3000],
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
  [type='golf_course'], [type='cemetery'],   
  [type='park'], [type='nature_reserve'] {
   	text-fill: desaturate(darken(@green-color, 40%), 5%);
  }

  [type='hospital'] {
  	text-fill: saturate(darken(@healthcare-color, 60%), 40%);
  }

  [type='reservoir'], [type='water'] {
    text-fill: @ferry-color;
  }
  
  [type='aerodrome'],  [type='university'], [type='railway'],
  {
    text-fill: @label-color;
  }
  
  //// Marker

  [type='aerodrome'] {
    [zoom=9][area>20000000],
    [zoom=10][area>4000000],
  	[zoom=11][area>1000000],
  	[zoom=12][area>100000],
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
      text-placement: point;
      text-vertical-alignment: bottom;
      text-dy: 10;
    }  
  }
  [type='railway'] {
  	[zoom=11][area>1000000],
  	[zoom=12][area>100000],
    [zoom=13][area>50000],
    [zoom=14][area>10000],
    [zoom=15][area>3000],
    [zoom>=16]
    {
      ::marker {
        marker-placement: point;
        marker-width: 8;
        marker-height: 8;           
		marker-fill: @label-color;
        marker-file: url("marker/rail.svg");
      }
      text-placement: point;
      text-vertical-alignment: bottom;
      text-dy: 7;
    }  
  }

  [type='hospital'] {
  	[zoom=12][area>100000],
    [zoom=13][area>50000],
    [zoom=14][area>10000],
    [zoom=15][area>3000],
    [zoom=16][area>1000],
    [zoom>=17],      
    {
      ::marker {
        marker-placement: point;
        marker-width: 8;
        marker-height: 8;        
        marker-file: url("marker/hospital.svg");
		marker-fill: saturate(darken(@healthcare-color, 60%), 40%);        
      }
      text-placement: point;
      text-vertical-alignment: bottom;
      text-dy: 7;
    }  
  }
  [type='nature_reserve'],[type='park'] {
    [zoom=7][area>100000000],
    [zoom=8][area>40000000],
    [zoom=9][area>20000000],
    [zoom=10][area>4000000],
  	[zoom=11][area>1000000],
  	[zoom=12][area>100000],
    [zoom=13][area>50000],
    [zoom=14][area>10000],
    [zoom=15][area>3000],  
    [zoom=16][area>1000],    
    [zoom>=17]
    {
      ::marker {
        marker-placement: point;
        marker-file: url("marker/tree-1.svg");
        marker-width: 8;
        marker-height: 10;
     	marker-fill: desaturate(darken(@green-color, 40%), 5%);
      }
      text-placement: point;
      text-vertical-alignment: bottom;
      text-dy: 9;
    }  
  }
  
}

*/