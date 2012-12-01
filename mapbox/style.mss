///////////////////////////////////////////////////
// Colors
///////////////////////////////////////////////////

// Landmass

@land-color: #e3e3d8;
@water-color: #99aabb;

// Landusage

@residential-color: #dadacf;
@green-color: #bbccbb;
@green-color-alt: #adc0b3;
@grey-color: #bbc2cc;
@grey-color-alt: #bec3c9;

@healthcare-color: #cfc3ba;
@education-color: #d5cfb9;
@sports-color: #ccdec6;

@airport-color: #cfcbbe;
@aeroway-color: lighten(@airport-color, 8);
@terminal-color: darken(@airport-color, 8);

@building-color: #d6d4cb;
@boundary-color: #888888;

//Road

@highway-body-color: #cc9988;
@highway-casing-color: #776666;

@major_road-body-color: #d9cdc4;
@major_road-casing-color: @highway-casing-color;
@major_road-casing-color-alt: lighten(@highway-casing-color, 30%);

@minor_road-body-color: #f6f3f0;
@minor_road-casing-color: @highway-casing-color;
@minor_road-casing-color-alt: lighten(@highway-casing-color, 30%);

@path-body-color: #f6f3f0;
@path-casing-color: @highway-casing-color;
@path-casing-color-alt: lighten(@path-casing-color, 25%);

@highway-link-color: lighten(desaturate(@highway-body-color, 10%), 8%);
@road-dash: 4,2;
@ferry-color: #6b849c;
@rail-color: #aaa197;
@rail-casing-color: @land-color;
@rail-outline-color: @rail-color;

// Font
@label-color: #3e342e;
@label_halo-color: @land-color;
@label-color-blue: @ferry-color;

@label-font: 'American Typewriter Condensed';
@label-font-alt: 'American Typewriter Regular';
@label-font-heavy: 'American Typewriter Condensed Bold';
@label-roads-font: 'Avenir Next Demi Bold';

// Variable depth buffer
@smart-halo-raidus: 1.6;

Map {
  background-color: @water-color;
  buffer-size: 512; 
}


