//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #cad4de;
@water:             #7986a1;
@river:             lighten(@water, 15%);
@sand:              #b2baa3; 

//// landuse
@park:              #a3bbae;
@wooded:            #a3bba3;
@agriculture:       #aabba3;
@religion:          #bab4ab;
@healthcare:        #bba3a3;
@educational:       @sand;
@sports:            #b5baab;
@building:          #bec6d7;
@barrier:           darken(@building, 4%);

//// zone
@residential:       #c2c5cc;
@pedestrian:        @sports;
@commercial:        lighten(@building, 3%);
@industrial:        #b5abba;
@military:          #bab2ad;

//// transport
@parking:           #bab3ab;
@airport:           @sand;
@aeroway:           lighten(@sand, 10%);
@terminal:          darken(@sand, 7%);

//// boundary
@boundary-line:     #969575;
@boundary-casing:   desaturate(lighten(@boundary-line, 40%), 50%);
@boundary-dash:     10,5;

//// road
// reduce casing contrast by changing 'lighten' parameter below
@ferry-line:        @land;

@casing:            @land;

@motorway-fill:     #977a91;//#7A3567;//#3d65af;
@motorway-line:     desaturate(lighten(@motorway-fill, 16%), 3%);
@motorway-casing:   fadeout(@casing, 50%);
@motorway-link:     lighten(@motorway-fill, 10%);

@primary-line:      desaturate(darken(@primary-fill, 5%), 5%);
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
@label-admin0:      #6c0f37;
@label-admin1:      darken(@boundary-line, 5%);
@label-place:       @label-admin0;
@label-poi:         desaturate(@label-admin0, 30%);
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(@land, @label-fadeout);

@label-water:       darken(@water, 15%);
// green text is subtle so we don’t compute here
@label-park:        spin(darken(@park, 35%), 5%);
@label-physical:    @label-admin1;
@label-motorway:    saturate(darken(@motorway-fill, 20%), 15%);
@label-primary:     darken(@motorway-fill, 8%);
@label-path:        @primary-line;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@default-halo:      1;
@smart-halo:        1;
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;

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
  font-directory: url('/usr/share/fonts/Mac');
}
