//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #ebe9e6;
@water:             #a3a29f;
@river:             #918f8b;
@sand:              #d9d8d4;

//// landuse
@park:              fadeout(#ccccca, 10%);
@wooded:            #ccccca;
@agriculture:       #ccccca;
@religion:          #d9d9d7;
@healthcare:        #d9d9d7;
@educational:       #d9d8d4;
@sports:            #ccccca;
@building:          #e3e3e3;
@barrier:           darken(@building, 25%);

//// zone
@residential:       darken(@building, 2%);
@pedestrian:        desaturate(@sports, 4%);
@commercial:        darken(@building, 3%);
@industrial:        #d9d9d7;
@military:          #d9d9d7;

//// transport
@parking:           #d9d9d7;
@airport:           #d9d8d4;
@aeroway:           lighten(@sand, 5%);
@terminal:          darken(@sand, 5%);

//// boundary
@boundary-line:     #55524f;
@boundary-casing:   lighten(@boundary-line, 56%);

//// road
// reduce casing contrast by changing 'lighten' parameter below

@ferry-line:        #a3a2a1;

@motorway-fill:     #ebe9e6;
@motorway-line:     #979491;
@motorway-casing:   #25201f;
@motorway-link:     @motorway-fill;

@primary-line:      lighten(@motorway-line, 5%);
@primary-fill:   	@motorway-fill;
@primary-casing: 	lighten(@motorway-casing, 15%);

@secondary-line:    @primary-line;
@secondary-fill:   	@primary-fill;
@secondary-casing: 	@primary-casing;

@minor-line:        lighten(@motorway-line, 10%);
@minor-fill:   	    @motorway-fill;
@minor-casing: 	    lighten(@motorway-casing, 10%);

@path-line:         lighten(@motorway-line, 15%);
@path-fill:	        @minor-fill;
@path-casing:       @minor-casing;

@rail-line: 		@primary-casing;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;
@road-dash:         5,2;

//// labels
@label-admin0:      #25201f;
@label-admin1:      #25201f;
@label-place:       #25201f;
@label-poi:         #25201f;

// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(#ebe9e6, @label-fadeout);

@label-water:       #25201f;
// green text is subtle so we don’t compute here
@label-park:        #25201f;
@label-physical:    #25201f;
@label-motorway:    #25201f;
@label-primary:     #25201f;
@label-path:        #25201f;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

@default-halo:      1;

//// text font
// TODO: use open sourced unicode font
@font-regular:      'American Typewriter Condensed', 'Arial Unicode MS Regular';
@font-heavy:        'American Typewriter Regular', 'Arial Unicode MS Regular';
@font-physical:     'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-poi:          'American Typewriter Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Regular', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Bold', 'Arial Unicode MS Regular';

//// map
Map {
  buffer-size: 200;
}
