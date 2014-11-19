//
// Parameters and palettes
//

@theme-name:        'smog';


// ========== Halo Parameters ==========

// Text halo render quality, "fast" is considerablly faster, 
// but "full" is required for float halo radius and transprency
@halo-quality:      fast;

// Variable depth halo size, 
// actual blending is done in "Mason" composer.
@smart-halo:        2;

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
@land:              #8F9590;
@water:             #9FC3BB;
@river:             @water;

// basics
@building:          #96A398;
@sand:              #A1A396;

//// greenish
@park:              #a0ab7b;
@wooded:            #8fab7b;
@agriculture:       @wooded;
@sports:            #C2D652;

//// amenities
@amenity:           #939E95;
@religion:          @amenity;
@healthcare:        #A39C96;
@educational:       #A3A093;
@barrier:           darken(@amenity, 5%);

//// zone
@residential:       #939E95;
@pedestrian:        @park;
@commercial:        @residential;
@industrial:        @residential;
@military:          #878B8C;

//// transport
@parking:           @amenity;
@airport:           #A3A093;
@aeroway:           @building;
@terminal:          @amenity;

//// boundary
@boundary-line:     #E1FAF7;
@boundary-casing:   @land;


// ========== Road Colors ==========

@road-dash:         6, 3;
@casing:            #6e7984;

@ferry-line:        #486A68;

@motorway-fill:     #7B7582;
@motorway-line:     darken(@motorway-fill, 3%);
@motorway-casing:   darken(@casing, 7%);
@motorway-link:     @motorway-fill;

@primary-fill:   	#738075;
@primary-line:      mix(@primary-fill, @land, 65%); 
@primary-casing: 	@casing;

@secondary-fill:    @primary-fill;
@secondary-line:    mix(@secondary-fill, @land, 65%);
@secondary-casing:  @casing;

@minor-fill:		@primary-fill;
@minor-line:        mix(@minor-fill, @land, 65%); 
@minor-casing: 		@casing;

@path-fill:	        @primary-fill;
@path-line:         mix(@primary-fill, @land, 65%); 
@path-casing:       @casing;

@trail-fill:	    @primary-fill;
@trail-line:        mix(@trail-fill, @land, 65%); 
@trail-casing:      @casing;

// Desaturate gives rail slightly cool grey feel
@rail-fill:         @land;
@rail-line: 	    #697282;
@rail-casing:       @land;


// ========== Label Halo ==========

@text-padding: 10;

@label-halo:            fadeout(@land, @label-fadeout);
@motorway-label-halo: 	fadeout(@motorway-fill,  @label-fadeout);
@primary-label-halo: 	fadeout(@primary-fill,  @label-fadeout);
@secondary-label-halo: 	fadeout(@secondary-fill,  @label-fadeout);
@minor-label-halo:		fadeout(@minor-fill,  @label-fadeout);
@path-label-halo:		fadeout(@path-fill,  @label-fadeout); 

// ========== Label Colors ==========

// place label
@label-admin0:      #BAEEF7;
@label-admin1:      #5B5F63;
@label-place:       #EDEDD5;

// poi label
@label-poi:         #5B5F63;
@label-water:       @ferry-line;
@label-park:        #587054;
@label-physical:    @label-admin0;

// road label
@label-motorway:    #5B5F63;
@label-primary:     #5B5F63;
@label-path:        #5B5F63;
@label-rail:        @rail-line;
@label-shield:      black;

// =========== Road attachments render order ===========

#road_tunnel, #road_tunnel_gen0,{
  ::casing { 
//    opacity: 1; 
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
  ::inline { opacity: 0.5; 
  }
  ::marker { opacity: 0.5;}
}

#road, #road_gen0 {
  ::casing { }
  ::inline {  }
  ::rail { }
  ::marker { }     
}

#shield_gen0, #shield_gen1, #shield {
  image-filters: scale-hsla(0,1,0,0.5,0,0.9,0,1);
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
@r17_min: 4;   @r17_path: 3;   @r17_cas: 2;
@r18_min: 6;   @r18_path: 4;   @r18_cas: 2;
@r19_min: 8;   @r19_path: 6;   @r19_cas: 4;
@r20_min: 14;  @r20_path: 8;   @r20_cas: 4;

// ========== Label Font ==========

//// text font
@label-text-transform: none;

@font-regular:      'Roboto Slab Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Slab Bold', 'Arial Unicode MS Bold';
@font-physical:     'Noto Serif Bold Italic', 'Arial Unicode MS Italic';
@font-poi:          'Noto Serif Italic', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Medium', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Regular', 'Arial Unicode MS Regular';
@font-path:         'Roboto Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Medium', 'Arial Unicode MS Bold';


// ========== Map ==========

Map {
  buffer-size: 512;
//  font-directory: ;
}
