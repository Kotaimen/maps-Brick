//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #D8D6CA;
@water:             #4CC5BE;
@river:             @water;

//// basics
@building:          #C9C8BD;
@amenity:           #C9BEAD;
@sand:              @amenity;

//// greenish
@park:              #91BF58;
@wooded:            #56BF5A;
@agriculture:       #A9BF59;
@sports:            #61BF7B;

//// amenities
@religion:          @amenity;
@healthcare:        #C9B9AD;
@educational:       @amenity;
@barrier:           lighten(@building, 5%);

//// zone
@residential:       #E0DED3;
@pedestrian:        @residential;
@commercial:        @residential;
@industrial:        @residential;
@military:          @residential;

//// transport
@parking:           @building;
@airport:           darken(@amenity, 3%);
@aeroway:           @building;
@terminal:          @amenity;

//// boundary
@boundary-line:     #F2F0E4;
@boundary-casing:   @land;

//// road
// reduce casing contrast by changing 'lighten' parameter below

@road-dash:         3, 1.5;
@casing:            #858065;

@ferry-line:        @land;

@motorway-fill:     #ebb010; //lighten(@land, 6%);
@motorway-line:     #9E9A80;
@motorway-casing:   @casing;
@motorway-link:     #e5c774;

@primary-line:      lighten(@motorway-line, 6%);
@primary-fill:   	@motorway-link;
@primary-casing: 	lighten(@motorway-casing, 15%);

@secondary-line:    @primary-line;
@secondary-fill:   	#D6D0C5;
@secondary-casing: 	@primary-casing;

@minor-line:        lighten(@motorway-line, 10%);
@minor-fill:   	    #D6D0C5;
@minor-casing: 	    lighten(@motorway-casing, 10%);

@path-line:         lighten(@motorway-line, 15%);
@path-fill:	        #D6D0C5;
@path-casing:       @minor-casing;

@rail-line: 		#618385; //@primary-casing;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;

@label-admin0:      #a26868;
@label-admin1:      #4a4b53;
@label-place:       #CF1514;
@label-poi:         darken(@casing, 10%); //#C02D8A;

// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(@land, @label-fadeout);

@label-water:       #1A5C96;
// green text is subtle so we don’t compute here
@label-park:        #14690E;

@label-physical:    darken(@casing, 5%);
@label-motorway:    @label-physical;
@label-primary:     @label-physical;
@label-path:        @label-physical;
@label-shield:      black;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        1;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;
// controls text-halo-rasterizer fast/full
@halo-quality:      fast;

@default-halo:      1;

//// text font
@label-text-transform: none;

@font-regular:      'Avenir Next Condensed Medium', 'Arial Unicode MS Regular';
@font-heavy:        'Avenir Next Demi Bold', 'Arial Unicode MS Bold';
@font-physical:     'Avenir Next Condensed Medium Italic', 'Arial Unicode MS Italic';
@font-poi:          'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-primary:      'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-path:         'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-shield:       'Avenia Next Bold', 'Arial Unicode MS Bold';

//// map
Map {
  buffer-size: 500;
}
