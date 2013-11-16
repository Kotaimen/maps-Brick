//// physical

#label_continent[zoom<=4] {
  ::text {
    text-face-name: @font-physical;
    text-name: '[name]';
	text-size: 16;
    text-placement: point;
    text-character-spacing: 2;
    text-fill: @label-admin0;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
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
    text-halo-fill: @water;
    text-halo-radius: @smart-halo;
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
    text-halo-fill: fadeout(@water, 25%);
    text-halo-radius: @smart-halo;
    text-wrap-width: 30 * @scale-factor;
  }
}

#10m_georegion[zoom>=7] {
  ::marker
    [zoom=6][scalerank<=6],
    [zoom=7][scalerank<=7],
    [zoom=8][scalerank<=8],
    [zoom=9][scalerank<=9],
    [zoom>=10] {
	marker-fill: @label-physical;
	marker-line-color: @label-halo;
    marker-line-width: @smart-halo / @scale-factor;
    marker-height: 4 + @smart-halo;
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
    text-dx: 5; text-dy: 5;
    text-placements: 'E,W';
    text-fill: @label-physical;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
  }
}

#10m_elevation[zoom>=7][name!=''] {
  ::marker
    [zoom=6][scalerank<=6],
    [zoom=7][scalerank<=7],
    [zoom=8][scalerank<=8],
    [zoom=9][scalerank<=9],
    [zoom>=10] {
    marker-file: url("marker/poi_peak.svg");
	marker-fill: @label-physical;
	marker-line-color: @label-halo;
    marker-line-width: @smart-halo / @scale-factor;
    marker-height: 5 + @smart-halo;
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
    text-dx: 5; text-dy: 5;
    text-placements: 'E,W';
    text-fill: @label-physical;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo;
  }
}

//// countries

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
    text-wrap-width: 125 * @scale-factor;
  }
}

//// Small islands

#10m_country[zoom>=5][zoom<=10][tiny>=2][pop_est<400000]
[name!='Brunei'] [name!='Luxemburg'] [name!='Vanuatu']
[name!='Monaco']
{
  text-name:"[name]";
  text-face-name: @font-heavy;
  text-placement: interior;
  text-fill:  @label-admin0;
  text-halo-fill: @label-halo;
  text-halo-radius: @smart-halo;
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
    text-halo-radius: @smart-halo / @scale-factor;
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
    marker-line-width: @smart-halo;
  }
  ::text {
    text-face-name: @font-regular;
    text-name: '';
    text-fill: @label-place;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo / @scale-factor;
	text-placement-type: simple;
    text-placement: point;
    text-placements: 'NE,SW,SE,W,N,E';
    [layer=4][zoom=4],
    [layer=5][zoom=5],
    [layer=6][zoom=6],
    [layer=6][zoom=7],
    [layer=7][zoom=8],
    [layer=8][zoom=9], {
      [font_size>=24] {text-size: 20; text-dx: 5; text-dy: 5;}
      [font_size<24] {text-size: 16; text-dx: 4; text-dy: 4; }
      text-name: '[name]';
    }
  }
}

