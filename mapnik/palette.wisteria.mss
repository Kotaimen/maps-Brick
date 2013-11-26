//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #cad4de;
@water:             #7986a1;
@river:             lighten(@water, 15%);
@beach:             #b2baa3; // 13, 73

//// landuse
@park:              #a3bbae;
@wooded:            #a3bba3;
@agriculture:       #aabba3;
@religion:          #bab4ab;
@healthcare:        #bba3a3;
@educational:       @beach;
@sports:            #b5baab;
@building:          #b2bacc;

//// zone
@residential:       #c2c5cc;
@pedestrian:        @sports;
@commercial:        lighten(@building, 5%);
@industrial:        #b5abba;
@military:          #bab2ad;

//// transport
@parking:           #bab3ab;
@airport:           @beach;
@aeroway:           lighten(@beach, 10%);
@terminal:          darken(@beach, 7%);

//// boundary
@boundary-line:     #969575;
@boundary-casing:   desaturate(lighten(@boundary-line, 40%), 50%);
@boundary-dash:     10,5;

//// road
// reduce casing contrast by changing 'lighten' parameter below
@ferry-line:        @land;

@motorway-fill:     #86677f;//#7A3567;//#3d65af;
@motorway-line:     lighten(@motorway-fill, 16%);
@motorway-casing:   fadeout(@land, 50%);
@motorway-link:     lighten(@motorway-fill, 10%);

@primary-line:      darken(@primary-fill, 2%);
@primary-fill:   	#bb98b1;
@primary-casing: 	fadeout(@land, 50%);//lighten(@motorway-casing, 15%);

@secondary-line:    darken(@secondary-fill, 2%);
@secondary-fill:    desaturate(lighten(@primary-fill, 3%), 10%);
@secondary-casing:  fadeout(@land, 50%);//lighten(@motorway-casing, 15%);

@minor-line:        darken(@minor-fill, 10%);
@minor-fill:		#bdbdbd;
@minor-casing: 		@secondary-casing;//@land;//lighten(@motorway-casing, 20%);

@path-line:         @minor-line;
@path-fill:	        @minor-fill;
@path-casing:       @secondary-casing;//@land;//lighten(@motorway-casing, 20%);

@rail-line: 		desaturate(@water, 10%);
@rail-casing: 		@minor-casing;
@rail-fill:         @minor-fill;
@road-dash:         5,2;

//// labels
@label-admin0:      #6e0432;
@label-admin1:      darken(@boundary-line, 5%);
@label-place:       @label-admin0;
@label-poi:         desaturate(@label-admin0, 30%);
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     30%;
@label-halo:        fadeout(@land, @label-fadeout);

@label-water:       darken(@water, 15%);
// green text is subtle so we don’t compute here
@label-park:        darken(@park, 25%);
@label-physical:    @label-admin1;
@label-motorway:    #dadad3;
@label-primary:     @motorway-line;
@label-path:        @primary-line;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@default-halo:      1;
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;

//// text font
@font-regular:      'Roboto Condensed Light', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Regular', 'Arial Unicode MS Regular';
@font-physical:     'Roboto Condensed Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Condensed Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Regular', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Light', 'Arial Unicode MS Regular';
@font-shield:       'Arial Bold', 'Arial Unicode MS Regular';

//// map
Map {
  font-directory: url('/usr/share/fonts/Mac');
}
