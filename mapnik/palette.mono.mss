//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #d3d1d0;
@water:             #706c69;
@river:             #666462;
@beach:             #b7b7b3;

//// landuse
@park:              #a5a4a0;
@wooded:            #a5a4a0;
@agriculture:       #a5a4a0;
@religion:          #b7b5b3;
@healthcare:        #b7b3b3;
@educational:       @beach;
@sports:            #a5a4a0;
@building:          #dfdedd;

//// zone
@residential:       darken(@building, 2%);
@pedestrian:        desaturate(@sports, 4%);
@commercial:        darken(@building, 3%);
@industrial:        #b7b7b3;
@military:          #b7b7b7;

//// transport
@parking:           #b7b7b3;
@airport:           @beach;
@aeroway:           lighten(@beach, 5%);
@terminal:          darken(@beach, 4%);

//// boundary
@boundary-line:     #55524f;
@boundary-casing:   lighten(@boundary-line, 40%);
@boundary-dash:     10,5;

//// road
// reduce casing contrast by changing 'lighten' parameter below

@ferry-line:        #1a1514;

@motorway-fill:     #f0f0f0; //#d3d1d0;
@motorway-line:     #979491;
@motorway-casing:   #1a1514;
@motorway-link:     @motorway-fill;

@primary-line:      lighten(@motorway-line, 5%);
@primary-fill:   	@motorway-fill;
@primary-casing: 	lighten(@motorway-casing, 15%);

@secondary-line:    @primary-line;
@secondary-fill:   	@primary-fill;
@secondary-casing: 	@primary-casing;

@minor-line:        lighten(@motorway-line, 10%);
@minor-fill:   	    @motorway-fill;
@minor-casing: 	    lighten(@motorway-casing, 25%);

@path-line:         lighten(@motorway-line, 15%);
@path-fill:	        @minor-fill;
@path-casing:       @minor-casing;

@rail-line: 		#999494;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;
@road-dash:         5,2;

//// labels
@label-admin0:      #1a1514;
@label-admin1:      #1a1514;
@label-place:       #1a1514;
@label-poi:         #1a1514;

// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(#f0f0f0, @label-fadeout);

@label-water:       darken(@ferry-line, 10%);
// green text is subtle so we don’t compute here
@label-park:        #1a1514;
@label-physical:    darken(@motorway-casing, 10%);
@label-motorway:    @label-poi;
@label-primary:     @motorway-casing;
@label-path:        @primary-line;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;

@default-halo:      1;

//// text font
// TODO: use open sourced unicode font
@font-regular:      'Roboto Condensed Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Medium', 'Arial Unicode MS Regular';
@font-physical:     'Roboto Condensed Italic', 'Arial Unicode MS Regular';
@font-poi:          'Roboto Medium', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Medium', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Medium', 'Arial Unicode MS Regular';
@font-path:         'Roboto Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Bold', 'Arial Unicode MS Regular';

//// map
Map {
  buffer-size: 200;
}
