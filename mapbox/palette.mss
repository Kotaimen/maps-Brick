
// base
@land:              #d4d1c5;
@water:             #8fb1bf;
@river:             darken(@water, 15%);
@beach:             #c9c5ab;

// landuse
@park:              #bdc4ac;
@wooded:            #b3c7b6;
@agriculture:       #adc7b2;
@religion:          #cecab9;
@healthcare:        #cfbcb2;
@educational:       @beach;
@sports:            #b2b88f;
@building:          #dbd9d0;

// zone
@residential:       darken(@building, 5%);
@pedestrian:        desaturate(@sports, 16%);
@commercial:        darken(@building, 9%);
@industrial:        #cecab9;
@military:          #c4c2bb;

// transport
@parking:           #ceccc2;
@airport:           @beach;
@aeroway:           lighten(@beach, 10%);
@terminal:          darken(@beach, 7%);

// boundary
@boundary-line:     #676d73; //#ab421b;
@boundary-casing:   lighten(@boundary-line, 40%);
@boundary-dash:     10,5;

// road
@ferry-line:        #435b66;

@highway-line:      #d4957f;
@highway-fill:      @highway-fill;
@highway-casing:    #8a776e;
@highway-link:      lighten(@highway-body-color, 8%);

@major_road-line:   #d9cbbd;
@major_road-fill:   @major_road-line;
@major_road-casing: lighten(@highway-casing-color, 15%);


@minor_road-line:   #f1eee8;
@minor_road-fill:   @minor_road-line;
@minor_road-casing: lighten(@highway-casing-color, 20%);

@path-line:         @minor_road-line;
@path-body:			@minor_road-line;
@path-casing: 		lighten(@highway-casing-color, 25%);

@road-dash:         5,2;

// labels

