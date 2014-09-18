//
// Parameters and palettes
//

// ========== Halo Parameters ==========

// Text halo render quality, "fast" is considerablly faster, 
// but "full" is required for float halo radius and transprency
@halo-quality:      fast;

// Variable depth halo size, 
// actual blending is done in "Mason" composer.
@smart-halo:        1;

// Other halo size
@default-halo:      1;

// Transparency of halo color
@label-fadeout:     0%;


// ========== General Parameters ==========

// Deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap & filter size)
@scale-factor:      2;

// Adjust font size 
//@font-resize:       0;


// ========== Background Colors ==========

// base
@land:              #D1CEC2;
@water:             #8CACBA;
@river:             @water;

// basics
@building:          #D9D7CC;
@sand:              #c2b795;

//// greenish
@park:              #B5BF9D;
@wooded:            #A0BAA1;
@agriculture:       @wooded;
@sports:            #9cbc9d;//@park;

//// amenities
@amenity:           #C4C0B1;
@religion:          @amenity;
@healthcare:        #D1BEB4;
@educational:       #ccc4b8;
@barrier:           darken(@amenity, 5%);

//// zone
@residential:       #CCC8B8;
@pedestrian:        @park;
@commercial:        @residential;
@industrial:        @residential;
@military:          #aaaaaa;

//// transport
@parking:           @amenity;
@airport:           #BFB8A1;
@aeroway:           @building;
@terminal:          @amenity;

//// boundary
@boundary-line:     #8c8982;
@boundary-casing:   @land;


// ========== Road Colors ==========

@road-dash:         6, 3;
@casing:            #99847A;

@ferry-line:        #5b6b80;

@motorway-fill:     #d69880;
@motorway-line:     @motorway-fill;
@motorway-casing:   fadeout(@casing, 0%);
@motorway-link:     lighten(@motorway-fill, 8%);

@primary-line:      lighten(@casing, 13%);
@primary-fill:      #D4C5B6;
@primary-casing: 	lighten(@motorway-casing, 14%);

@secondary-line:    lighten(@casing, 16%);
@secondary-fill:    @primary-fill;
@secondary-casing:  lighten(@motorway-casing, 14%);

@minor-line:        lighten(@casing, 20%);
@minor-fill:        #E0DDCE;
@minor-casing:      lighten(@motorway-casing, 18%);

@path-line:         lighten(@casing, 20%);
@path-fill:	        @minor-fill;
@path-casing:       lighten(@motorway-casing, 18%);

@trail-line:        lighten(@casing, 20%);
@trail-fill:        desaturate(@primary-fill, 8%);
@trail-casing:      lighten(@motorway-casing, 18%);

// Desaturate gives rail slightly cool grey feel
@rail-line: 	    #a19d9a;
@rail-fill:         @land;
@rail-casing:       @land;


// ========== Label Halo ==========

@label-halo:        fadeout(@land, @label-fadeout);


// ========== Label Colors ==========

@label-admin0:      #4d463e;
@label-admin1:      @boundary-line;
@label-place:       #80321d;
@label-poi:         #6b5e4f;


@label-water:       @ferry-line;
@label-park:        #556651;
@label-physical:    @casing;

// road label
@label-motorway:    @label-poi;
@label-primary:     @casing;
@label-path:        @casing;
@label-shield:      @label-motorway;



// ========== Label Font ==========

//// text font
@label-text-transform: uppercase;
@fall-back:         'Arial Unicode MS Regular';

@font-regular:      'Roboto Condensed Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Medium', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Regular', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Light', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Medium', 'Arial Unicode MS Bold';


// ========== Map ==========

Map {
  buffer-size: 512;
//  font-directory: ;
}
