
///////////////////////////////////////////////////
// Highlevel country/state names
///////////////////////////////////////////////////

#labels_continents[zoom<4] {
  ::text {
    text-face-name: @label-font-italic;
    text-name: '[name]';
	text-size: 14;
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
    text-fill: @label-color-blue;
    text-halo-fill: @water-color;
    text-halo-radius: @smart-halo-raidus;
    text-wrap-width: 60 * scale_factor;
  }
}


#labels_admin0[zoom<=8] {
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
    text-wrap-width: 125 * @scale-factor;
//    text-allow-overlap: true;
  }
}

///// Small islands
#10m_countries[zoom>4][zoom<=10][tiny>=2][pop_est<40000]
[name!='Brunei'] [name!='Luxemburg'] [name!='Vanuatu'] [name!='Burnei']
[name!='Monaco'] 
{
  text-name:"[name]";
  text-face-name: @label-font-heavy;
  text-placement: interior;
  text-fill:  @label-color;
  text-halo-fill: @label_halo-color;
  text-halo-radius: @smart-halo-raidus;
  text-label-position-tolerance: 16;
  text-wrap-width: 100;
  text-placement-type: simple;
  [zoom<=6] { text-size: 12; }
  [zoom>6][zoom<=7] { text-size: 16; }
  [zoom>7][zoom<=9] { text-size: 22; }
  [zoom>9] { text-size: 28; }
}

#labels_admin1[zoom<=8] {
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

#labels_places_gen0[zoom<=6] {
  ::marker
    ['zoom_start'<=4][zoom=4],
    ['zoom_start'<=5][zoom=5],
    ['zoom_start'<=6][zoom=6],
  {
    [font_size=18] { marker-width:5 + @smart-halo-raidus / @scale-factor;}
    [font_size=12] { marker-width:4 + @smart-halo-raidus / @scale-factor;}
	marker-fill: @label-color;
	marker-line-color: @land-color;
    marker-line-width: @smart-halo-raidus/@scale-factor;    
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
// "Dymo" static placed names
///////////////////////////////////////////////////

#labels_places_gen1_names
{
  ::text
  [zoom=7][layer=7],
  [zoom=8][layer=8],
  [zoom=9][layer=9],
  {
//    ::DEBUG { polygon-opacity:0.5; polygon-fill: orange; }
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
    [font_size<=18] { marker-width: 4 + @smart-halo-raidus / @scale-factor; }
    [font_size>18] { marker-width: 5 + @smart-halo-raidus / @scale-factor; }
    marker-fill:@label-color;
    marker-line-color: @land-color;
    marker-line-width: @smart-halo-raidus/@scale-factor;
//    marker-allow-overlap: true;
  }
}

///////////////////////////////////////////////////
// OSM dynamic place names
///////////////////////////////////////////////////

#labels_places[zoom>=10][zoom<=17] {
  text-clip: false;
  text-face-name: @label-font;
  text-allow-overlap: false;
  text-name: "";
  text-fill: @label-color;
  text-halo-fill: @land-color;
  text-halo-radius: 0 + @smart-halo-raidus;
  text-placement: point;
  text-size: 16;
  text-min-distance: 14;
  text-wrap-width: 100 * @scale-factor;

  text-line-spacing: -6; // Avenir Next font line spacing is too large

  [zoom<=11] {
  	[place_priority=0] {
    	text-name: "[place_name]";
      	text-size: 32;
    }
  	[place_priority=1] {
    	text-name: "[place_name]";
      	text-size: 18;
    }
    [place_priority=2] {
    	text-name: "[place_name]";
      	text-size: 16;
    }
  }
  [zoom>=12][zoom<14] {
  	[place_priority=0] {
    	text-name: "[place_name]";
      	text-size: 36;
		text-character-spacing: 2;
    }
  	[place_priority=1] {
    	text-name: "[place_name]";
      	text-size: 22;
		text-character-spacing: 1;
    }
    [place_priority=2] {
    	text-name: "[place_name]";
      	text-size: 18;
    }
  }
  [zoom>=14] {
  	[zoom=14][place_priority=0] {
    	text-name: "[place_name]";
      	text-size: 42;
		text-character-spacing: 4;
    }
  	[place_priority=1] {
    	text-name: "[place_name]";
      	text-size: 32;
		text-character-spacing: 2;
    }
  	[place_priority=2] {
    	text-name: "[place_name]";
      	text-size: 26;
		text-character-spacing: 1
    }
  	[place_priority=3] {
    	text-name: "[place_name]";
      	text-size: 18;
		text-character-spacing: 1;
    }
  }
}


///////////////////////////////////////////////////
// OSM Land Usage Labels
///////////////////////////////////////////////////

