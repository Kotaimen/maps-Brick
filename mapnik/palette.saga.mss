//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #B49B7F;
@water:             #507677;
@river:             @water;

//// basics
@building:          #BAA38C;
@amenity:           #948666;
@sand:              @amenity;

//// greenish
@park:              #767d5b;
@wooded:            #858559;
@agriculture:       @park;
@sports:            #7f8a6a;

//// amenities
@religion:          @amenity;
@healthcare:        #B47771;
@educational:       #949366;
@barrier:           darken(@building, 9%);

//// zone
@residential:       darken(@land, 2%);
@pedestrian:        darken(@land, 2%);
@commercial:        @residential;
@industrial:        @residential;
@military:          #949494;

//// transport
@parking:           @building;
@airport:           darken(@amenity, 7%);
@aeroway:           @building;
@terminal:          @amenity;

//// boundary
@boundary-line:     #681705;
@boundary-casing:   @land;

//// road
// reduce casing contrast by changing 'lighten' parameter below

@road-dash:         3, 1.5;
@ferry-line:        @land;

@casing:            #5c4a2e;

@motorway-fill:     #c66627;
@motorway-line:     darken(@motorway-fill, 2%);
@motorway-casing:   fadeout(@casing, 33);
@motorway-link:     #C27523; //desaturate(@motorway-fill, 15%);

@primary-line:      lighten(@motorway-casing, 10%);
@primary-fill:     	#c0823f;
@primary-casing:    lighten(@motorway-casing, 15%);

@secondary-line:    lighten(@motorway-casing, 15%);
@secondary-fill:    desaturate(lighten(@primary-fill, 3%), 10%);
@secondary-casing:  lighten(@motorway-casing, 15%);

@minor-line:        lighten(@motorway-casing, 20%);
@minor-fill:        #b9a794;
@minor-casing:      lighten(@motorway-casing, 17%);

@path-line:         lighten(@motorway-casing, 20%);
@path-fill:	        @minor-fill;
@path-casing:       lighten(@motorway-casing, 17%);

// desaturate gives rail slightly cool grey feel
@rail-line: 	    #665A47;
@rail-casing: 	    @land;
@rail-fill:         @land;

//// labels
@label-admin0:      #524640;
@label-admin1:      @boundary-line;
@label-place:       #473319;
@label-poi:         #392d29;
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+

@label-fadeout:     0%;
@label-halo:        fadeout(@land, @label-fadeout);
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

@label-water:       #184647;
@label-park:        #394014;
@label-physical:    @casing;

// road label
@label-motorway:    @label-poi;
@label-primary:     @casing;
@label-path:        @casing;

@label-shield:      black;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;

@default-halo:      1;

//// text font

@font-regular:      'Roboto Condensed Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Regular', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Regular', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Bold', 'Arial Unicode MS Bold';

//// map
Map {
  buffer-size: 256;
}
