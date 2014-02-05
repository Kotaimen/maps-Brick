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
@boundary-line:     @military;
@boundary-casing:   @land;

//// road
// reduce casing contrast by changing 'lighten' parameter below

@ferry-line:        #a3a2a1;

@casing:            #313131;

@motorway-fill:     #b7b7b7; //#d3d1d0;
@motorway-line:     #646464;
@motorway-casing:   #313131;
@motorway-link:     @motorway-fill;

@primary-line:      @motorway-line;
@primary-fill:   	@motorway-fill;
@primary-casing: 	@motorway-casing;

@secondary-line:    @primary-line;
@secondary-fill:   	@primary-fill;
@secondary-casing: 	@primary-casing;

@minor-line:        @motorway-line;
@minor-fill:   	    @motorway-fill;
@minor-casing: 	    @motorway-casing;

@path-line:         @motorway-line;
@path-fill:	        @minor-fill;
@path-casing:       @minor-casing;

@rail-line:         #404040;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;
@road-dash:         5,2;

//// labels
@label-admin0:      #202020;
@label-admin1:      #202020;
@label-place:       #202020;
@label-poi:         #202020;

// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(#ebe9e6, @label-fadeout);

@label-water:       #212a42;
// green text is subtle so we don’t compute here
@label-park:        #162b21;
@label-physical:    #202020;
@label-motorway:    #202020;
@label-primary:     #202020;
@label-path:        #202020;
@label-shield:      black;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        2;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;
@default-halo:      2;

//// text font
// TODO: use open sourced unicode font

@font-regular:      'Roboto Condensed Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Regular', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Regular', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Medium  ', 'Arial Unicode MS Bold';

//// map
Map {
  buffer-size: 200;
}
