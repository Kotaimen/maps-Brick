//
// Parameters and palettes
//

@theme-name:        'newspaper';

// ========== Halo Parameters ==========

// Text halo render quality, "fast" is considerablly faster, 
// but "full" is required for float halo radius and transprency
@halo-quality:      fast;

// Variable depth halo size, 
// actual blending is done in "Mason" composer.
@smart-halo:        0;

// Other halo size
@default-halo:      0;

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
@land:              #ebe9e6;
@water:             #a3a29f;
@river:             @water;

// basics
@building:          #cccccc; //#e3e2dc;
@sand:              #d9d8d4;

//// greenish
@park:              #ccccca;
@wooded:            @park;
@agriculture:       @wooded;
@sports:            @park;

//// amenities
@amenity:           #d9d8d4;
@religion:          @amenity;
@healthcare:        @amenity;
@educational:       @amenity;
@barrier:           darken(@amenity, 5%);

//// zone
@residential:       #d9d9d7;
@pedestrian:        @residential;
@commercial:        @residential;
@industrial:        @residential;
@military:          #cccccc;

//// transport
@parking:           @amenity;
@airport:           darken(@amenity, 11%);
@aeroway:           @building;
@terminal:          @amenity;

//// boundary
@boundary-line:     #25201f;
@boundary-casing:   @land;


// ========== Road Colors ==========

@road-dash:         6, 3;
@casing:            #25201f;

@ferry-line:        @casing;

@motorway-fill:     #ebe9e6;
@motorway-line:     #979491;
@motorway-casing:   @casing;
@motorway-link:     @motorway-fill;

@primary-line:      lighten(@motorway-line, 5%);
@primary-fill:   	@motorway-fill;
@primary-casing: 	@casing;//lighten(@casing, 5%);

@secondary-line:    @primary-line;
@secondary-fill:   	@primary-fill;
@secondary-casing: 	@casing;

@minor-line:        lighten(@motorway-line, 10%);
@minor-fill:   	    @motorway-fill;
@minor-casing: 	    @casing;

@path-line:         lighten(@motorway-line, 15%);
@path-fill:	        @minor-fill;
@path-casing:       lighten(@casing, 0%);

@trail-line:        lighten(@casing, 15%);
@trail-fill:        @amenity;
@trail-casing:      lighten(@casing, 10%);

@rail-line: 	    lighten(@casing, 15%);
@rail-fill:         @land;
@rail-casing:       @land;


// ========== Label Halo ==========

@label-halo:        fadeout(@land, @label-fadeout);


// ========== Label Colors ==========

@label-admin0:      #211d1c;
@label-admin1:      #211d1c;
@label-place:       #211d1c;
@label-poi:         #211d1c;


@label-water:       @ferry-line;
@label-park:        #211d1c;
@label-physical:    @casing;

// road label
@label-motorway:    @label-poi;
@label-primary:     @casing;
@label-path:        @casing;
@label-rail:        @casing;
@label-shield:      @label-motorway;

// =========== Road attachments render order ===========

#road_tunnel, #road_tunnel_gen0,{
  ::casing { 
    opacity: 0.5; 
//    image-filters: invert();
  }
  // knock out the casing
  ::inline { 
    opacity: 1; 
    comp-op: dst-out;  
  }  
  ::rail { opacity: 0.5; }
}

#road_tunnel2, #road_tunnel2_gen0 {
  ::casing { opacity: 0; }
  // then render transparent casing  
  ::inline { opacity: 0.5;}
  ::marker { opacity: 0.5;}
}

#road, #road_gen0 {
  ::casing { }
  ::inline {  }
  ::rail { }
  ::marker { }     
}

#shield_gen1, #shield {
//  direct-image-filters: gray();
}


// ========== Label Font ==========

//// text font
@label-text-transform: none;

@fall-back:         'Arial Unicode MS Regular';

@font-regular:      'American Typewriter Condensed', 'Arial Unicode MS Regular';
@font-heavy:        'American Typewriter Regular', 'Arial Unicode MS Regular';
@font-physical:     'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-poi:          'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Medium Italic', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Italic', 'Arial Unicode MS Regular';
@font-path:         'Roboto Italic', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Medium', 'Arial Unicode MS Regular';

// ========== Map ==========

Map {
  buffer-size: 512;
//  font-directory: ;
}
