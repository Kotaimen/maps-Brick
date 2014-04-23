//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #1B1B1F;
@water:             #1B2C40;
@river:             @water;

//// basics
@building:          #27272B;
@amenity:           #282924;
@sand:              @amenity;

//// greenish
@park:              #202924;
@wooded:            #262923;
@agriculture:       @park;
@sports:            @wooded;

//// amenities
@religion:          @amenity;
@healthcare:        #292524;
@educational:       @amenity;
@barrier:           darken(@building, 5%);

//// zone
@residential:       #252529;
@pedestrian:        @land;
@commercial:        @residential;
@industrial:        @residential;
@military:          #2B2B2B;

//// transport
@parking:           @building;
@airport:           darken(@amenity, 2%);
@aeroway:           @building;
@terminal:          @amenity;

//// boundary
@boundary-line:     #325C40;
@boundary-casing:   @land;

//// road
// reduce casing contrast by changing 'lighten' parameter below

@road-dash:         3, 1.5;
@casing:            @land;

@ferry-line:        #1D416B;

@motorway-fill:     #402A27;
@motorway-line:     @motorway-fill;
@motorway-casing:   fadeout(@casing, 50%);
@motorway-link:     @motorway-fill;

@primary-line:      @primary-fill;
@primary-fill:   	#3D3131;
@primary-casing: 	fadeout(@casing, 50%);

@secondary-line:    @primary-fill;
@secondary-fill:    @primary-fill;
@secondary-casing:  fadeout(@land, 50%);

@minor-line:        @minor-fill;
@minor-fill:		#383535;
@minor-casing: 		@secondary-casing;

@path-line:         @minor-line;
@path-fill:	        @minor-fill;
@path-casing:       @secondary-casing;

// desaturate gives rail slightly cool grey feel
@rail-line: 	    #494B4D;
@rail-casing: 	    @land;
@rail-fill:         @land;

//// labels
@label-admin0:      #736655;
@label-admin1:      @boundary-line;
@label-place:       #B8985E;
@label-poi:         #736655;
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+

@label-fadeout:     0%;
@label-halo:        fadeout(@land, @label-fadeout);
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

@label-water:       @ferry-line;
@label-park:        #5C6E57;
@label-physical:    @label-poi;

// road label
@label-motorway:    @label-poi;
@label-primary:     @label-poi;
@label-path:        #756A59;

@label-shield:      darkgrey;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;
@default-halo:      1;

//// text font
@label-text-transform: uppercase;

@font-regular:      'Roboto Condensed Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Regular', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Regular', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Light', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Medium  ', 'Arial Unicode MS Bold';

//// map
Map {
  buffer-size: 500;
}
