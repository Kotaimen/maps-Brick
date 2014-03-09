//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #cad4de;
@water:             #8392b0;
@river:             @water;
@sand:              #b2baa3; 

//// landuse
@park:              @agriculture;
@wooded:            #a3bba3;
@agriculture:       #aabba3;
@religion:          #bab4ab;
@healthcare:        #b9abab;
@educational:       @sand;
@sports:            #b5baab;
@building:          #b5bec7;
@barrier:           @religion;

//// zone
@residential:       #c2c5cc;
@pedestrian:        @sports;
@commercial:        @industrial;
@industrial:        #acafb6;
@military:          #9b9b9b;

//// transport
@parking:           #bab3ab;
@airport:           @sand;
@aeroway:           lighten(@sand, 10%);
@terminal:          @industrial;

//// boundary
@boundary-line:     #7c7873;
@boundary-casing:   @land;
@boundary-dash:     10,5;

//// road
// reduce casing contrast by changing 'lighten' parameter below
@ferry-line:        @land;

@casing:            @land;

@motorway-fill:     #b29ebb;
@motorway-line:     @motorway-fill;
@motorway-casing:   fadeout(@casing, 50%);
@motorway-link:     @motorway-fill;

@primary-line:      @primary-fill;
@primary-fill:   	#b9adb9;
@primary-casing: 	fadeout(@land, 50%);

@secondary-line:    @secondary-fill;
@secondary-fill:    #b6b4af;
@secondary-casing:  fadeout(@land, 50%);

@minor-line:        @secondary-line;
@minor-fill:		@secondary-fill;
@minor-casing: 		@secondary-casing;

@path-line:         @minor-line;
@path-fill:	        @minor-fill;
@path-casing:       @secondary-casing;

@rail-line: 		desaturate(@water, 10%);
@rail-casing: 		@minor-casing;
@rail-fill:         @minor-fill;
@road-dash:         3,2;

//// labels
@label-admin0:      #805b74;
@label-admin1:      @boundary-line;
@label-place:       @label-admin0;
@label-poi:         desaturate(@label-admin0, 30%);
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(@land, @label-fadeout);

@label-water:       darken(@water, 15%);
// green text is subtle so we don’t compute here
@label-park:        darken(@park, 35%);
@label-physical:    @label-admin0;
@label-motorway:    @label-admin0;
@label-primary:     @label-admin0;
@label-path:        @label-admin0;

@label-shield:      black;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@default-halo:      1;
@smart-halo:        1;
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;

//// text font
@font-regular:      'Avenir Next Condensed Medium', 'Arial Unicode MS Regular';
@font-heavy:        'Avenir Next Demi Bold', 'Arial Unicode MS Bold';
@font-physical:     'Avenir Next Condensed Medium Italic', 'Arial Unicode MS Italic';
@font-poi:          'Avenir Next Medium', 'Arial Unicode MS Regular';
@font-motorway:     'Avenir Next Medium', 'Arial Unicode MS Regular';
@font-primary:      'Avenir Next Medium', 'Arial Unicode MS Regular';
@font-path:         'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-shield:       'Avenia Next Bold', 'Arial Unicode MS Bold';

//// map
Map {
  font-directory: url('/usr/share/fonts/Mac');
}
