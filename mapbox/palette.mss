//// base
@land:              #d4d1c5;
@water:             #8fb1bf;
@river:             darken(@water, 15%);
@beach:             #c9c5ab;

//// landuse
@park:              #bdc4ac;
@wooded:            #b3c7b6;
@agriculture:       #adc7b2;
@religion:          #cecab9;
@healthcare:        #cfbcb2;
@educational:       @beach;
@sports:            #b2b88f;
@building:          #dbd9d0;

//// zone
@residential:       darken(@building, 5%);
@pedestrian:        desaturate(@sports, 16%);
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
@minor-fill:		#f1eee8;
@minor-casing: 		lighten(@motorway-casing, 20%);

@path-line:         lighten(@motorway-casing, 20%);
@path-fill:	        @minor-fill;
@path-casing:       lighten(@motorway-casing, 20%);

@rail-line: 		@primary-casing;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;
@road-dash:         5,2;

//// labels
@label-country:     #23120b;
@label-province:    @label-country;
@label-places:      @label-country;
@label-poi:         #3c3c3c;

@label-halo:        @land;

@label-water:       @ferry;
@label-park:        #1a3c11;

//// text font
@font-label: 		'Avenir Next Condensed Regular',  'Arial Unicode MS Regular';
@font-label2:       'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-physical:     'Avenir Next Condensed Medium Italic',  'Arial Unicode MS Regular';
@font-road:         'Avenir Book', 'Arial Unicode MS Regular';
@font-road2:        'Avenir Book', 'Arial Unicode MS Regular';
@font-shield:       'Arial Regular';

