
//// physical

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
    text-wrap-width: 125 * @scale-factor;
  }
}

#10m_marine {
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

#10m_lake_label[zoom>=6] {
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

#10m_georegion[zoom>=7][zoom<16] {
  ::marker
    [zoom=6][scalerank<=6],
    [zoom=7][scalerank<=7],
    [zoom=8][scalerank<=8],
    [zoom=9][scalerank<=9],
    [zoom>=10] {
	marker-fill: @label-physical;
	marker-line-color: @label-halo;
    marker-line-width: @smart-halo;
    marker-file: url("marker/maki/circle-stroked-12.svg");
    marker-height: 7 + @smart-halo;    
  }
  ::text
    [zoom=6][scalerank<=6],
    [zoom=7][scalerank<=7],
    [zoom=8][scalerank<=8],
    [zoom=9][scalerank<=9],
    [zoom>=10] {
    text-face-name: @font-physical;
    text-name: '[name]';
    text-size: 12;
	text-placement-type: simple;
    text-placement: point;
    text-dx: 6; text-dy: 6;
    text-placements: 'E,W';
    text-fill: @label-physical;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;
  }
}

#10m_elevation[zoom>=7][name!=''] {
  ::marker
    [zoom=6][scalerank<=6],
    [zoom=7][scalerank<=7],
    [zoom=8][scalerank<=8],
    [zoom=9][scalerank<=9],
    [zoom>=10] {
    marker-file: url("marker/maki/triangle-12.svg");
	marker-fill: @label-physical;
	marker-line-color: @label-halo;
    marker-line-width: @smart-halo / @scale-factor;
  }
  ::text
    [zoom=6][scalerank<=6],
    [zoom=7][scalerank<=7],
    [zoom=8][scalerank<=8],
    [zoom=9][scalerank<=9],
    [zoom>=10] {
    text-face-name: @font-physical;
    text-name: '[name]+"\n"+[elevation].replace("\.0","m")';
    text-size: 12;
	text-placement-type: simple;
    text-placement: point;
    text-dx: 10; text-dy: 10;
    text-placements: 'E,W';
    text-fill: @label-physical;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
  }
}

//// countries

// NOTE:
//   - admin0 labels are adjusted manually
//   - zoom<=9 place labels are pre calculated using simulated
//     annealing and rendered using mapnik simple placement
//     still causes some render problems
//   - zoom>=10 labels are from osm and dynamiclly rendered

#label_admin0[zoom>=3][zoom<=8] {
  ::text {
    text-face-name: @font-heavy;
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
    //text-transform: uppercase;
    text-fill: @label-admin0;
    text-label-position-tolerance: 16;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
    text-wrap-width: 125 * @scale-factor;
  }
}

//// Small islands
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
  text-wrap-width: 100;
  text-placement-type: simple;
  [zoom<=6] { text-size: 12; }
  [zoom>6][zoom<=7] { text-size: 16; }
  [zoom>7][zoom<=9] { text-size: 22; }
  [zoom>9] { text-size: 28; }
}

#label_admin1[zoom>=4][zoom<=8] {
  ::text {
    text-face-name: @font-heavy;
    text-name: '';
    [zoom=4] { text-size: 12; text-name: '[label_z4]'; }
    [zoom=5] { text-size: 12; text-name: '[label_z5]'; }
    [zoom=6] { text-size: 14; text-name: '[label_z6]'; }
    [zoom>=7] { text-size: 16; text-name: '[label_z7]'; }

    text-placement: point;
    text-fill: @label-admin1;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
    text-label-position-tolerance: 10;
  }
}
//// static places
#place_static[zoom>=4][zoom<=9] {
  ::marker
  [layer=4][zoom=4],
  [layer=5][zoom=5],
  [layer=6][zoom=6],
  [layer=6][zoom=7],
  [layer=7][zoom=8],
  [layer=8][zoom=9], {
    [font_size>=24] { marker-width:5 + @smart-halo / @scale-factor;}
    [font_size<24] { marker-width:4 + @smart-halo / @scale-factor; }
    marker-fill: @label-place;
    marker-line-color: @label-halo;
    marker-line-width: @smart-halo / @scale-factor;
  }
  ::text {
    text-face-name: @font-regular;
    text-name: '';
    text-fill: @label-place;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
	text-placement-type: simple;
    text-placement: point;
    text-placements: 'NE,W,S';
    text-wrap-width: 250;
    [layer=4][zoom=4],
    [layer=5][zoom=5],
    [layer=6][zoom=6],
    [layer=6][zoom=7],
    [layer=7][zoom=8],
    [layer=8][zoom=9], {
      [font_size>=24] {text-size: 20; text-dx: 4; text-dy: 4;}
      [font_size<24] {text-size: 16; text-dx: 3; text-dy: 3; }
      text-name: '[name]';
    }
  }
}

