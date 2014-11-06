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
@smart-halo:        2;

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
@motorway-label-halo: 	fadeout(@motorway-fill,  @label-fadeout);
@primary-label-halo: 	fadeout(@primary-fill,  @label-fadeout);
@secondary-label-halo: 	fadeout(@secondary-fill,  @label-fadeout);
@minor-label-halo:		fadeout(@minor-fill,  @label-fadeout);
@path-label-halo:		fadeout(@path-fill,  @label-fadeout); 

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

#shield_gen0, #shield_gen1, #shield {
//  direct-image-filters: gray();
}


// =========== Road Width ===========

// major       medium         normal
@r9_maj:  1;   @r9_med:  0.5; @r9_norm: 0.3;
@r10_maj: 1.2; @r10_med: 0.7; @r10_norm: 0.5; 
@r11_maj: 2;   @r11_med: 1;   @r11_norm: 0.7; 
@r12_maj: 2.5; @r12_med: 1.5; @r12_norm: 1; 
@r13_maj: 3;   @r13_med: 2;   @r13_norm: 1.5; 
@r14_maj: 4;   @r14_med: 3;   @r14_norm: 2; 
@r15_maj: 6;   @r15_med: 4;   @r15_norm: 3;   
@r16_maj: 8;   @r16_med: 6;   @r16_norm: 4;   
@r17_maj: 14;  @r17_med: 8;   @r17_norm: 6;   
@r18_maj: 28;  @r18_med: 14;  @r18_norm: 8;
@r19_maj: 48;  @r19_med: 28;  @r19_norm: 14;
@r20_maj: 64;  @r20_med: 56;  @r20_norm: 28;

// minor       path            casing
@r9_min:  0.1; @r9_path:  0;   @r9_cas: 0;
@r10_min: 0.3; @r10_path: 0.1; @r10_cas: 0;
@r11_min: 0.5; @r11_path: 0.3; @r11_cas: 0;
@r12_min: 0.7; @r12_path: 0.5; @r12_cas: 1;
@r13_min: 1;   @r13_path: 0.7; @r13_cas: 1;
@r14_min: 1.5; @r14_path: 1;   @r14_cas: 2;
@r15_min: 2;   @r15_path: 1.5; @r15_cas: 2;
@r16_min: 3;   @r16_path: 2;   @r16_cas: 2;
@r17_min: 4;   @r17_path: 3;   @r17_cas: 3;
@r18_min: 6;   @r18_path: 4;   @r18_cas: 3;
@r19_min: 8;   @r19_path: 6;   @r19_cas: 4;
@r20_min: 14;  @r20_path: 8;   @r20_cas: 4;


// ========== Label Font ==========

//// text font
@label-text-transform: uppercase;

@fall-back:         'Arial Unicode MS Regular';

@font-regular:      'American Typewriter Condensed', 'Arial Unicode MS Regular';
@font-heavy:        'American Typewriter Regular', 'Arial Unicode MS Regular';
@font-physical:     'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-poi:          'Baskerville SemiBold Italic', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Medium', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Bold', 'Arial Unicode MS Regular';

// ========== Map ==========

Map {
  buffer-size: 512;
//  font-directory: ;
}
