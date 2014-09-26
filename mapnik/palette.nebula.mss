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
@motorway-label-halo: 	fadeout(@motorway-fill,  @label-fadeout);
@primary-label-halo: 	fadeout(@primary-fill,  @label-fadeout);
@secondary-label-halo: 	fadeout(@secondary-fill,  @label-fadeout);
@minor-label-halo:		fadeout(@minor-fill,  @label-fadeout);
@path-label-halo:		fadeout(@path-fill,  @label-fadeout); 

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
@label-rail:        @label-primary;

@label-shield:      black;

// =========== Road attachments render order ===========

#road_tunnel, #road_tunnel_gen0,{
  ::casing { 
    opacity: 0.5; 
  }
  // knock out the casing
  ::inline { 
    opacity: 1; 
//    comp-op: dst-out;  
  }  
  ::rail { opacity: 0.5; }
}

#road_tunnel2, #road_tunnel2_gen0 {
  ::casing { opacity: 0; }
  // then render transparent casing  
  ::inline { opacity: 0; }
  ::marker { opacity: 0.5;}
}

#road, #road_gen0 {
  ::casing { }
  ::inline {  }
  ::rail { }
  ::marker { }     
}

#shield_gen0, #shield_gen1, #shield {
  image-filters: invert()
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
