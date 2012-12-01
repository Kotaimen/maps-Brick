///////////////////////////////////////////////////
// Placement names
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
  [capital="yes"] { text-face-name: @label-font-heavy; }
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

#places-all[zoom>=11] {  
  text-clip: false;
  text-face-name: @label-font;
  text-allow-overlap: false;
  text-name: "[name]";
  text-fill: @label-color;
  text-halo-fill: @land-color;
  text-halo-radius: 0 + @smart-halo-raidus;
  text-placement: point;
  text-size: 16;
  text-min-distance: 32;
  [zoom>13] { text-transform: uppercase; }
  //[population>1000] { text-size: 32; }

  [type=3] { text-size: 16; }        
  [type=2] { text-size: 18; }      
  [type=1] { text-size: 24; }  
  [type=0] { text-size: 32; }

  /*
  [zoom=11] {
    [font_size=18] { text-size: 18; }
    [font_size=24] { text-size: 24; }
    [font_size=32] { text-size: 32; }
  }
  [zoom=12] {
    [font_size=18] { text-size: 20; }
    [font_size=24] { text-size: 28; }
    [font_size=32] { text-size: 36; }
  }
  [zoom>=13] {
    [font_size=18] { text-size: 22; }
    [font_size=24] { text-size: 28; }
    [font_size=32] { text-size: 36; }
  }
  */
}