#place_label[zoom>=10] {
  text-name: "";
  text-face-name: @font-regular;
  text-fill: @label-place;
  text-halo-fill: @label-halo;
  text-halo-radius: @smart-halo / @scale-factor;
  text-placement: point;
  text-wrap-width: 100 * @scale-factor;
  text-label-position-tolerance: 16;
  text-min-distance: 16;
  [type='city'][population>=10000][zoom>=8][zoom<=15] {
    text-name: "[name]";
	[zoom<=12] { text-size: 24; text-character-spacing: 1;}
    [zoom=13] { text-size: 24; text-character-spacing: 2; }
    [zoom=14] { text-size: 24; text-character-spacing: 3; }
    [zoom>=15] { text-size: 26; text-character-spacing: 4; }
//    text-fill: green;
  }
  [type='city'][population<10000][zoom>=9][zoom<=15] {
    text-name: "[name]";
	[zoom<=12] { text-size: 20; }
    [zoom=14] { text-size: 20; text-character-spacing: 2; }
    [zoom>=15] { text-size: 20; text-character-spacing: 3; }
//    text-fill: cyan;
  }
  [type='town'][zoom>=10][zoom<=17] {
    text-name: "[name]";
	[zoom<=12] { text-size: 18; }
    [zoom>=13] { text-size: 18; text-character-spacing: 2; }
//    text-fill: blue;
  }
  [type='suburb'][zoom>=13][zoom<=18],
  [type='village'][zoom>=13][zoom<=18]{
    text-name: "[name]";
    text-size: 16; text-character-spacing: 1;
//    text-fill: red;
  }
  [rank>=7][zoom>=14][zoom<=18] {
    text-name: "[name]";
    text-size: 16; text-character-spacing: 1;
//    text-fill: orange;
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
    text-wrap-width: 55 * @scale-factor;
    text-placement: point;
    text-min-distance: 8;
  }

  [zoom=7][area>2000000000],
  [zoom=8][area>500000000],
  [zoom=9][area>250000000],
  [zoom=10][area>80000000],
  [zoom=11][area>7500000],
  [zoom=12][area>5000000],
  [zoom=13][area>700000],
  [zoom=14][area>50000],
  [zoom=15][area>10000],
  [zoom=16][area>2500],
  [zoom>=17] {
    [type='nature_reserve'], [type='conservation'],
    [type='national_park'], {
      ::marker {
        marker-placement: point;
        marker-file: url("marker/tree-1.svg");
        marker-width: 11;
        marker-height: 13;
        marker-fill: @label-park;
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
        [type='railway'], [type='railroad'] { marker-file: url("marker/rail.svg"); }
        [type='aerodrome'] { marker-file: url("marker/airport.svg"); }
        [type='marina'] { marker-file: url("marker/anchor.svg"); }
        marker-width: 12;
        marker-height: 13;
      }
	  ::text {
        text-placement-type: simple;
      	text-dx: 13;
      	text-dy: 13;
      	text-placements: 'S,E';
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
	    [type='playground'], [type='recreation_ground'], [type='pitch'], { marker-file: url("marker/pitch.svg");  }
        [type='golf_range'], [type='golf_course'], [type='miniature_golf'], { marker-file: url("marker/golf.svg");  }
        [type='garden'], [type='village_green'], [type='greenspace'],  { marker-file: url("marker/garden.svg");  }

        marker-placement: point;
        marker-file: url("marker/tree-1.svg");
        marker-width: 11;
        marker-height: 13;
        marker-fill: @label-park;
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

    [type='hospital'], [type='doctors'], [type='clinc'], [type='nursery'], [type='dentist']
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
    [type='retail'], [type='commercial'], {
      ::marker {
        [type='hospital'], [type='doctors'], [type='clinc'], [type='nursery'], [type='dentist'] { marker-file: url("marker/hospital.svg"); }
        [type='university'],[type='college'] { marker-file: url("marker/college.svg"); }
        [type='museum'] { marker-file: url("marker/museum.svg"); }
	    [type='arts_centre'], [type='gallery'] { marker-file: url("marker/art-gallery.svg"); }
        [type='library'] { marker-file: url("marker/library.svg"); }
        [type='theatre'] { marker-file: url("marker/theatre.svg"); }
        [type='cinema'] { marker-file: url("marker/cinema.svg"); }
        [type='school'] { marker-file: url("marker/school.svg"); }
        [type='post_office'] { marker-file: url("marker/post.svg"); marker-height: 7; }
 	    [type='townhall'],[type='public_building'], [type='courthouse'] { marker-file: url("marker/town-hall.svg"); }
	    [type='prison'], [type='police'] { marker-file: url("marker/police.svg"); }
	    [type='hotel'], [type='motel'], { marker-file: url("marker/lodging.svg"); }
	    [type='fire_station'] { marker-file: url("marker/fire-station.svg"); }
        [type='zoo'] { marker-file: url("marker/giraffe.svg"); }
	    [type='stadium'], [type='sports_centre'] { marker-file: url("marker/soccer.svg"); }
	    [type='cemetery'] { marker-file: url("marker/cemetery.svg"); }
	    [type='industrial'] { marker-file: url("marker/industrial-building.svg"); }
	    [type='landfill'] { marker-file: url("marker/trash.svg"); }
    	[type='retail'], [type='commercial'] { marker-file: url("marker/commerical-building.svg"); }
        marker-placement: point;
        marker-width: 11;
        marker-height: 11;
        marker-fill: @label-poi;
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
  }

}

//// road labels
#road_label_gen1[zoom>=10][zoom<=12],
#road_label[zoom>=13] {
  [type='motorway'], [type='trunk'] {
    text-clip: false;
    text-face-name: @font-motorway;
    text-fill: @label-motorway;
    text-halo-radius: 1;
	text-halo-fill: fadeout(@motorway-fill, 50%) ;    
    [zoom<=17] { text-size: 14; }
    [zoom>=18] { text-size: 18; }
    text-name: "[name]";
    text-placement: line;
    text-min-distance: 16;
    text-label-position-tolerance: 16;
    text-max-char-angle-delta: 20;
  }
  [type='primary'], [type='secondary'] {
    text-clip: false;
    text-face-name: @font-primary;
    text-fill: @label-primary;
    text-halo-radius: 1;
	text-halo-fill: fadeout(@primary-fill, 50%) ;    
    [zoom<=17] { text-size: 14; }
    [zoom>=18] { text-size: 16; }
    text-name: "[name]";
    text-placement: line;
    text-min-distance: 16;
    text-label-position-tolerance: 16;
    text-max-char-angle-delta: 20;
  }  
  [type='tertiary'][zoom>=13] {
    text-clip: false;
    text-face-name: @font-primary;
    text-fill: @label-primary;
    text-halo-radius: 1;
	text-halo-fill: @label-halo;
    [zoom<=17] { text-size: 12; }
    [zoom>=18] { text-size: 14; }
    text-name: "[name]";
    text-placement: line;
    text-min-distance: 16;
    text-label-position-tolerance: 16;
    text-max-char-angle-delta: 20;
    [zoom<=14][direction>0] { text-dx: 10;  text-dy: 10; }
    [zoom<=14][direction<0] { text-dx: -10;  text-dy: -10; }      
    [zoom>=15][zoom<=17][direction>0] { text-dx: 12;  text-dy: 12; }
    [zoom>=15][zoom<=17][direction<0] { text-dx: -12;  text-dy: -12; }      
	[zoom>=18] { text-halo-fill: fadeout(@primary-fill, 50%) ;  }
  }    
}

#road_label[zoom>=16][rank>=11], {
  text-clip: false;  
  text-face-name: @font-path;
  text-size: 14;
  text-halo-fill: @label-halo;
  text-fill: @label-path;
  text-halo-radius: 1;
  text-allow-overlap: false;
  text-name: "[name]";
  text-placement: line;
  text-min-distance: 16;
  text-label-position-tolerance: 16;
  text-max-char-angle-delta: 20;
  
  [zoom>=15][zoom<=17][direction>0] { text-dx: 10;  text-dy: 10; }
  [zoom>=15][zoom<=17][direction<0] { text-dx: -10;  text-dy: -10; }      
  [zoom>=18][direction>0] { text-dx: 13;  text-dy: 13; }
  [zoom>=18][direction<0] { text-dx: -13;  text-dy: -13; }  
}
