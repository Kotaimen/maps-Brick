//
// Parameters and palettes
//

@theme-name:        'moonlight';


// ========== Halo Parameters ==========

// Text halo render quality, "fast" is considerablly faster, 
// but "full" is required for float halo radius and transprency
@halo-quality:      full;

// Variable depth halo size, 
// actual blending is done in "Mason" composer.
@smart-halo:        1;

// Other halo size
@default-halo:      1;

// Transparency of halo color
@label-fadeout:     50%;


// ========== General Parameters ==========

// Deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap & filter size)
@scale-factor:      2;

// Adjust font size 
//@font-resize:       0;


// ========== Background Colors ==========

// base
@land:              #1B1B1F;
@water:             #1B2C40;
@river:             @water;

// basics
@building:          #202024;
@sand:              #282924;

//// greenish
@park:              #202924;
@wooded:            #262923;
@agriculture:       @park;
@sports:            @wooded;

//// amenities
@amenity:           #282924;
@religion:          @wooded;
@healthcare:        #292524;
@educational:       @amenity;
@barrier:           darken(@amenity, 5%);

//// zone
@residential:       #252529;
@pedestrian:        @land;
@commercial:        @residential;
@industrial:        @residential;
@military:          #2B2B2B;

//// transport
@parking:           @building;
@airport:           darken(@amenity, 2%);
@aeroway:           @building;
@terminal:          @amenity;

//// boundary
@boundary-line:     #325C40;
@boundary-casing:   @land;


// ========== Road Colors ==========

@road-dash:         6, 3;
@casing:            @land;

@ferry-line:        #1D416B;

@motorway-fill:     #402A27;
@motorway-line:     @motorway-fill;
@motorway-casing:   @casing;
@motorway-link:     @motorway-fill;


@primary-fill:   	#3D3131;
@primary-line:      @primary-fill;
@primary-casing: 	@casing;

@secondary-fill:    @primary-fill;
@secondary-line:    @secondary-fill;
@secondary-casing:  @casing;

@minor-fill:		#383535;
@minor-line:        @minor-fill;
@minor-casing: 		@casing;

@path-fill:	        @minor-fill;
@path-line:         @path-fill;
@path-casing:       @casing;

@trail-fill:	    @minor-fill;
@trail-line:        @trail-fill;
@trail-casing:      @casing;

// Desaturate gives rail slightly cool grey feel
@rail-fill:         @land;
@rail-line: 	    #494B4D;
@rail-casing:       @land;


// ========== Label Halo ==========

@text-padding: 10;

@label-halo:        	fadeout(@land, @label-fadeout);
@motorway-label-halo: 	fadeout(@land,  @label-fadeout);
@primary-label-halo: 	fadeout(@land,  @label-fadeout);
@secondary-label-halo: 	fadeout(@land,  @label-fadeout);
@minor-label-halo:		fadeout(@land,  @label-fadeout);
@path-label-halo:		fadeout(@land,  @label-fadeout); 

// ========== Label Colors ==========

// place label
@label-admin0:      #736655;
@label-admin1:      @boundary-line;
@label-place:       #B8985E;

// poi label
@label-poi:         #736655;
@label-water:       @ferry-line;
@label-park:        #5C6E57;
@label-physical:    #5C6E57;

// road label
@label-motorway:    #736655;
@label-primary:     @label-motorway;
@label-path:        #756A59;
@label-rail:        @label-motorway;

@label-shield:      black;

// =========== Road attachments render order ===========
/*
#landuse_gen0[zoom>=6][zoom<=9],
#landuse_gen1[zoom>=10][zoom<=12],
#landuse[zoom>=13] {
  ::texture {
    polygon-pattern-file: url('res/texture/halftone1.png'); 
    comp-op: soft-light;
    opacity: 0.25;
  }
}
*/
#road_tunnel, #road_tunnel_gen0,{
  ::casing { 
    opacity: 1; 
  }
  ::inline { 
    opacity: 0; 
  }  
  ::rail { opacity: 0.5; }
}

#road_tunnel2, #road_tunnel2_gen0 {
  ::casing { opacity: 0; }
// semi transparent tunnel
  ::inline { 
    opacity: 1; 
    image-filters: scale-hsla(0,1,0,0.5,0.1,0.8,0,1);
  }
  ::marker { opacity: 0.5;}
}

#road, #road_gen0 {
  ::casing { }
  ::inline { }
  ::rail { }	
  ::marker { }     
}

#shield_gen0, #shield_gen1, #shield {
  image-filters: scale-hsla(0,1,0,0.8,0,0.4,0,1);
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
@label-text-transform: uppercase;

@font-regular:      'Roboto Condensed Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Medium', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Condensed Italic', 'Arial Unicode MS Italic';
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