#place_label[zoom>=10] {
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
    [zoom<=14] { text-size: 24; text-character-spacing: 2; }
    [zoom>=15] { text-size: 26; text-character-spacing: 4; }
  }
  [type='city'][population<10000][zoom>=9][zoom<=17] {
    text-name: "[name]";
    [zoom<=14] { text-size: 20; text-character-spacing: 1; }
    [zoom>=15] { text-size: 20; text-character-spacing: 2; }
  }
  [type='town'][zoom>=10][zoom<=18] {
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

}

//// landuse

#landuse_label_gen0[zoom>=7][zoom<=9],
#landuse_label_gen1[zoom>=10][zoom<=12],
#landuse_label[zoom>=13]
{
  ::text{
    text-name: "";
    text-face-name: @font-poi;
    text-size: 12;
    text-fill: @label-poi;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
    text-halo-rasterizer: @halo-quality;    
    text-wrap-width: 55 * @scale-factor;
    text-placement: point;
    text-min-distance: 32;
  }

  [zoom=7][area>2000000000],
  [zoom=8][area>500000000],
  [zoom=9][area>250000000],
  [zoom=10][area>80000000],
  [zoom=11][area>7500000],
  [zoom=12][area>2500000],
  [zoom=13][area>700000],
  [zoom=14][area>50000],
  [zoom=15][area>10000],
  [zoom=16][area>2500],
  [zoom>=17] {
    [type='nature_reserve'], [type='conservation'],
    [type='national_park'], {
      ::marker {
        marker-placement: point;
        marker-file: url("marker/maki/park-18.svg");
        marker-width: 18;
        marker-fill: @label-park;
        marker-line-color: @label-halo;
        marker-line-width: @smart-halo / @scale-factor;        
      }
	  ::text {
        text-placement-type: simple;
        text-dx: 13;
        text-dy: 13;
        text-placements: 'S,E,W';
        text-name: "[name]";
        text-fill: @label-park;
      }
      
    }
    [type='military'], [type='range'], {
      ::text {
        text-name: "[name]";
      }
    }
  }
  
  [zoom=9][area>20000000],
  [zoom=10][area>4000000],
  [zoom=11][area>1000000],
  [zoom=12][area>500000],
  [zoom=13][area>50000],
  [zoom>=14] {
    [type='aerodrome'],
    [type='railway'],
    [type='railroad'],
    [type='marina'], {
      ::marker {
        marker-placement: point;
        [type='railway'], [type='railroad'] { marker-file: url("marker/maki/rail-18.svg"); }
        [type='aerodrome'] { marker-file: url("marker/maki/airport-18.svg"); }
        [type='marina'] { marker-file: url("marker/maki/harbor-18.svg"); }
        marker-fill: @label-poi;
        marker-line-color: @label-halo;
//        marker-line-width: @smart-halo / @scale-factor;
      }
	  ::text {
        text-placement-type: simple;
      	text-dx: 13;
      	text-dy: 13;
      	text-placements: 'S,E,W';
  	  	text-name: "[name]";
      }
    }
  }

  [zoom=13][area>750000],
  [zoom=14][area>250000],
  [zoom=15][area>25000],
  [zoom=16][area>2500],
  [zoom>=17], {

    [type='forest'], [type='meadow'], [type='grass'], [type='grassland'],
    [type='wood'], [type='wetland'], [type='marsh'], [type='scrub'],
    [type='heath'], [type='park'],
    [type='playground'], [type='recreation_ground'], [type='pitch'],
    [type='golf_range'], [type='golf_course'], [type='miniature_golf'],
	[type='dog_park'], [type='theme_park'],
    [type='garden'], [type='village_green'], [type='greenspace'], {
      ::marker {
	    [type='playground']  { marker-file: url("marker/maki/playground-18.svg");  }
        [type='recreation_ground'], [type='pitch'], { marker-file: url("marker/maki/pitch-18.svg");  }
        [type='golf_range'], [type='golf_course'], [type='miniature_golf'], { marker-file: url("marker/maki/golf-18.svg");  }
        [type='garden'], [type='village_green'], [type='greenspace'],  { marker-file: url("marker/maki/garden-18.svg");  }
        marker-placement: point;
        marker-file: url("marker/maki/park2-18.svg");
        marker-fill: @label-park;
        marker-line-color: @label-halo;
        marker-line-width: @smart-halo / @scale-factor;        
      }
      ::text {
        text-placement-type: simple;
        text-dx: 13;
        text-dy: 13;
        text-placements: 'S,E';
        text-name: "[name]";
        text-fill: @label-park;
      }
    }

    // XXX: this is awkard but seems to be pretty fast
    [type='hospital'], [type='doctors'], [type='clinc'], [type='nursery'], [type='dentist'],
    [type='university'], [type='college'],
    [type='museum'], [type='library'], [type='theatre'], [type='cinema'],
    [type='arts_centre'], [type='gallery'],
    [type='school'], [type='post_office'],
    [type='townhall'], [type='public_building'], [type='courthouse'],
    [type='prison'], [type='police'],
    [type='fire_station'],
    [type='hotel'], [type='motel'],
    [type='zoo'],
    [type='stadium'], [type='sports_centre'],
    [type='cemetery'],
    [type='industrial'],
    [type='landfill'],
    [type='retail'], [type='commercial'],
    {
      ::marker {
        [type='hospital'], [type='doctors'], [type='clinc'], [type='nursery'], [type='dentist'] { marker-file: url("marker/maki/hospital-18.svg"); }
        [type='university'],[type='college'] { marker-file: url("marker/maki/college-18.svg"); }
        [type='museum'] { marker-file: url("marker/maki/museum-18.svg"); }
	    [type='arts_centre'], [type='gallery'] { marker-file: url("marker/maki/art-gallery-18.svg"); }
        [type='library'] { marker-file: url("marker/maki/library-18.svg"); }
        [type='theatre'] { marker-file: url("marker/maki/theatre-18.svg"); }
        [type='cinema'] { marker-file: url("marker/maki/cinema-18.svg"); }
        [type='school'] { marker-file: url("marker/maki/school-18.svg"); }
        [type='post_office'] { marker-file: url("marker/maki/post-18.svg"); marker-height: 7; }
 	    [type='townhall'],[type='public_building'], [type='courthouse'] { marker-file: url("marker/maki/town-hall-18.svg"); }
	    [type='prison'], [type='police'] { marker-file: url("marker/maki/police-18.svg"); }
	    [type='hotel'], [type='motel'], { marker-file: url("marker/maki/town-18.svg"); }
	    [type='fire_station'] { marker-file: url("marker/maki/fire-station-18.svg"); }
        [type='zoo'] { marker-file: url("marker/maki/zoo-18.svg"); }
	    [type='stadium'], [type='sports_centre'] { marker-file: url("marker/maki/soccer-18.svg"); }
	    [type='cemetery'] { marker-file: url("marker/maki/cemetery-18.svg"); }
	    [type='industrial'] { marker-file: url("marker/maki/industrial-18.svg"); }
	    [type='landfill'] { marker-file: url("marker/maki/waste-basket-18.svg"); }
    	[type='retail'], [type='commercial'] { marker-file: url("marker/maki/grocery-18.svg"); }
        marker-placement: point;
        marker-fill: @label-poi;
        marker-line-color: @label-halo;
        marker-line-width: @smart-halo / @scale-factor;        
      }
      ::text {
        text-placement-type: simple;
        text-dx: 11;
        text-dy: 11;
        text-placements: 'S,E,W';
        text-name: "[name]";
        text-fill: @label-poi;
      }
    }

 	::marker {
      marker-file: url("marker/general/poi_general.svg");
      marker-placement: point;
      marker-fill: @label-poi;
      marker-line-color: @label-halo;
      marker-line-width: @smart-halo / @scale-factor;        
    }
    ::text {
      text-placement-type: simple;
      text-dx: 10;
      text-dy: 10;
      text-placements: 'E,W,S';
      text-name: "[name]";
      text-fill: @label-poi;
    }    
    
  }
}


