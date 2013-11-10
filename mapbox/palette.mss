
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
@boundary-line:     #676d73;
@boundary-casing:   desaturate(lighten(@boundary-line, 40%), 50%);
@boundary-dash:     10,5;

// road
@ferry-line:        #435b66;

@highway-line:      #d4957f;
@highway-fill:      @highway-line;
@highway-casing:    #8a776e;
@highway-link:      lighten(@highway-fill, 8%);

@major_road-line:   lighten(@highway-casing, 10%);
@major_road-fill:   #d9cbbd;
@major_road-casing: lighten(@highway-casing, 15%);

@minor_road-line:   lighten(@highway-casing, 36%);
@minor_road-fill:   #f1eee8;
@minor_road-casing: lighten(@highway-casing, 20%);

@path-line:         @minor_road-line;
@path-body:			@minor_road-line;
@path-casing: 		lighten(@highway-casing, 25%);

@road-dash:         5,2;

@rail-line: 		@major_road-casing;
@rail-body: 		@land;


// labels

//
