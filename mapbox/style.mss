
///////////////////////////////////////////////////
// Colors
///////////////////////////////////////////////////

///// Landmass
@land-color: #e3e3d8;
@water-color: #859db6;

///// Landusage
@residential-color: #dadacf;
@green-color: #bbccbb;
@green-color-alt: #adc0b3;
@grey-color: #ceccc4;
@grey-color-alt: #cacdc3;
@yellow-color: #d5d1b9;

@healthcare-color: #cfc3ba;
@education-color: #d5cfb9;
@sports-color: #ccdec6;

@airport-color: #cfcbbe;
@aeroway-color: lighten(@airport-color, 10);
@terminal-color: darken(@airport-color, 10);

@building-color: #d6d4cb;
@boundary-color: #888899;

///// Road

@highway-body-color: #cc8e7e;
@highway-casing-color: #776666;

@major_road-body-color: #d9cdc4;
@major_road-casing-color: lighten(@highway-casing-color, 15%);
@major_road-casing-color-alt: lighten(@highway-casing-color, 30%);

@minor_road-body-color: #f6f3f0;
@minor_road-casing-color: lighten(@highway-casing-color, 20%);
@minor_road-casing-color-alt: lighten(@highway-casing-color, 30%);

@path-body-color: #f6f3f0;
@path-casing-color: lighten(@highway-casing-color, 25%);
@path-casing-color-alt: lighten(@path-casing-color, 25%);

@highway-link-color: lighten(desaturate(@highway-body-color, 10%), 8%);
@road-dash: 5,2;

@ferry-color: #5980a8;
@rail-color: #aaa197;
@rail-casing-color: @land-color;
@rail-outline-color: @rail-color;

///////////////////////////////////////////////////
// Terrain Colors
///////////////////////////////////////////////////
/*
@land-color: #b8b0a1;

@highway-body-color: #cdcdcd;
@highway-casing-color: #666666;

@major_road-body-color: #d9d9d9;
@major_road-casing-color: @highway-casing-color;
@major_road-casing-color-alt: lighten(@highway-casing-color, 5%);

@minor_road-body-color: #f6f3f0;
@minor_road-casing-color: @highway-casing-color;
@minor_road-casing-color-alt: lighten(@highway-casing-color, 5%);

@path-body-color: #f6f3f0;
@path-casing-color: @highway-casing-color;
@path-casing-color-alt: lighten(@path-casing-color, 15%);

@highway-link-color: lighten(desaturate(@highway-body-color, 10%), 8%);
@road-dash: 6,2;
@ferry-color: #53789a;
@rail-color: #aaa197;
@rail-casing-color: @land-color;
@rail-outline-color: @rail-color;
*/

///////////////////////////////////////////////////
// Colors
///////////////////////////////////////////////////

@label-color: #3e342e;
@label-color-alt : #7c7575;
@label_halo-color: @land-color;
@label-color-blue: @ferry-color;

@label-font: 'Avenir Next Condensed Medium', 'Arial Unicode MS Regular';
@label-font-heavy: 'Avenir Next Bold', 'Arial Unicode MS Regular';
@label-font-alt: 'Avenir Next Demi Bold', 'Arial Unicode MS Regular';
@label-font-italic: 'Avenir Next Demi Bold Italic', 'Arial Unicode MS Regular';
@road-font: 'Arial Bold', 'Arial Unicode MS Regular';

///////////////////////////////////////////////////
// Terrain Font
///////////////////////////////////////////////////
/*
@label-color: #23120b;
@label-color-alt : #3c3c3c;
@label_halo-color: white;
@label-color-blue: @ferry-color;

@label-font: 'Avenir Next Condensed Demi Bold', 'Arial Unicode MS Regular';
@label-font-heavy: 'Avenir Next Bold', 'Arial Unicode MS Regular';
@label-font-alt: 'Avenir Next Demi Bold', 'Arial Unicode MS Regular';
@label-font-italic: 'Avenir Next Demi Bold Italic', 'Arial Unicode MS Regular';
@road-font: 'Arial Bold', 'Arial Unicode MS Regular';
*/

///// Variable depth buffer
@smart-halo-raidus: 1;

Map {
  background-color: @water-color;
//  buffer-size: 256;
}
