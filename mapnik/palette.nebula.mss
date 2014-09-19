//
// Parameters and palettes
//

@theme-name:        'nebula';

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
@land:              #0e0e0e;
@water:             #131e2a;
@river:             @water;

// basics
@building:          #4077c2;
@sand:              @wooded;

//// greenish
@park:              @wooded;
@wooded:            #061611;
@agriculture:       #071d0c;
@sports:            @agriculture;

//// amenities
@amenity:           #6078ff;
@religion:          @amenity;
@healthcare:        @amenity;
@educational:       @amenity;
@barrier:           lighten(@amenity, 5%);

//// zone
@residential:       #182649;
@pedestrian:        @residential;
@commercial:        #5286ff;
@industrial:        @residential;
@military:          #131313;

//// transport
@parking:           @amenity;
@airport:           @commercial;
@aeroway:           @building;
@terminal:          @industrial;

//// boundary
@boundary-line:     #bcd5ec;
@boundary-casing:   @land;


// ========== Road Colors ==========

@road-dash:         3, 1.5;
@casing:            #193268;

@ferry-line:        #36c2bf;

@motorway-fill:     @land;
@motorway-line:     @casing;
@motorway-casing:   @casing;
@motorway-link:     @motorway-fill;

@primary-line:      @casing;
@primary-fill:      @land;
@primary-casing: 	@casing;

@secondary-line:    @casing;
@secondary-fill:    @land;
@secondary-casing:  @casing;

@minor-line:        @casing;
@minor-fill:        @land;
@minor-casing:      @casing;

@path-line:         @casing;
@path-fill:	        @land;
@path-casing:       @casing;

@trail-line:        @casing;
@trail-fill:	    @land;
@trail-casing:      @casing;

// desaturate gives rail slightly cool grey feel
@rail-line: 	    @ferry-line;
@rail-casing: 	    @land;
@rail-fill:         @educational;

// ========== Label Halo ==========

@label-halo:        fadeout(@land, @label-fadeout);


// ========== Label Colors ==========

@label-admin0:      @boundary-line;
@label-admin1:      @boundary-line;
@label-place:       #7cd1d0;
@label-poi:         @label-place;

@label-water:       darken(@ferry-line, 17%);
@label-park:        @label-place;
@label-physical:    @label-poi;

@label-park:        @label-place;
@label-physical:    @label-poi;
@label-motorway:    #AFAFD5;
@label-primary:     @label-motorway;
@label-path:        @label-primary;
@label-shield:      red;

// =========== Road attachments render order ===========

#road_stage_tunnel {
  ::casing { 
    opacity: 1; 
    image-filters: scale-hsla(0,1,0.5,1,0,0.5,0,1);
  }
  // knock out the casing
  ::inline { 
    opacity: 1; 
    comp-op: multiply;  
  }  
  // transparent rail/marker
  ::rail { opacity: 0.5; }
  ::marker { opacity: 0.5; }
}

#road_stage_tunnel2 {
  ::casing { opacity: 0; }
  // then render transparent casing  
  ::inline { 
    opacity: 0; 
//    comp-op: dst-out;  
  }
  ::rail { opacity: 0; }
  ::marker { opacity: 0;}
}


#road_stage {
  ::casing { }
  ::inline {  }
  ::rail { }
  ::marker { }     
}

#shield_gen0,#shield_all {    
  image-filters: invert();
}


// ========== Label Font ==========

//// text font
@label-text-transform: none;

@fall-back:         'Arial Unicode MS Regular';

@font-regular:      'Roboto Condensed Bold', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Black', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Bold Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Bold', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Bold', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Bold', 'Arial Unicode MS Regular';
@font-path:         'Roboto Medium', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Medium', 'Arial Unicode MS Bold';

// ========== Map ==========

Map {
  buffer-size: 512;
//  font-directory: ;
}
