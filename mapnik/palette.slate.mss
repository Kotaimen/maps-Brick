//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #dcd9d4;
@water:             #96b6d6;
@river:             @water;

//// basics
@building:          #d1cdc6;
@amenity:           #e1d4bf;
@sand:              #d3cbbd;

//// greenish
@park:              #bbd39c;
@wooded:            #c8d39c;
@agriculture:       #91c4a1;
@sports:            @wooded;

//// amenities
@religion:          @amenity;
@healthcare:        #D1BEB4;
@educational:       @amenity;
@barrier:           darken(@building, 9%);

//// zone
@residential:       @land;
@pedestrian:        @land;
@commercial:        @residential;
@industrial:        #e1d4bf;
@military:          #919090;

//// transport
@parking:           #e1d4bf;
@airport:           darken(@amenity, 7%);
@aeroway:           @building;
@terminal:          #b99f88;

//// boundary
@boundary-line:     #706b6b;
@boundary-casing:   @land;

//// road
// reduce casing contrast by changing 'lighten' parameter below

@road-dash:         5, 3;
@casing:            fadeout(@land, 50%);
@ferry-line:    	#384888;

@motorway-fill:     #6684c4; 
@motorway-casing:   @casing; 
@motorway-line:     lighten(@motorway-fill, 6%);
@motorway-link:     @motorway-fill;

@primary-fill:   	#e5a78e; 
@primary-casing: 	@casing; 
@primary-line:      darken(@primary-fill, 3%);

@secondary-fill:   	#c8b8a7;
@secondary-casing: 	@casing;
@secondary-line:    darken(@secondary-casing, 7%);

@minor-fill:   	    #bcb9b6;
@minor-casing: 	    @casing;
@minor-line:        lighten(@minor-fill, 5%);

@path-fill:	        #c4c1be;
@path-casing:       @casing;
@path-line:         @minor-fill;

@rail-fill:         @land;
@rail-casing: 		@land;
@rail-line:         #998082;

//// labels
@label-admin0:      #422c16;
@label-admin1:      #918475;
@label-place:       @label-admin0;
@label-poi:         #584735;
// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+

@label-fadeout:     50%;
@label-halo:        fadeout(@land, @label-fadeout);
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

@label-water:       #275e77;
@label-park:        #256633;
@label-physical:    #5c3811;

// road label
@label-motorway:    #0037a8;
@label-primary:     #746a5e;
@label-path:        #82776a;

@label-shield:      black;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      1;
@default-halo:      1;

//// text font
@label-text-transform: uppercase;

@font-regular:      'Roboto Condensed Bold Italic', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Black', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Bold Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Bold', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Bold', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Bold', 'Arial Unicode MS Regular';
@font-path:         'Roboto Medium', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Medium', 'Arial Unicode MS Bold';
//// map
Map {
  buffer-size: 0;
}