//// road labels
// NOTE
//  for thin lines label is not drawn on the link
//  like most web maps...
//#road_label_gen0[zoom>=10][zoom<=12][class='highway'],
#road_label_gen1[zoom>=12][zoom<=15][class='highway'],
#road_label[zoom>=16][class='highway'] {
  [type='motorway'], [type='trunk'] {
    text-clip: false;
    text-face-name: @font-motorway;
    text-fill: @label-motorway;
    text-halo-radius: @smart-halo;
	text-halo-fill: fadeout(@motorway-fill,  @label-fadeout);
    text-halo-rasterizer: @halo-quality;        
    text-size: 14;
    [zoom<=17] { text-size: 14; }
    [zoom>=18] { text-size: 18; }
    text-name: "[name]";
    text-placement: line;
  	text-spacing: 160;
    text-label-position-tolerance: 16;
    text-max-char-angle-delta: 20;
    [tunnel=1] { 
      text-opacity: 0.5; 
      text-halo-radius: 0;
    }
    [zoom<=14][direction>0] { text-dx: 6;  text-dy: 6; }
    [zoom<=14][direction<0] { text-dx: -6;  text-dy: -6; }    
  }
  [type='primary'][zoom>=11],
   {
    text-clip: false;
    text-face-name: @font-primary;
    text-fill: @label-primary;
    text-halo-radius: @smart-halo;
    text-halo-fill: fadeout(@primary-fill,  @label-fadeout);
    text-halo-rasterizer: @halo-quality;        
    text-size: 14;
    [zoom<=17] { text-size: 13; }
    [zoom>=18] { text-size: 16; }
    text-name: "[name]";
    text-placement: line;
  	text-spacing: 140;
    text-label-position-tolerance: 16;
    text-max-char-angle-delta: 20;
    [zoom<=14][direction>0] { text-dx: 6;  text-dy: 6; }
    [zoom<=14][direction<0] { text-dx: -6;  text-dy: -6; }    
  }
  [type='secondary'][zoom>=13],
  [type='tertiary'][zoom>=13] {
    text-clip: false;
    text-face-name: @font-primary;
    text-fill: @label-primary;
  	text-halo-radius: @smart-halo;
	text-halo-fill: @label-halo;
    text-halo-rasterizer: @halo-quality;          
	[zoom>=17] {
      text-halo-radius: @smart-halo;
      text-halo-fill: @secondary-fill;
    }
    text-size: 12;
    [zoom<=17] { text-size: 12; }
    [zoom>=18] { text-size: 14; }
    text-name: "[name]";
    text-placement: line;
  	text-spacing: 120;
    text-label-position-tolerance: 16;
    text-max-char-angle-delta: 20;
    [zoom<=14][direction>0] { text-dx: 6;  text-dy: 6; }
    [zoom<=14][direction<0] { text-dx: -6;  text-dy: -6; }
    [zoom>=15][zoom<=16][direction>0] { text-dx: 8;  text-dy: 8; }
    [zoom>=15][zoom<=16][direction<0] { text-dx: -8;  text-dy: -8; }
  }
}

