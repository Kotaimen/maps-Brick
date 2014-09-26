//
// Parameters and palettes
//

@theme-name:        'newspaper';


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
@casing:            #313131;

@ferry-line:        #313131;

@motorway-fill:     #b7b7b7;
@motorway-line:     #646464;
@motorway-casing:   #313131;
@motorway-link:     @motorway-fill;

@primary-line:      lighten(@motorway-line, 10%);
@primary-fill:   	@motorway-fill;
@primary-casing: 	@motorway-casing;

@secondary-line:    lighten(@motorway-line, 10%);
@secondary-fill:   	@primary-fill;
@secondary-casing: 	@primary-casing;

@minor-line:        lighten(@motorway-line, 15%);
@minor-fill:   	    @motorway-fill;
@minor-casing: 	    @motorway-casing;

@path-line:         lighten(@motorway-line, 15%);
@path-fill:	        @minor-fill;
@path-casing:       @minor-casing;

@trail-line:        lighten(@motorway-line, 15%);
@trail-fill:        @minor-fill;
@trail-casing:      @minor-fill;

// Desaturate gives rail slightly cool grey feel
@rail-line: 	    #404040;
@rail-fill:         @land;
@rail-casing:       @land;


// ========== Label Halo ==========


@label-halo:        fadeout(@land, @label-fadeout);


// ========== Label Colors ==========

// place label
@label-admin0:      #202020;
@label-admin1:      #202020;
@label-place:       #202020;

// poi label
@label-poi:         #202020;
@label-water:       #212a42;
@label-park:        #162b21;
@label-physical:    #202020;

// road label
@label-motorway:    #202020;
@label-primary:     #202020;
@label-path:        #202020;
@label-rail:        #202020;
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
  ::inline { opacity: 0.1; 
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
//  image-filters: scale-hsla(0,1,0,0.8,0,0.8,0,0.8);
}

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
