//
// Labels
//

// Physical labels

#label_continent[zoom<=4] {
  ::text {
    text-face-name: @font-physical;
    text-name: '[name]';
    text-size: 14;
    text-placement: point;
    text-character-spacing: 2;
    text-fill: @label-admin0;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;
    text-wrap-width: 80 * @scale-factor;
  }
}

#10m_marine[zoom<=9] {
  ::text
    [zoom<4][scalerank<1],
    [zoom>3][zoom<6][scalerank<3],
    [zoom>=6][zoom<9][scalerank<4],
    [zoom>=9][scalerank<8], {
    text-face-name: @font-physical;
    text-name: '[name]';
	[scalerank<2] { text-size: 14; }
	[scalerank>=2] { text-size: 12; }
    text-transform: capitalize;
    text-placement: interior;
    text-fill: @label-water;
    text-halo-fill: fadeout(@water, @label-fadeout);
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;
    text-wrap-width: 60 * @scale-factor;
  }
}

#10m_lake_label[zoom>=6][zoom<=9] {
  ::text
    [zoom=6][scalerank<=2],
    [zoom=7][scalerank<=3],
    [zoom=8][scalerank<=4],
    [zoom=9][scalerank<=5],
    [zoom>=10] {
    text-face-name: @font-physical;
    text-name: '[name]';
    text-size: 12;
    text-transform: capitalize;
    text-placement: interior;
    text-fill: @label-water;
    text-halo-fill: fadeout(@water, @label-fadeout);
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
    text-wrap-width: 30 * @scale-factor;
  }
}

// carto don't support string operations in side url() function
@geo_region_marker: 'res/shield/' + @theme-name + '/poi-circle.svg';

#10m_georegion[zoom>=7][zoom<=9] {
  ::shield 
    [zoom=6][scalerank<=6],
    [zoom=7][scalerank<=7],
    [zoom=8][scalerank<=8],
    [zoom=9][scalerank<=9],
    [zoom>=10] {      
    shield-file: url(@geo_region_marker);
    shield-transform: scale(0.4, 0.4);
    shield-unlock-image: true;
    shield-face-name: @font-physical;
    shield-name: '[name]';
    shield-size: 12;
	shield-placement-type: simple;
    shield-placement: point;
    shield-text-dx: 8; shield-text-dy: 8;
    shield-placements: 'E,W';
    shield-fill: @label-physical;
    shield-halo-fill: @label-halo;
    shield-halo-radius: @smart-halo;
  }
}

@elevation_marker: 'res/shield/' + @theme-name + '/peak.svg';
#10m_elevation[zoom>=7][zoom<=9][name!=''] {
  ::shield 
    [zoom=6][scalerank<=6],
    [zoom=7][scalerank<=7],
    [zoom=8][scalerank<=8],
    [zoom=9][scalerank<=9],
    [zoom>=10] {      
    shield-file: url(@elevation_marker);
    shield-transform: scale(0.5, 0.5);
    shield-unlock-image: true;
    shield-face-name: @font-physical;
    shield-name: '[name]+"\n"+[elevation].replace("\.0","m")';
    shield-size: 12;
	shield-placement-type: simple;
    shield-placement: point;
    shield-text-dx: 8; shield-text-dy: 8;
    shield-placements: 'E,W';
    shield-fill: @label-physical;
    shield-halo-fill: @label-halo;
    shield-halo-radius: @smart-halo;
  }
}

// Admin labels

#label_admin0[zoom>=3][zoom<=8] {
  ::text {
    text-face-name: @font-heavy;
    text-name: '';
    [zoom=3] { text-size: 11; text-name: '[label_z3]'; }
    [zoom=4] { text-size: 14; text-name: '[label_z5]'; }
    [zoom=5] { text-size: 16; text-name: '[label_z6]'; }
    [zoom=6] { text-size: 22; text-name: '[label_z7]'; }
    [zoom>6] { text-size: 32; text-name: '[name]';
      text-character-spacing: 1;
      text-placements: 'X,28,24';
      text-placement-type: simple;
    }
    text-placement: point;
    text-fill: @label-admin0;
    text-label-position-tolerance: 16;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
    text-wrap-width: 80 * @scale-factor;
  }
}

