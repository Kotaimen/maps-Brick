//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #ebe9e6;
@water:             #a3a29f;
@river:             @water;

//// basics
@building:          #e3e3e3;
@amenity:           #d9d8d4;
@sand:              @amenity;

//// greenish
@park:              #ccccca;
@wooded:            #ccccca;
@agriculture:       @park;
@sports:            @wooded;

//// amenities
@religion:          @amenity;
@healthcare:        @amenity;
@educational:       @amenity;
@barrier:           darken(@building, 15%);

//// zone
@residential:       #d9d9d7;
@pedestrian:        @residential;
@commercial:        @residential;
@industrial:        @residential;
@military:          @residential;

//// transport
@parking:           @building;
@airport:           darken(@amenity, 7%);
@aeroway:           @building;
@terminal:          @amenity;

//// boundary
@boundary-line:     #25201f;
@boundary-casing:   @land;

//// road
// reduce casing contrast by changing 'lighten' parameter below

@road-dash:         3, 1.5;
@casing:            #25201f;

@ferry-line:        @casing;

@motorway-fill:     #ebe9e6;
@motorway-line:     #979491;
@motorway-casing:   @casing;
@motorway-link:     @motorway-fill;

@primary-line:      lighten(@motorway-line, 5%);
@primary-fill:   	@motorway-fill;
@primary-casing: 	lighten(@motorway-casing, 15%);

@secondary-line:    @primary-line;
@secondary-fill:   	@primary-fill;
@secondary-casing: 	@primary-casing;

@minor-line:        lighten(@motorway-line, 10%);
@minor-fill:   	    @motorway-fill;
@minor-casing: 	    lighten(@motorway-casing, 10%);

@path-line:         lighten(@motorway-line, 15%);
@path-fill:	        @minor-fill;
@path-casing:       @minor-casing;

@rail-line: 		@primary-casing;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;

@label-admin0:      #25201f;
@label-admin1:      #25201f;
@label-place:       #25201f;
@label-poi:         #25201f;

// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(#ebe9e6, @label-fadeout);

@label-water:       #25201f;
// green text is subtle so we don’t compute here
@label-park:        #25201f;
@label-physical:    #25201f;
@label-motorway:    #25201f;
@label-primary:     #25201f;
@label-path:        #25201f;
@label-shield:      black;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        2;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

@default-halo:      1;

//// text font
@label-text-transform: capitalize;

@font-regular:      'American Typewriter Condensed', 'Arial Unicode MS Regular';
@font-heavy:        'American Typewriter Regular', 'Arial Unicode MS Regular';
@font-physical:     'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-poi:          'American Typewriter Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Regular', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Bold', 'Arial Unicode MS Regular';

//// map
Map {
  buffer-size: 500;
}
