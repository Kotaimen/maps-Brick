///////////////////////////////////////////////////
// Brick Colors
///////////////////////////////////////////////////
/*
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
@geographic-lines-color: #ff7d04;

///// Roads
@highway-body-color:#d4957f;
@highway-casing-color: #8a776e;
@highway-link-color: lighten(@highway-body-color, 8%);

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

@ferry-color: #435b66;
@rail-color: @major_road-casing-color;
@rail-casing-color: @land-color;

@label-color: #4b4025;
@label-color-alt : #767160;
@label_halo-color: @land-color;
@label-color-blue: @ferry-color;
@label-color-green: #565940;
@label-color-brown: @ferry-color;
*/

///////////////////////////////////////////////////
// Moonlight Colors 
///////////////////////////////////////////////////

///// Landmass
@land-color: #262738; 
@water-color: #25315c;

///// Landusage
@building-color: #2f354f;
@residential-color: darken(@building-color, 5%);

@grey-color: #2f3d47;
@grey-color-alt: #2f3947;
@yellow-color: #39322d;
@education-color: @yellow-color;
@healthcare-color: #473840;

@green-color: #202924;
@green-color-alt: #202925;
@sports-color: #25312b; 

@airport-color: @education-color;
@aeroway-color: lighten(@airport-color, 9%);
@terminal-color: darken(@airport-color, 7%);

@boundary-color: #588165;
@boundary-outline-color: @residential-color;
@geographic-lines-color: #ab5403;

///// Roads
@highway-body-color:#5e3c37;
@highway-casing-color: #332e2e;//#3d2e2e;

@major_road-body-color: #594747;
@major_road-casing-color: @highway-casing-color;//darken(@highway-casing-color, 15%);
@major_road-casing-color-alt: @highway-casing-color;//darken(@highway-casing-color, 30%);

@minor_road-body-color: #4d4949; 
@minor_road-casing-color: @highway-casing-color;//darken(@highway-casing-color, 20%);
@minor_road-casing-color-alt: @highway-casing-color;//darken(@highway-casing-color, 30%);

@path-body-color: @minor_road-body-color;
@path-casing-color: @highway-casing-color;//darken(@highway-casing-color, 25%);
@path-casing-color-alt: @highway-casing-color;//darken(@path-casing-color, 25%);

@highway-link-color:@highway-body-color;// darken(desaturate(@highway-body-color, 10%), 8%);
@road-dash: 5,2;

@ferry-color: #536872; 
@rail-color: @major_road-casing-color;
@rail-casing-color: @land-color;

@label-color: #debd88;
@label-color-alt : #b8a485;
@label_halo-color: #101010; //@land-color;
@label-color-blue: @ferry-color;
@label-color-green: @label-color-alt;
@label-color-brown: @ferry-color;


///////////////////////////////////////////////////
// Terrain Colors
///////////////////////////////////////////////////
/*
///// Landmass
@land-color: #e3e3d8;
@water-color: #859db6;

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

@boundary-color: #3c3c3c;
@boundary-outline-color: @residential-color;
@geographic-lines-color: #3c3c3c;

///// Roads
@highway-body-color:#e7e7e7;
@highway-casing-color: #666666;
@highway-link-color: @highway-body-color;

@major_road-body-color: @highway-body-color;
@major_road-casing-color: @highway-casing-color;
@major_road-casing-color-alt: @highway-casing-color;

@minor_road-body-color: @highway-body-color;
@minor_road-casing-color: @highway-casing-color;
@minor_road-casing-color-alt: @highway-casing-color;

@path-body-color: @minor_road-body-color;
@path-casing-color: @highway-casing-color;
@path-casing-color-alt: @highway-casing-color;

@highway-link-color: lighten(desaturate(@highway-body-color, 10%), 8%);
@road-dash: 5,2;

@ferry-color: #1c4065;
@rail-color: @major_road-casing-color;
@rail-casing-color: darken(@land-color, 15%);

@label-color: #23120b;
@label-color-alt : #3c3c3c;
@label_halo-color: @land-color;
@label-color-blue: @ferry-color;
@label-color-green: #1a3c11;
@label-color-brown: @ferry-color;
*/

///////////////////////////////////////////////////
// Fonts
///////////////////////////////////////////////////

@label-font: 'Avenir Next Condensed Regular',  'Arial Unicode MS Regular';
@label-font-heavy: 'Avenir Next Condensed Medium',  'Arial Unicode MS Regular';
@label-font-alt: 'Avenir Next Regular', 'Arial Unicode MS Regular';
@label-font-italic: 'Avenir Next Condensed Medium Italic',  'Arial Unicode MS Regular';
@road-font: 'Avenir Book', 'Arial Unicode MS Regular';
@road-font-alt: 'Avenir Light', 'Arial Unicode MS Regular';
@shield-font: 'Arial Regular';

///////////////////////////////////////////////////
// Bold Fonts
///////////////////////////////////////////////////
/*
@label-font: 'Avenir Next Condensed Medium',  'Arial Unicode MS Regular';
@label-font-heavy: 'Avenir Next Condensed Demi Bold',  'Arial Unicode MS Regular';
@label-font-alt: 'Avenir Next Medium', 'Arial Unicode MS Regular';
@label-font-italic: 'Avenir Next Condensed Medium Italic',  'Arial Unicode MS Regular';
@road-font: 'Avenir Book', 'Arial Unicode MS Regular';
@road-font-alt: 'Avenir Light', 'Arial Unicode MS Regular';
@shield-font: 'Arial Regular';
*/

///////////////////////////////////////////////////
// Terrain Font
///////////////////////////////////////////////////

///// Variable depth buffer
@smart-halo-raidus: 0.5;
@scale-factor: 1.75;

Map {
  background-color: @water-color;
  buffer-size: 512;
}