// Extra small countries
#10m_country[zoom>=5][zoom<=10][tiny>=2]
[name!='Brunei'] [name!='Luxemburg'] [name!='Vanuatu']
[name!='Monaco']
{
  text-name:"[name]";
  text-face-name: @font-heavy;
  text-placement: interior;
  text-fill:  @label-admin0;
  text-halo-fill: @label-halo;
  text-halo-radius: @smart-halo;
  text-halo-rasterizer: @halo-quality;  
  text-label-position-tolerance: 16;
  text-wrap-width: 80 * @scale-factor;
  text-placement-type: simple;
  [zoom<=6] { text-size: 12; }
  [zoom>6][zoom<=7] { text-size: 16; }
  [zoom>7][zoom<=9] { text-size: 22; }
  [zoom>9] { text-size: 28; }
}

// Admin1 (only North America as for now)
#label_admin1[zoom>=4][zoom<=8] {
  ::text {
    text-face-name: @font-heavy;
    text-name: '';
    [zoom=4] { text-size: 12; text-name: '[label_z4]'; }
    [zoom=5] { text-size: 12; text-name: '[label_z5]'; }
    [zoom=6] { text-size: 14; text-name: '[label_z5]'; }
    [zoom>=7] { text-size: 16; text-name: '[label_z6]'; }

    text-placement: point;
    text-fill: @label-admin1;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
    text-label-position-tolerance: 10;
  }
}

@place_marker: 'res/shield/' + @theme-name + '/place-circle.svg';

// pre-calculated places
#place_static[zoom>=4][zoom<=9] {
  ::shield
  [layer=4][zoom=4],
  [layer=5][zoom=5],
  [layer=6][zoom=6],
  [layer=6][zoom=7],
  [layer=7][zoom=8],
  [layer=8][zoom=9], {  
    shield-file: url(@place_marker);
    shield-transform: scale(0.4, 0.4);
    shield-unlock-image: true;
    shield-face-name: @font-regular;
    shield-name: '';
    shield-placement-type: simple;
    shield-placement: point;
    shield-fill: @label-place;
    shield-halo-fill: @label-halo;
    shield-halo-radius: @smart-halo;
    
    [layer=4][zoom=4],
    [layer=5][zoom=5],
    [layer=6][zoom=6],
    [layer=6][zoom=7],
    [layer=7][zoom=8],
    [layer=8][zoom=9], {
      [font_size>=24] { 
        shield-size: 20; 
        shield-text-dx: 5; shield-text-dy: 5;
      }
      [font_size<24] { 
        shield-size: 16; 
        shield-text-dx: 4; shield-text-dy: 4; 
	    shield-transform: scale(0.35, 0.35);        
      }
      shield-name: '[name]';
      [justify='left'] {
        shield-placements: 'E,W';
      }
      [justify='right'] {
        shield-placements: 'W,E';
      }
	  shield-placements: 'NE,E,W';
    }
  }
//  debug-mode: collision;
}

#place_label[zoom>=10][zoom<=18] {
  text-name: "";
  text-face-name: @font-regular;
  text-fill: @label-place;
  text-halo-fill: @label-halo;
  text-halo-radius: @smart-halo;
  text-halo-rasterizer: @halo-quality;      
  text-placement: point;
  text-wrap-width: 100 * @scale-factor;
  text-label-position-tolerance: 16;
  text-min-distance: 16 * @scale-factor;
  [zoom>=15] { text-transform: @label-text-transform; }
  
  [type='city'][population>=10000][zoom>=8][zoom<=17] {
    text-name: "[name]"; 
    [zoom<=14] { text-size: 24; text-character-spacing: 0; }
    [zoom>=15] { text-size: 26; text-character-spacing: 4; }
  }
  [type='city'][population<10000][zoom>=9][zoom<=17] {
    text-name: "[name]";
    [zoom<=14] { text-size: 20; text-character-spacing: 1; }
    [zoom>=15] { text-size: 20; text-character-spacing: 2; }
  }
  [type='town'][zoom>=11][zoom<=18] {
    text-name: "[name]";
	[zoom<=14] { text-size: 18; }
    [zoom>=15] { text-size: 18; text-character-spacing: 2; } 
  }
  [type='suburb'][zoom>=13][zoom<=19],
  [type='village'][zoom>=13][zoom<=19]{
    text-name: "[name]";
    text-size: 16; text-character-spacing: 1;
  }
  [rank>=7][zoom>=14][zoom<=20] {
    text-name: "[name]";
    text-size: 16; text-character-spacing: 1;
  }
  