#labels_landusage[zoom>6] {
  text-clip: false;
  text-face-name: @label-font-alt;
  text-allow-overlap: false;
  text-name: "";
  text-size: 12;
  text-fill: @label-color-alt;
  text-halo-fill: @land-color;
  text-halo-radius: @smart-halo-raidus;
  text-wrap-width: 55 * @scale-factor;
  text-placement: point;
  text-min-distance: 8;
  text-line-spacing: -3;

  [zoom=6][way_area>2000000000],
  [zoom=7][way_area>1000000000],
  [zoom=8][way_area>500000000],
  [zoom=9][way_area>250000000],
  [zoom=10][way_area>80000000],
  [zoom=11][way_area>7500000],
  [zoom=12][way_area>5000000],
  [zoom=13][way_area>700000],
  [zoom=14][way_area>50000],
  [zoom=15][way_area>10000],
  [zoom=16][way_area>2500],
  [zoom>=17],
  {
    [landusage_type='forest'],
    [landusage_type='grass'],
    [landusage_type='wood'],
    [landusage_type='wetland'],
    [landusage_type='golf_course'],
    [landusage_type='nature_reserve'],
    [landusage_type='park'],
    [landusage_type='garden'],
    [landusage_type='conservation'],
    {
      ::marker {
        marker-placement: point;
        marker-file: url("marker/tree-1.svg");
        [landusage_type='wood'] { marker-file: url("marker/tree-2.svg"); }
        [landusage_type='garden'] { marker-file: url("marker/garden.svg"); }
        [landusage_type='golf_course'] { marker-file: url("marker/golf.svg"); }
        marker-width: 11;
        marker-height: 13;
        marker-fill: @label-color-green;
      }
	  text-placement-type: simple;
      text-dx: 13;
      text-dy: 13;
      text-placements: 'S,E,W';
  	  text-name: "[landusage_name]";
      text-fill: @label-color-green;
    }
  }

  [zoom=6][way_area>2000000000],
  [zoom=7][way_area>1000000000],
  [zoom=8][way_area>500000000],
  [zoom=9][way_area>250000000],
  [zoom=10][way_area>50000000],
  [zoom=11][way_area>5000000],
  [zoom=12][way_area>500000],
  [zoom=13][way_area>100000],
  [zoom=14][way_area>50000],
  [zoom=15][way_area>10000],
  [zoom=16][way_area>2500],
  [zoom>=17],
  {
    [landusage_type='reservoir'],
    [landusage_type='water'],
    [landusage_type='pond'],
    [landusage_type='basin'],
    [landusage_type='salt_water'],
    {
	  text-placement-type: dummy;
  	  text-name: "[landusage_name]";
      text-face-name: @label-font-italic;
      text-fill: @label-color-blue;
    }
  }

  [landusage_type='aerodrome'],
  [landusage_type='railway'],
  [landusage_type='railroad'],
  [landusage_type='marina'],
  {
    [zoom=9][way_area>20000000],
    [zoom=10][way_area>4000000],
  	[zoom=11][way_area>1000000],
  	[zoom=12][way_area>500000],
    [zoom=13][way_area>50000],
    [zoom>=14]
    {
      ::marker {
        marker-placement: point;
        [landusage_type='railway'], [landusage_type='railroad'] { marker-file: url("marker/rail.svg"); }
        [landusage_type='aerodrome'] { marker-file: url("marker/airport.svg"); }
        [landusage_type='marina'] { marker-file: url("marker/anchor.svg"); }

        marker-width: 12;
        marker-height: 13;
        marker-fill: @label-color;
      }
	  text-placement-type: simple;
      text-dx: 13;
      text-dy: 13;
      text-placements: 'S,E,W';
  	  text-name: "[landusage_name]";
      text-fill: @label-color;
    }
  }

  [landusage_type='hospital'], [landusage_type='doctors'], [landusage_type='clinc'], [landusage_type='nursery'], [landusage_type='dentist']
  [landusage_type='university'], [landusage_type='college'],
  [landusage_type='museum'], [landusage_type='library'], [landusage_type='theatre'], [landusage_type='cinema'],
  [landusage_type='arts_centre'], [landusage_type='gallery'],
  [landusage_type='school'], [landusage_type='post_office'],
  [landusage_type='townhall'], [landusage_type='public_building'], [landusage_type='courthouse'],
  [landusage_type='prison'], [landusage_type='police'],
  [landusage_type='fire_station'],
  [landusage_type='hotel'], [landusage_type='motel'],
  [landusage_type='zoo'],
  [landusage_type='stadium'], [landusage_type='sports_centre'],
  [landusage_type='recreation_ground'], [landusage_type='pitch'], [landusage_type='playground'],
  [landusage_type='cemetery'],
  [landusage_type='industrial'],
  [landusage_type='landfill'],
  [landusage_type='retail'], [landusage_type='commercial']
  {
   [zoom=13][way_area>500000],
   [zoom=14][way_area>100000],
   [zoom=15][way_area>25000],
   [zoom=16][way_area>2500],
   [zoom>=17],
   {
      ::marker {
        [landusage_type='hospital'], [landusage_type='doctors'], [landusage_type='clinc'], [landusage_type='nursery'], [landusage_type='dentist'] { marker-file: url("marker/hospital.svg"); }
        [landusage_type='university'],[landusage_type='college'] { marker-file: url("marker/college.svg"); }
        [landusage_type='museum'] { marker-file: url("marker/museum.svg"); }
	    [landusage_type='arts_centre'], [landusage_type='gallery'] { marker-file: url("marker/art-gallery.svg"); }
        [landusage_type='library'] { marker-file: url("marker/library.svg"); }
        [landusage_type='theatre'] { marker-file: url("marker/theatre.svg"); }
        [landusage_type='cinema'] { marker-file: url("marker/cinema.svg"); }
        [landusage_type='school'] { marker-file: url("marker/school.svg"); }
        [landusage_type='post_office'] { marker-file: url("marker/post.svg"); marker-height: 7; }
 	    [landusage_type='townhall'],[landusage_type='public_building'], [landusage_type='courthouse'] { marker-file: url("marker/town-hall.svg"); }
	    [landusage_type='prison'], [landusage_type='police'] { marker-file: url("marker/police.svg"); }
	    [landusage_type='hotel'], [landusage_type='motel'], { marker-file: url("marker/lodging.svg"); }
	    [landusage_type='fire_station'] { marker-file: url("marker/fire-station.svg"); }
        [landusage_type='zoo'] { marker-file: url("marker/giraffe.svg"); }
	    [landusage_type='stadium'], [landusage_type='sports_centre'] { marker-file: url("marker/soccer.svg"); }
	    [landusage_type='cemetery'] { marker-file: url("marker/cemetery.svg"); }
	    [landusage_type='playground'], [landusage_type='recreation_ground'], [landusage_type='pitch'] { marker-file: url("marker/pitch.svg"); }
	    [landusage_type='industrial'] { marker-file: url("marker/industrial-building.svg"); }
	    [landusage_type='landfill'] { marker-file: url("marker/trash.svg"); }
    	[landusage_type='retail'], [landusage_type='commercial'] { marker-file: url("marker/commerical-building.svg"); }
        marker-placement: point;
        marker-width: 11;
        marker-height: 11;
        marker-fill: @label-color-alt;
      }
	  text-placement-type: simple;
      text-dx: 11;
      text-dy: 11;
      text-placements: 'S,E,W';
  	  text-name: "[landusage_name]";
      text-fill: @label-color-alt;
    }
  }

  [landusage_type='parking'][zoom>16] {
    ::marker {
		marker-placement: point;
        marker-width: 8;
        marker-height: 9;
        marker-fill: @label-color-alt;
        marker-file: url("marker/parking.svg");
    }
  }

  [landusage_type='pedestrian'], [landusage_type='common'],
  [landusage_type='military'], [landusage_type='attraction'],
  [landusage_type='terminal'], [landusage_type='service'],
  {
    [zoom>15] {
      ::marker {
        marker-placement: point;
        marker-width: 4;
        marker-height: 4;
        marker-fill: @label-color-alt;
        marker-line-width: 0;
        marker-file: url("marker/blank.svg");
      }
      text-placement-type: simple;
      text-dx: 8;
      text-dy: 8;
      text-placements: 'N';
      text-name: "[landusage_name]";
      text-fill: @label-color-alt;
    }
  }

