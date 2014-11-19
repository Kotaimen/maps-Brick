//
// Parameters and palettes
//

@theme-name:        'brick';


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
@residential:       #CFCABA; 
@pedestrian:        @park;
@commercial:        @residential;
@industrial:        @residential;
@military:          #aaaaaa;

//// transport
@parking:           @amenity;
@airport:           #BFB8A1;
@aeroway:           #E0DDCE;
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

@text-padding: 10;

@label-halo:        fadeout(@land, @label-fadeout);
@motorway-label-halo: 	fadeout(@motorway-fill,  @label-fadeout);
@primary-label-halo: 	fadeout(@primary-fill,  @label-fadeout);
@secondary-label-halo: 	fadeout(@secondary-fill,  @label-fadeout);
@minor-label-halo:		fadeout(@minor-fill,  @label-fadeout);
@path-label-halo:		fadeout(@path-fill,  @label-fadeout); 

// ========== Label Colors ==========

// place label
@label-admin0:      #423c35;
@label-admin1:      @boundary-line;
@label-place:       #6b5e4f; //#80321d;

// poi label
@label-poi:         #6b5e4f;
@label-water:       @ferry-line;
@label-park:        #556651;
@label-physical:    @casing;

// road label
@label-motorway:    @label-poi;
@label-primary:     @casing;
@label-path:        @casing;
@label-rail:        @rail-line;
@label-shield:      black;

// =========== Road attachments render order ===========

#road_tunnel, #road_tunnel_gen0,{
  ::casing { 
    opacity: 0.8; 
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
  image-filters: scale-hsla(0,1,0,0.8,0,0.8,0,0.8);
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