//  debug-mode: collision;
}

//// landuse

#landuse_label_gen1[zoom>=7][zoom<=10],
#landuse_label_gen0[zoom>=11][zoom<=13],
#landuse_label[zoom>=14]
{
  ::marker
  [zoom=9][area>20000000],
  [zoom=10][area>15000000],
  [zoom=11][area>2000000],
  [zoom=12][area>500000],
  [zoom=13][area>400000],
  [zoom=14][area>50000],
  [zoom=15][area>20000],
  [zoom=16][area>1000],
  [zoom>=17] {
    // No marker for these types
    [type!='water'][type!='reservoir']
    [type!='bay'][type!='sea'] {
      marker-placement: point;    
	  marker-file: url("res/maki/[maki]-18.svg");
      marker-transform: scale(0.9, 0.9);
//      [zoom<=13] { marker-file: url("res/maki/[maki]-12.svg"); }	  
      // Use square as general marker, which need smaller scale
      [maki='square'] { marker-transform: scale(0.4, 0.4); }
      // Rail icon uses fill incorrectly
      [maki!='rail'] { 
        marker-fill: @label-poi; 
        marker-line-color: @land;
        [maki='park'], [maki='park2'],
        [maki='pitch'], [maki='golf'],
        [maki='playground'], [maki='garden'] { 
          marker-fill: @label-park;  
        }
      }  
    }
  }
  
  ::text
  [zoom=9][area>40000000],
  [zoom=10][area>30000000],
  [zoom=11][area>8000000],
  [zoom=12][area>1000000],
  [zoom=13][area>600000],
  [zoom=14][area>80000],
  [zoom=15][area>20000],
  [zoom=16][area>1000],
  [zoom>=17] {
    [type='water'],[type='reservoir'],
    [type='bay'],[type='sea'] {   
      text-fill: @label-water;     
      text-face-name: @font-physical;
      text-halo-fill: fadeout(@water, @label-fadeout);
      text-placement-type: dummy;      
      text-dx: 0; text-dy: 0;   
      text-wrap-width: 30 * @scale-factor;      
    }
    
    [maki='park'], [maki='park2'],
    [maki='pitch'], [maki='golf'],
    [maki='playground'], [maki='garden'] { 
      text-fill: @label-park;  
    }
    
    text-placement: point;
    text-name:  "[name]"; 
//    text-name:  "[name]+' ('+[class]+','+[type]+')'";
    text-face-name: @font-poi;   
    text-fill: @label-poi;
    text-min-padding: 8;
//    text-min-distance: 2;
     
    [zoom>=14] { text-size: 12; }
    [zoom<=13] { text-size: 11; }    
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
    text-wrap-width: 60 * @scale-factor;
    text-line-spacing: -1;
    text-placement-type: simple;
    text-dx: 10;
    text-dy: 10;
    text-placements: 'S,E,W';
    text-name: "[name]";    
    
//    debug-mode: collision; 
  }
}


//// road labels

