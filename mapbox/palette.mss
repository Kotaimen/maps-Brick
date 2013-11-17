
//// base
@land:              #d4d1c5;
@water:             #8fb1bf;
@river:             darken(@water, 15%);
@beach:             #c9c5ab;

//// landuse
@park:              #bdc4ac;
@wooded:            #b3c7b6;
@agriculture:       #adc7b2;
@religion:          #ccceb9;
@healthcare:        #cfbcb2;
@educational:       @beach;
@sports:            #b2b88f;
@building:          #dbd9d0;

//// zone
@residential:       darken(@building, 5%);
@pedestrian:        desaturate(@sports, 11%);
@commercial:        darken(@building, 9%);
@industrial:        #cecab9;
@military:          #c4c2bb;

//// transport
@parking:           #ceccc2;
@airport:           @beach;
@aeroway:           lighten(@beach, 10%);
@terminal:          darken(@beach, 7%);

//// boundary
@boundary-line:     #676d73;
@boundary-casing:   desaturate(lighten(@boundary-line, 40%), 50%);
@boundary-dash:     10,5;

//// road
@ferry-line:        #547280;

@motorway-fill:     #d4957f;
@motorway-line:     darken(@motorway-fill, 2%);
@motorway-casing:   #8a776e;
@motorway-link:     lighten(@motorway-fill, 8%);

@primary-line:      lighten(@motorway-casing, 10%);
@primary-fill:   	#d9cbbd;
@primary-casing: 	lighten(@motorway-casing, 15%);

@secondary-line:    lighten(@motorway-casing, 15%);
@secondary-fill:    @primary-fill;
@secondary-casing:  lighten(@motorway-casing, 15%);

@minor-line:        lighten(@motorway-casing, 20%);
@minor-fill:		#ebe8e2;
@minor-casing: 		lighten(@motorway-casing, 20%);

@path-line:         lighten(@motorway-casing, 20%);
@path-fill:	        @minor-fill;
@path-casing:       lighten(@motorway-casing, 20%);

@rail-line: 		@primary-casing;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;
@road-dash:         5,2;

//// labels
@label-xtra:        #ab421b;
@label-admin0:      #6e5f57;
@label-admin1:      @boundary-line;
@label-place:       #381f13;
@label-poi:         #57443e;
@label-hospital:    #593a2d;
@label-fadeout:     35%;
@label-halo:        fadeout(@land, @label-fadeout);

@label-water:       darken(@ferry-line, 10%);
@label-park:        #2c4c22;
@label-physical:    darken(@motorway-casing, 10%);
@label-motorway:    @label-poi;
@label-primary:     @motorway-casing;
@label-path:        @primary-line;

// variable depth halo size
@smart-halo:        1;
// deal with incorrect mapnik scale factor (eg: text wrap)
@scale-factor:      1;  

//// text font
@font-regular:      'Avenir Next Condensed Regular';
@font-heavy:        'Avenir Next Regular';
@font-physical:     'Avenir Next Condensed Italic';
@font-poi:          'Avenir Next Medium';
@font-shield:       'Arial Regular';
@font-motorway:     'Avenir Medium';
@font-primary:      'Avenir Medium';
@font-path:         'Avenir Book';

//// map
Map {
  background-color: @water;
  buffer-size: 256;
}
