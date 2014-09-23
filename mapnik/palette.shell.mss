//
// Parameters and palettes
//

@theme-name:        'shell';


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
@land:              #cad4de;
@water:             #8392b0;
@river:             @water;

// basics
@building:          #b5bec7;
@sand:              #b2baa3;

//// greenish
@park:              #a3bba3;
@wooded:            #a3bba3;
@agriculture:       @park;
@sports:            #b5baab;

//// amenities
@amenity:           #bab4ab;
@religion:          @amenity;
@healthcare:        #b9abab;
@educational:       @amenity;
@barrier:           darken(@amenity, 5%);

//// zone
@residential:       #c2c5cc;
@pedestrian:        @park;
@commercial:        @residential;
@industrial:        #acafb6;
@military:          #9b9b9b;

//// transport
@parking:           #bab3ab;
@airport:           @sand;
@aeroway:           lighten(@sand, 10%);
@terminal:          @industrial;

//// boundary
@boundary-line:     #7c7873;
@boundary-casing:   @land;


// ========== Road Colors ==========

@road-dash:         6, 3;
@casing:            @land;

@ferry-line:        @land;

@motorway-fill:     #b29ebb;
@motorway-line:     @motorway-fill;
@motorway-casing:   fadeout(@casing, 50%);
@motorway-link:     @motorway-fill;

@primary-line:      @primary-fill;
@primary-fill:   	#b9adb9;
@primary-casing: 	fadeout(@land, 50%);

@secondary-line:    @secondary-fill;
@secondary-fill:    #b6b4af;
@secondary-casing:  fadeout(@land, 50%);

@minor-line:        @secondary-line;
@minor-fill:		@secondary-fill;
@minor-casing: 		@secondary-casing;

@path-line:         @minor-line;
@path-fill:	        @minor-fill;
@path-casing:       @secondary-casing;

@trail-line:        @minor-line;
@trail-fill:	    @minor-fill;
@trail-casing:      @secondary-casing;

// Desaturate gives rail slightly cool grey feel
@rail-line: 	    desaturate(@water, 10%);
@rail-fill:         @land;
@rail-casing:       @land;


// ========== Label Halo ==========


@label-halo:        fadeout(@land, @label-fadeout);


// ========== Label Colors ==========

// place label
@label-admin0:      #734564;
@label-admin1:      @boundary-line;
@label-place:       @label-admin0;

// poi label
@label-poi:         desaturate(@label-admin0, 30%);
@label-water:       darken(@water, 15%);
@label-park:        darken(@park, 35%);
@label-physical:    @label-admin0;

// road label
@label-motorway:    @label-admin0;
@label-primary:     @label-admin0;
@label-path:        @label-admin0;
@label-rail:        @rail-line;

@label-shield:      black;

// =========== Road attachments render order ===========

#road_tunnel, #road_tunnel_gen0,{
  ::casing { 
    opacity: 1; 
    image-filters: scale-hsla(0,1,0.4,1,0,0.6,0,1);
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
//    image-filters: scale-hsla(0,1,0,0.2,0,1,0,1);
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
  image-filters: scale-hsla(0,1,0,0.5,0,0.8,0,0.8);
}

// ========== Label Font ==========

//// text font
@label-text-transform: none;
@fall-back:         'Arial Unicode MS Regular';

@font-regular:      'Avenir Next Condensed Medium', 'Arial Unicode MS Regular';
@font-heavy:        'Avenir Next Demi Bold', 'Arial Unicode MS Bold';
@font-physical:     'Avenir Next Condensed Medium Italic', 'Arial Unicode MS Italic';
@font-poi:          'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-primary:      'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-path:         'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-shield:       'Avenia Next Bold', 'Arial Unicode MS Bold';

// ========== Map ==========

Map {
  buffer-size: 512;
//  font-directory: ;
}
