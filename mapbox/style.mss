
///////////////////////////////////////////////////
// Colors
///////////////////////////////////////////////////

///// Landmass
@land-color: #d9d6ca; 
@water-color: #8fb1bf;

///// Landusage
@building-color: #dbd9d0;
@residential-color: darken(@building-color, 5%);

@grey-color: #ceccc2;
@grey-color-alt: #cecab9;
@yellow-color: #c9c5ab;
@education-color: @yellow-color;
@healthcare-color: #cfbcb2;

@green-color: #bdc4ac;
@green-color-alt: #b3c7b6;
@sports-color: #b2b88f; 

@airport-color: @education-color;
@aeroway-color: lighten(@airport-color, 9%);
@terminal-color: darken(@airport-color, 7%);

@boundary-color: #ab421b;
@boundary-outline-color: @residential-color;

///// Roads
@highway-body-color:#d4957f;
@highway-casing-color: #8a776e;

@major_road-body-color: #d9cbbd;
@major_road-casing-color: lighten(@highway-casing-color, 15%);
@major_road-casing-color-alt: lighten(@highway-casing-color, 30%);

@minor_road-body-color: #f1eee8; 
@minor_road-casing-color: lighten(@highway-casing-color, 20%);
@minor_road-casing-color-alt: lighten(@highway-casing-color, 30%);

@path-body-color: @minor_road-body-color;
@path-casing-color: lighten(@highway-casing-color, 25%);
@path-casing-color-alt: lighten(@path-casing-color, 25%);

@highway-link-color: lighten(desaturate(@highway-body-color, 10%), 8%);
@road-dash: 5,2;

@ferry-color: #536872; 
@rail-color: @major_road-casing-color;
@rail-casing-color: @land-color;

///////////////////////////////////////////////////
// Fonts
///////////////////////////////////////////////////

@label-color: #4b4025;
@label-color-alt : #767160;
@label_halo-color: @land-color;
@label-color-blue: @ferry-color;
@label-color-green: #565940;
@label-color-brown: @ferry-color;

@label-font: 'Avenir Next Condensed Medium', 'Arial Unicode MS Regular';
@label-font-heavy: 'Avenir Next Demi Bold', 'Arial Unicode MS Regular';
@label-font-alt: 'Avenir Next Medium', 'Arial Unicode MS Regular';
@label-font-italic: 'Avenir Next Medium Italic', 'Arial Unicode MS Regular';
@road-font: 'Avenir Next Medium', 'Arial Unicode MS Regular';
@road-font-alt: 'Avenir Next Regular', 'Arial Unicode MS Regular';
@shield-font: 'Arial Bold';

///////////////////////////////////////////////////
// Terrain Font
///////////////////////////////////////////////////

///// Variable depth buffer
@smart-halo-raidus: 1;

Map {
  background-color: @water-color;
//  buffer-size: 256;
}