//  ::type{ text-face-name: "Arial Regular"; text-name: "[type]"; text-fill: red; }
}

///////////////////////////////////////////////////
// Road shields, labels
///////////////////////////////////////////////////

#road_shields[zoom>8][zoom<=17] {
//  ::DEBUG { line-color: orange; line-comp-op: multiply; line-opacity: 0.5; line-width: 6; line-cap: round;}
  [shield_class='US/I'] {
    shield-file: url('shield/us-0.svg');
    shield-placement: line;
	shield-clip: false;
    shield-face-name: @shield-font;
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
  [shield_class='US/US'] {
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
  [shield_class='INTL/ALL'][zoom>11][ref!='']  {
    shield-file: url('shield/us-2.svg');
    shield-placement: line;
    shield-clip: false;
    shield-face-name: @road-font;
    shield-name: '[ref]';
    shield-fill: black;
    shield-size: 7;
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

#labels_roads_gen1[zoom>9][zoom<14][is_link=0],
#labels_roads[zoom>=14][is_link=0] {
  text-face-name: @road-font;
  text-size: 12;
  text-halo-fill: @path-body-color;
  
  [is_tunnel=0] {  text-halo-radius: 0.5; }
  [is_tunnel=1] {  text-halo-radius: 0; }

  text-clip: false;
  text-allow-overlap: false;
  text-name: "";
  text-placement: line;
  text-min-distance: 16;
  text-label-position-tolerance: 16;
  text-max-char-angle-delta: 20;

  [zoom<=16] { text-spacing: 100; }
  [zoom=17] { text-spacing: 150; }
  [zoom=18] { text-spacing: 200; }
  // font&size
  [zoom<17] { text-size: 12; }
  [zoom=17] { text-size: 14; text-face-name: @road-font-alt; }
  [zoom>=18] { text-size: 16; text-face-name: @road-font-alt; }
  [road_class!='rail'][priority<3] { text-fill: @label-color; }
  [road_class!='rail'][priority>=3] { text-fill: @label-color-alt; }
  [road_class='rail'] { text-fill: @label-color-alt; }

  // halo color by road class
  [road_class='highway'], [road_class='trunk'] { text-halo-fill: @highway-body-color;}
  [road_class='major_road'] {  text-halo-fill: @major_road-body-color;}
  [road_class='minor_road'] {  text-halo-fill: @minor_road-body-color;}

  // name select by zoom and priority
  [zoom<14][road_class!='rail'][priority<=2] { text-name: "[road_name_abbr]"; }
  [zoom=14][priority<=3] { text-name: "[road_name_abbr]"; }
  [zoom=15][priority<=5] { text-name: "[road_name_abbr]"; }
  [zoom=16][priority<=7] { text-name: "[road_name]"; }
  [zoom>=17] { text-name: "[road_name]"; }
}


#labels_poi [zoom>=17] {
    ::label {
      text-face-name: @label-font-alt;
      text-size: 12;
      text-halo-fill: @land-color;
      text-halo-radius: @smart-halo-raidus;
      text-placement-type: simple;
      text-dx: 11;
      text-dy: 11;
      text-placements: 'E,W';
      text-name: "";
      text-fill: @label-color-alt;
      text-wrap-width: 40 * @scale-factor;
      text-placement: point;
      text-min-distance: 8;
      text-line-spacing: -3;
  }
  [poi_type='bus_stop'], [poi_type='bus_station'] { marker-file: url("marker/bus.svg"); }
  [poi_type='bicycle_parking'] { marker-file: url("marker/bicycle.svg"); marker-width: 13; }
  [poi_type='fuel'] { marker-file: url("marker/fuel.svg"); }
  [poi_type='garden'] { marker-file: url("marker/garden.svg"); }
  [poi_type='ferry_terminal'] {  marker-file: url("marker/ferry.svg"); ::label{ text-name: "[name]"; } }
  [poi_type='cafe'] { marker-file: url("marker/cafe.svg"); ::label{ text-name: "[name]"; } }
  [poi_type='restaurant'] { marker-file: url("marker/restaurant.svg"); ::label{ text-name: "[name]"; } marker-height: 13; }
  [poi_type='bank'] { marker-file: url("marker/cashier.svg"); ::label{ text-name: "[name]"; }   marker-width: 11; marker-height: 11; }
  [poi_type='atm'] { marker-file: url("marker/credit-card.svg"); marker-height: 7; }
  [poi_type='fast_food'] { marker-file: url("marker/fast-food.svg"); ::label{ text-name: "[name]"; } marker-height: 9; }
  [poi_type='bar'] { marker-file: url("marker/bar.svg"); ::label{ text-name: "[name]"; } }
  [poi_type='pub'] { marker-file: url("marker/beer.svg"); ::label{ text-name: "[name]"; } }
  [poi_type='convience'] { marker-file: url("marker/grocery-store.svg"); ::label{ text-name: "[name]"; } }
  [poi_type='shop'] { marker-file: url("marker/shop.svg"); ::label{ text-name: "[name]"; } }
  [poi_type='toilets'] { marker-file: url("marker/toilet.svg"); }
  [poi_type='place_of_worship'][religion='christian'] { marker-file: url("marker/religious-christian.svg"); ::label{ text-name:"[name]"; } marker-height: 12;}
  [poi_type='place_of_worship'][religion='muslim'] { marker-file: url("marker/religious-islam.svg"); ::label{ text-name:"[name]"; } }
  [poi_type='place_of_worship'][religion='jewish'] { marker-file: url("marker/religious-jewish.svg"); ::label{ text-name:"[name]"; } }

  marker-file: url("marker/base.svg");
  //::label { text-name: "[poi_type]"; }
  marker-placement: point;
  marker-width: 10; marker-height: 10;
  marker-fill: lighten(@label-color-alt, 10%);

}