#road_label[zoom>=16][rank>=11][class='highway'] {
  text-clip: false;
  text-face-name: @font-path;
  text-size: 12;
  text-fill: @label-path;
  text-halo-fill: @label-halo;
  text-halo-radius: @smart-halo;
  text-halo-rasterizer: @halo-quality;      
  text-allow-overlap: false;
  text-name: "[name]";
  text-placement: line;
  text-label-position-tolerance: 16;
  text-max-char-angle-delta: 30;
  text-spacing: 120;
  text-min-path-length: 50;
  [zoom>=15][zoom<=17][direction>0] { text-dx: 7;  text-dy: 7; }
  [zoom>=15][zoom<=17][direction<0] { text-dx: -7;  text-dy: -7; }
  [zoom>=18][direction>0] { text-dx: 9;  text-dy: 9; }
  [zoom>=18][direction<0] { text-dx: -9;  text-dy: -9; }

}

#road_label[zoom>=16][class='ferry'] {
  text-clip: false;
  text-face-name: @font-path;
  text-size: 12;
  text-fill: @label-water;
  text-halo-fill: fadeout(@water, @label-fadeout);
  text-halo-radius: @smart-halo;
  text-halo-rasterizer: @halo-quality;      
  text-allow-overlap: false;
  text-name: "[name]";
  text-placement: line;
  text-label-position-tolerance: 16;
  text-max-char-angle-delta: 30;
  text-spacing: 300;
  text-min-path-length: 50;
  [direction>0] { text-dx: 10;  text-dy: 10; }
  [direction<0] { text-dx: -10;  text-dy: -10; }
}

