//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #b49b7f;
@water:             #507677;
@river:             darken(@water, 15%);
@beach:             #ad9252;

//// landuse
@park:              #969961;
@wooded:            #838559;
@agriculture:       #76956c;
@religion:          #878b87;
@healthcare:        #b47771;
@educational:       @beach;
@sports:            #7f8a6a;
@building:          #b2a18f;

//// zone
@residential:       darken(@building, 5%);
@pedestrian:        desaturate(@sports, 11%);
@commercial:        darken(@building, 9%);
@industrial:        #957f62;
@military:          #6e6966;

//// transport
@parking:           #bd8953;
@airport:           @beach;
@aeroway:           lighten(@beach, 10%);
@terminal:          darken(@beach, 7%);

//// boundary
@boundary-line:     #4e3722;
@boundary-casing:   desaturate(lighten(@boundary-line, 40%), 50%);
@boundary-dash:     10,5;

//// road
// reduce casing contrast by changing 'lighten' parameter below
@ferry-line:        #284d4e;

@motorway-fill:     #c66627;
@motorway-line:     darken(@motorway-fill, 2%);
@motorway-casing:   #5c4a2e;
@motorway-link:     #b37533; //desaturate(@motorway-fill, 15%);

@primary-line:      lighten(@motorway-casing, 10%);
@primary-fill:   	#c0823f;
@primary-casing: 	lighten(@motorway-casing, 15%);

@secondary-line:    lighten(@motorway-casing, 15%);
@secondary-fill:    desaturate(lighten(@primary-fill, 3%), 10%);
@secondary-casing:  lighten(@motorway-casing, 15%);

@minor-line:        lighten(@motorway-casing, 20%);
@minor-fill:		#b9a794;
@minor-casing: 		lighten(@motorway-casing, 20%);

@path-line:         lighten(@motorway-casing, 20%);
@path-fill:	        @minor-fill;
@path-casing:       lighten(@motorway-casing, 20%);

@rail-line: 		@primary-casing;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;
@road-dash:         5,2;

//// labels
@label-admin0:      #524640;
@label-admin1:      @boundary-line;
@label-place:       #25140d;
@label-poi:         #392d29;
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     40%;
@label-halo:        fadeout(@land, @label-fadeout);

@label-water:       darken(@ferry-line, 10%);
// green text is subtle so we don’t compute here
@label-park:        #394014;
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

//// text font

@font-regular:      'Roboto Condensed Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Medium', 'Arial Unicode MS Regular';
@font-physical:     'Roboto Condensed Italic', 'Arial Unicode MS Regular';
@font-poi:          'Roboto Medium', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Medium', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Bold';

//// map
Map {
//  buffer-size: 256;
}
