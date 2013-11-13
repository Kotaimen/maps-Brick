
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
    text-name: '[name]+"\n"+[elevation]';
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

//// places

#place_z6[zoom>=4][zoom<=6] {
 ::marker
  ['zoom_start'<=4][zoom=4],
  ['zoom_start'<=5][zoom=5],
  ['zoom_start'<=6][zoom=6], {
    [font_size=18] { marker-width:5 + @smart-halo / @scale-factor;}
    [font_size=12] { marker-width:4 + @smart-halo / @scale-factor; }
	marker-fill: @label-place;
	marker-line-color: @label-halo;
    marker-line-width: @smart-halo;    
  }
  ::text {
    text-face-name: @font-regular;
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
    text-fill: @label-place;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo / @scale-factor;
	text-placement-type: simple;
    text-placement: point;
    text-placements: 'NE,SW,SE,W,N,E';

  }
}


#place_z8[zoom>=7][zoom<=9] {
 ::marker
  ['zoom_start'<=6][zoom=7],
  ['zoom_start'<=7][zoom=8],
  ['zoom_start'<=8][zoom=9], {
    marker-width:5 + @smart-halo;
    [font_size=20] { marker-width:5 + @smart-halo;}
    [font_size=13] { marker-width:4 + @smart-halo; }
	marker-fill: @label-place;
	marker-line-color: @label-halo;
    marker-line-width: @smart-halo;    
  }
  
  ::text {
    text-face-name: @font-regular;
    text-name: '';
    ['zoom_start'<=6][zoom=7],
    ['zoom_start'<=7][zoom=8],
    ['zoom_start'<=8][zoom=9] {
      [font_size=20] {text-size: 24; text-dx: 5; text-dy: 5;}
      [font_size=13] {text-size: 20; text-dx: 4; text-dy: 4; }
      text-name: '[name]';
    }
    [font_size=20] {text-dx: 5; text-dy: 5;}
    [font_size=13] {text-dx: 4; text-dy: 4; }
    text-fill: @label-place;
    text-halo-fill: @label-halo;
    text-halo-radius: @smart-halo / @scale-factor;
    text-placement-type: simple;
    text-placement: point;
    text-placements: 'NE,SW,SE,W,N,E';

  }
}
