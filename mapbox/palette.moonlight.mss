//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #262738;
@water:             #25315c;
@river:             darken(@water, 15%);
@beach:             #39322d;

//// landuse
@park:              #202924;
@wooded:            #202925;
@agriculture:       #202924;
@religion:          #2f3947;
@healthcare:        #473840;
@educational:       @beach;
@sports:            #25312b;
@building:          #3f424f;

//// zone
@residential:       darken(@building, 4%);
@pedestrian:        desaturate(@sports, 10%);
@commercial:        darken(@building, 5%);
@industrial:        #2f3d47;
@military:          #333333;

//// transport
@parking:           #2f354f;
@airport:           @beach;
@aeroway:           lighten(@beach, 3%);
@terminal:          lighten(@beach, 4%);

//// boundary
@boundary-line:     #588165;
@boundary-casing:   @land;
@boundary-dash:     10,5;

//// road
// reduce casing contrast by changing 'lighten' parameter below
@ferry-line:        #536872;

@motorway-fill:     #5e3c37;
@motorway-line:     darken(@motorway-fill, 5%);
@motorway-casing:   #2b2727;
@motorway-link:     desaturate(@motorway-fill, 15%);

@primary-line:      @motorway-line;
@primary-fill:   	#594747;
@primary-casing: 	@motorway-casing;

@secondary-line:    @motorway-line;
@secondary-fill:    @primary-fill;
@secondary-casing:  @motorway-casing;

@minor-line:        @motorway-line;
@minor-fill:		#4d4949;
@minor-casing: 		@motorway-casing;

@path-line:         @motorway-line;
@path-fill:	        @minor-fill;
@path-casing:       @motorway-casing;

@rail-line: 		@primary-casing;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;
@road-dash:         5,2;

//// labels
@label-admin0:      #c47327;
@label-admin1:      #debd88;
@label-place:       #b8a485;
@label-poi:         #debd88;
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     50%;
@label-halo:        fadeout(#101010, @label-fadeout);

@label-water:       darken(@ferry-line, 10%);
// green text is subtle so we don’t compute here
@label-park:        #b8a485;
@label-physical:    #ab5403;
@label-motorway:    #debd88;
@label-primary:     #debd88;
@label-path:        #debd88;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      1;

//// text font
@font-regular:      'Roboto Condensed Light', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Regular', 'Arial Unicode MS Regular';
@font-physical:     'Roboto Condensed Light Italic', 'Arial Unicode MS Regular';
@font-poi:          'Roboto Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Light', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Light', 'Arial Unicode MS Regular';
@font-path:         'Roboto Thin', 'Arial Unicode MS Regular';
@font-shield:       'Arial Regular', 'Arial Unicode MS Regular';

//// map
Map {
//  buffer-size: 256;
}
