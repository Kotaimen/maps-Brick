//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #d4d1c5;
@water:             #8fb1bf;
@river:             darken(@water, 15%);
@sand:              #c9c1ab;

//// landuse
@park:              #b7bfa3;
@wooded:            #a5bfa9;
@agriculture:       #adc7b2;
@sports:            #b2b88f;

@building:          #dbd9ce;
@barrier:           darken(@building, 4%);
@parking:           @sand;

@religion:          #ccceb9;
@healthcare:        #d1beb4;
@educational:       @sand;

//// zone
@residential:       darken(@building, 5%);
@pedestrian:        desaturate(@park, 3%);
@commercial:        darken(@building, 9%);
@industrial:        @religion;
@military:          #c4c4c4;

//// transport
@airport:           @sand;
@aeroway:           lighten(@sand, 10%);
@terminal:          darken(@sand, 7%);

//// boundary
@boundary-line:     #635d6e;
@boundary-casing:   @land;
@boundary-dash:     10, 5;

//// road
@road-dash:         3, 1.5;
@casing:            #99847a;

@ferry-line:        #637f8c;

@motorway-fill:     #d4957f;
@motorway-line:     darken(@motorway-fill, 3%);
@motorway-casing:   fadeout(#99847a, 60%);
@motorway-link:     lighten(@motorway-fill, 8%);

@primary-line:      lighten(@casing, 13%);
@primary-fill:      #d4c5b6;
@primary-casing: 	lighten(@motorway-casing, 14%);

@secondary-line:    lighten(@casing, 15%);
@secondary-fill:    @primary-fill;
@secondary-casing:  lighten(@motorway-casing, 14%);

@minor-line:        lighten(@casing, 17%);
@minor-fill:        #e0ded5; ///#ebe8e2;
@minor-casing:      lighten(@motorway-casing, 20%);

@path-line:         lighten(@casing, 20%);
@path-fill:	        @minor-fill;
@path-casing:       lighten(@motorway-casing, 20%);

// desaturate gives rail slightly cool grey feel
@rail-line: 	    desaturate(lighten(@casing, 15%), 11%);
@rail-casing: 	    @land;
@rail-fill:         lighten(@casing, 25%);


//// labels
@label-admin0:      #6e5f57;
@label-admin1:      @boundary-line;
@label-place:       #381f13;
@label-poi:         #6e5f57;

// transparency of halo color, set to 0% if 'smart halo'
// is used later in post processing
@label-fadeout:     0%;
@label-halo:        fadeout(@land, @label-fadeout);
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;
@label-water:       darken(@ferry-line, 17%);
// green text is subtle so we don’t compute here
@label-park:        #5c6e57;
@label-physical:    @label-poi;
@label-motorway:    darken(@casing, 13%);
@label-primary:     darken(@casing, 7);
@label-path:        @casing;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;

@default-halo: 	    1;

//// text font
// TODO: use open sourced unicode font
@font-regular:      'Roboto Condensed Light', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Regular', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Condensed Light Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Light', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Light', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Light', 'Arial Unicode MS Regular';
@font-path:         'Roboto Light', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Regular', 'Arial Unicode MS Regular';

//// map
Map {
  buffer-size: 100;
}