//// shields

#shield_gen0[zoom>=8][zoom<=15][reflen<=9],
#shield_all[zoom>=16][zoom<=17][reflen<=9]
{
  [type='motorway'],[type='trunk'] {
    shield-file: url('shield/motorway-4.svg');

    shield-placement: line;
    shield-clip: false;
    shield-face-name: @font-shield;
    shield-name: '[ref]';
    shield-fill: @label-shield;
    shield-size: 9;
    shield-allow-overlap: false;
    shield-spacing: 300;

    [reflen=5] { shield-file: url('shield/motorway-5.svg'); }
    [reflen=6] { shield-file: url('shield/motorway-6.svg'); }
    [reflen=7] { shield-file: url('shield/motorway-7.svg'); }
    [reflen>=8] { shield-file: url('shield/motorway-8.svg'); }

    [zoom<=14] { shield-min-distance: 100; }
    [zoom=15] { shield-min-distance: 120; }
    [zoom=16] { shield-min-distance: 140; }
  }
  
  [type='primary'][zoom>=12], [type='secondary'][zoom>=16] {
    shield-file: url('shield/motorway-4.svg');

    
    shield-placement: line;
    shield-clip: false;
    shield-face-name: @font-shield;
    shield-name: '[ref]';
    shield-fill: @label-shield;
    shield-size: 9;
    shield-allow-overlap: false;
    shield-spacing: 300;

    [reflen=5] { shield-file: url('shield/motorway-5.svg'); }
    [reflen=6] { shield-file: url('shield/motorway-6.svg'); }
    [reflen=7] { shield-file: url('shield/motorway-7.svg'); }
    [reflen>=8] { shield-file: url('shield/motorway-8.svg'); }

    [zoom<=14] { shield-min-distance: 100; }
    [zoom=15] { shield-min-distance: 120; }
    [zoom=16] { shield-min-distance: 140; }
    [zoom>=17] { shield-min-distance: 160; }
  }
}

/*
#shield_gen0[zoom>=8][zoom<=15][reflen<=9],
#shield_all[zoom>=16][zoom<=17][reflen<=9]
{
  [type='motorway'],[type='trunk'] {
    shield-file: url('shield/motorway_dark-4.svg');

    shield-placement: line;
    shield-clip: false;
    shield-face-name: @font-shield;
    shield-name: '[ref]';
    shield-fill: @label-shield;
    shield-size: 9;
    shield-allow-overlap: false;
    shield-spacing: 300;

    [reflen=5] { shield-file: url('shield/motorway_dark-5.svg'); }    
    [reflen=6] { shield-file: url('shield/motorway_dark-6.svg'); }
    [reflen=7] { shield-file: url('shield/motorway_dark-7.svg'); }
    [reflen>=8] { shield-file: url('shield/motorway_dark-8.svg'); }

    [zoom<=14] { shield-min-distance: 100; }
    [zoom=15] { shield-min-distance: 120; }
    [zoom=16] { shield-min-distance: 140; }
  }
  [type='primary'][zoom>=12], [type='secondary'][zoom>=16] {
    shield-file: url('shield/motorway_dark-4.svg');
    
    shield-placement: line;
    shield-clip: false;
    shield-face-name: @font-shield;
    shield-name: '[ref]';
    shield-fill: @label-shield;
    shield-size: 9;
    shield-allow-overlap: false;
    shield-spacing: 300;

    [reflen=5] { shield-file: url('shield/motorway_dark-5.svg'); }    
    [reflen=6] { shield-file: url('shield/motorway_dark-6.svg'); }
    [reflen=7] { shield-file: url('shield/motorway_dark-7.svg'); }
    [reflen>=8] { shield-file: url('shield/motorway_dark-8.svg'); }

    [zoom<=14] { shield-min-distance: 100; }
    [zoom=15] { shield-min-distance: 120; }
    [zoom=16] { shield-min-distance: 140; }
    [zoom>=17] { shield-min-distance: 160; }
  }
//  image-filters: 'invert(),gray()';
}
*/