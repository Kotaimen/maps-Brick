//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #D0CAC0;
@water:             #A68D6C;
@river:             @water;

//// basics
@building:          #ccc1b2;
@amenity:           #d7cbb8;
@sand:              #C2B6A5;

//// greenish
@park:              #7B9160;
@wooded:            #5C9675;
@agriculture:       #6c936b;
@sports:            #848c66;

//// amenities
@religion:          #cccac8;
@healthcare:        #ccb9af;
@educational:       #ccc6b0;
@barrier:           darken(@building, 5%);

//// zone
@residential:       @land;
@pedestrian:        @residential;
@commercial:        spin(@residential, 1);
@industrial:        spin(@residential, -2);
@military:          #c2c2c2;

//// transport
@parking:           @building;
@airport:           darken(@amenity, 7%);
@aeroway:           darken(@building, 10%);
@terminal:          @amenity;

//// boundary
@boundary-line:     #2F3A4E;
@boundary-casing:   @land;

//// road
// reduce casing contrast by changing 'lighten' parameter below

@road-dash:         3, 1.5;
@casing:            #96694B;

@ferry-line:        #7A6441;

@motorway-fill:     saturate(darken(@land, 10%), 15%);
@motorway-line:     @casing;
@motorway-casing:   @casing;
@motorway-link:     @motorway-fill;

@primary-line:      lighten(@motorway-line, 5%);
@primary-fill:   	saturate(darken(@land, 5%), 7%);
@primary-casing: 	lighten(@motorway-casing, 10%);

@secondary-line:    @primary-line;
@secondary-fill:   	@primary-fill;
@secondary-casing: 	@primary-casing;

@minor-line:        lighten(@motorway-line, 10%);
@minor-fill:   	    @secondary-fill;
@minor-casing: 	    lighten(@motorway-casing, 10%);

@path-line:         lighten(@motorway-line, 10%);
@path-fill:	        saturate(darken(@land, 3%), 5%);
@path-casing:       @minor-casing;

@rail-line: 		#806A5C;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;

@label-admin0:      #2F2F2F;
@label-admin1:      #2F2F2F;
@label-place:       #573920;
@label-poi:         #1C2433;

// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(@land, @label-fadeout);

@label-water:       #573920;
// green text is subtle so we don’t compute here
@label-park:        #263F2C;
@label-physical:    #2F3A4E;
@label-motorway:    darken(@motorway-casing, 10%);
@label-primary:     darken(@motorway-casing, 10%);
@label-path:        @motorway-casing;
@label-shield:      black;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;
// controls text-halo-rasterizer fast/full
@halo-quality:      full;

@default-halo:      1;

//// text font
@label-text-transform: capitalize;

@font-regular:      'American Typewriter Condensed Bold', 'Arial Unicode MS Regular';
@font-heavy:        'American Typewriter Bold', 'Arial Unicode MS Bold';
@font-physical:     'Baskerville SemiBold Italic', 'Arial Unicode MS Italic';
@font-poi:          'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-motorway:     'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-primary:      'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-path:         'Baskerville Italic', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Bold', 'Arial Unicode MS Bold';
//// map
Map {
  buffer-size: 0;
}