#road_label_gen1[zoom>=9][zoom<=11],
#road_label_gen0[zoom>=12][zoom<=15],
#road_label[zoom>=16] {
  [class='highway'][type='motorway'] {
    text-name: "[name]";
    text-placement: line; 
    text-max-char-angle-delta: 20;    
    text-clip: false;
    text-min-padding: 8;
    
    text-face-name: @font-motorway;
    text-fill: @label-motorway;
    // use default halo at higher levels, offset text rendering
    text-halo-radius: @smart-halo;
	text-halo-fill: @label-halo;
    text-halo-rasterizer: @halo-quality;
    // use road fill as halo at low levels
	[zoom>=15] {
      text-halo-radius: @smart-halo;
      text-halo-fill: @motorway-label-halo;
    }     
    // transprent tunnel
    [is_tunnel=1] { 
      text-opacity: 0.5; 
      text-halo-radius: 0;
    }
    
    text-label-position-tolerance: 30;
    
    [zoom<=17] { text-size: 14; text-spacing: 100;}
    [zoom>=18] { text-size: 18; text-spacing: 200; }   
    [zoom<=14][direction>0] { text-dx: 6;  text-dy: 6; }
    [zoom<=14][direction<0] { text-dx: -6;  text-dy: -6; }            
  }
  
  [class='highway'][type='primary'] {
    text-name: "[name]";
    text-placement: line; 
    text-max-char-angle-delta: 20;    
   text-clip: false;
    text-min-padding: 8;    

    text-face-name: @font-primary;
    text-fill: @label-primary;
    text-halo-radius: @smart-halo;
	text-halo-fill: @label-halo;
    text-halo-rasterizer: @halo-quality;        
	[zoom>=15] {
      text-halo-radius: @smart-halo;
      text-halo-fill: @primary-label-halo;
    } 
    [is_tunnel=1] { 
      text-opacity: 0.5; 
    }
    text-spacing: 150;
    text-label-position-tolerance: 30;
    
    [zoom<=17] { text-size: 13; }
    [zoom>=18] { text-size: 16; }
    // offset labeling
    [zoom<=14][direction>0] { text-dx: 6;  text-dy: 6; }
    [zoom<=14][direction<0] { text-dx: -6;  text-dy: -6; }            
  }  
  [class='highway'][type='secondary'] {
    text-name: "[name]";
    text-placement: line; 
    text-max-char-angle-delta: 20;    
   text-clip: false;
    text-min-padding: 8;    

    text-face-name: @font-primary;
    text-fill: @label-primary;
    text-halo-radius: @smart-halo;
	text-halo-fill: @label-halo;
    text-halo-rasterizer: @halo-quality;        
	[zoom>=17] {
      text-halo-radius: @smart-halo;
      text-halo-fill: @secondary-label-halo;
    }    
    [is_tunnel=1] { 
      text-opacity: 0.5; 
    }
    text-spacing: 120;
    
    [zoom<=17] { text-size: 12; }
    [zoom>=18] { text-size: 14; }

    [zoom<=14][direction>0] { text-dx: 6;  text-dy: 6; }
    [zoom<=14][direction<0] { text-dx: -6;  text-dy: -6; }
    [zoom>=15][zoom<=16][direction>0] { text-dx: 8;  text-dy: 8; }
    [zoom>=15][zoom<=16][direction<0] { text-dx: -8;  text-dy: -8; }
  }
  
  [class='highway'][type='minor'][zoom>=15] {
    text-name: "[name]";
    text-placement: line; 
    text-max-char-angle-delta: 20;    
   text-clip: false;
    text-min-padding: 8;

    text-face-name: @font-path;
    text-fill: @label-path;
    text-halo-radius: @smart-halo;
	text-halo-fill: @label-halo;
    text-halo-rasterizer: @halo-quality;        
    [is_tunnel=1] { 
      text-opacity: 0.5; 
    }
	[zoom>=18] {
      text-halo-radius: @smart-halo;
      text-halo-fill: @minor-label-halo;
    }    
    
    text-spacing: 120;    
    text-size: 12;

    [zoom<=17][direction>0] { text-dx: 7;  text-dy: 7; }
    [zoom<=17][direction<0] { text-dx: -7;  text-dy: -7; }
  }      
  
  [class='highway'][type='path'][zoom>=15],
  [class='highway'][type='proposed'][zoom>=15],    
  [class='highway'][type='pedestrian'][zoom>=15], {
    text-name: "[name]";
    text-placement: line; 
    text-max-char-angle-delta: 20;    
    text-clip: false;
    text-min-padding: 8;

    text-face-name: @font-path;
    text-fill: @label-path;
    text-halo-radius: @smart-halo;
	text-halo-fill: @label-halo;
    text-halo-rasterizer: @halo-quality;        
    [is_tunnel=1] { 
      text-opacity: 0.5; 
    }
    
    text-spacing: 120;    
    text-size: 12;

    [direction>0] { text-dx: 8;  text-dy: 8; }
    [direction<0] { text-dx: -8;  text-dy: -8; }
  }      
  
  [class='railway'][zoom>=14] {
    text-name: "[name]";
    text-placement: line; 
    text-max-char-angle-delta: 20;    
//    text-clip: false;
    text-min-padding: 8;

    [type='rail'],[type='subway'] { text-face-name: @font-motorway; }
    text-face-name: @font-path;
    text-fill: @label-rail;
    text-halo-radius: @smart-halo;
	text-halo-fill: @label-halo;
    text-halo-rasterizer: @halo-quality;        
    [is_tunnel=1][type!='subway'] { 
      text-opacity: 0.5; 
    }
    
    text-spacing: 200;    
    text-size: 12;

    [direction>0] { text-dx: 8;  text-dy: 8; }
    [direction<0] { text-dx: -8;  text-dy: -8; }
  }
  
  [class='ferry'][zoom>=14] {
    text-name: "[name]";
    text-placement: line; 
    text-max-char-angle-delta: 30;    
//    text-clip: false;
    text-min-padding: 8;

    text-face-name: @font-path;
    text-fill: @ferry-line;
    text-halo-radius: @smart-halo;
    text-halo-fill: fadeout(@water, @label-fadeout);
    text-halo-rasterizer: @halo-quality;      
    
	text-spacing: 300;
    text-size: 12;
    
    [direction>0] { text-dx: 10;  text-dy: 10; }
    [direction<0] { text-dx: -10;  text-dy: -10; }
  }  

