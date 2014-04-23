//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #D1CEC2;
@water:             #8CACBA;
@river:             @water;

//// basics
@building:          #D9D7CC;
@amenity:           #C9C1AB;
@sand:              @amenity;

//// greenish
@park:              #B5BF9D;
@wooded:            #A0BAA1;
@agriculture:       @park;
@sports:            @wooded;

//// amenities
@religion:          @amenity;
@healthcare:        #D1BEB4;
@educational:       @amenity;
@barrier:           darken(@building, 9%);

//// zone
@residential:       #CCC8B8;
@pedestrian:        #C8C9B7;
@commercial:        @residential;
@industrial:        @residential;
@military:          #919090;

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

@road-dash:         3, 1.5;
@casing:            #99847A;

@ferry-line:        #6B7E96;

@motorway-fill:     #D69076;
@motorway-line:     @motorway-fill;
@motorway-casing:   fadeout(@casing, 40%);
@motorway-link:     desaturate(lighten(@motorway-fill, 10%), 5%);

@primary-line:      lighten(@casing, 13%);
@primary-fill:      #D4C5B6;
@primary-casing: 	lighten(@motorway-casing, 14%);

@secondary-line:    lighten(@casing, 16%);
@secondary-fill:    @primary-fill;
@secondary-casing:  lighten(@motorway-casing, 14%);

@minor-line:        lighten(@casing, 20%);
@minor-fill:        #E0DDCE;
@minor-casing:      lighten(@motorway-casing, 20%);

@path-line:         lighten(@casing, 20%);
@path-fill:	        @minor-fill;
@path-casing:       lighten(@motorway-casing, 20%);

// desaturate gives rail slightly cool grey feel
@rail-line: 	    #ABA5A1;
@rail-casing: 	    @land;
@rail-fill:         @land;

//// labels
@label-admin0:      #736655;
@label-admin1:      @boundary-line;
@label-place:       #8E4D3B;
@label-poi:         #736655;
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+

@label-fadeout:     0%;
@label-halo:        fadeout(@land, @label-fadeout);
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

@label-water:       @ferry-line;
@label-park:        #5C6E57;
@label-physical:    @casing;

// road label
@label-motorway:    @label-poi;
@label-primary:     @casing;
@label-path:        @casing;

@label-shield:      @casing;

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