//  debug-mode: collision; 

}

//// shields

@shield-marker: 'res/shield/' + @theme-name + '/motorway-[ref_length]ch-48px.png';

#shield_gen0[zoom>=7][zoom<=10][type='motorway'][ref_length<9],
#shield_gen1[zoom>=11][zoom<=14][ref_length<9],
#shield[zoom>=15][zoom<=17][ref_length<9]
{
  // Special shields
  [ref =~ "I [0-9]{1,2}"]{
    shield-file: url('res/shield/_us/interstate-2ch-48px.png');
    shield-transform: scale(0.4, 0.4);
    shield-fill: white;
    shield-name: '[ref].replace("I ", "")';
  }
  [ref =~ "I [0-9]{3}"]{
    shield-file: url('res/shield/_us/interstate-3ch-48px.png');
    shield-transform: scale(0.4, 0.4);
    shield-fill: white;
    shield-name: '[ref].replace("I ", "")';
  }
  [ref =~ "US ?[0-9]+"] {
    shield-file: url('res/shield/_us/us-cutout-48px.png');
    shield-transform: scale(0.45, 0.45);
    shield-name: '[ref].replace("US ?", "")';
    shield-text-dy: 1;
  }       

  [ref =~ "CA [0-9]+"] {
    shield-file: url('res/shield/_us/ca-48px.png');
    shield-transform: scale(0.4, 0.4);
    shield-name: '[ref].replace("CA ", "")';
    shield-fill: white;    
    shield-text-dy: 3;
  }
  [ref =~ "NY [0-9]+"] {
    shield-file: url('res/shield/_us/ny-48px.png');
    shield-transform: scale(0.4, 0.4);
    shield-name: '[ref].replace("NY ", "")';
    shield-fill: black;    
  }

  [ref =~ "M ?[0-9]{1,5}"] {
    shield-file: url('res/shield/_uk/M-[ref_length]ch-48px.png');
    shield-transform: scale(0.5, 0.5);
    shield-fill: white;    
  }
  [ref =~ "A ?[0-9]{1,5}"] {
    shield-file: url('res/shield/_uk/A-[ref_length]ch-48px.png');
    shield-transform: scale(0.5, 0.5);
    shield-fill: #FFD200;    
  }
  
  shield-file: url(@shield-marker);
  shield-transform: scale(0.5, 0.5);  
  
  shield-placement: line;
  shield-clip: false;
  shield-face-name: @font-shield;
  shield-name: '[ref]';
  shield-fill: @label-shield;
  shield-size: 9;
  [zoom>=11] { shield-spacing: 400; }
  shield-min-distance: 40;
  shield-min-padding: 8;

//  shield-allow-overlap: false;
  
}

