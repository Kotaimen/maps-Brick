//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #0e0e0e;
@water:             #131e2a;
@river:             @water;
@sand:              @wooded;

//// landuse
@park:              @wooded;
@wooded:            #061611;
@agriculture:       #071d0c;
@sports:            @agriculture;

@building:          #4077c2;
@barrier:           @land;
@parking:           @educational;

@religion:          #6078ff;
@healthcare:        @commercial;
@educational:       #365680;

//// zone
@residential:       #182649;
@pedestrian:        @wooded;
@commercial:        #5286ff;
@industrial:        @religion;
@military:          #131313;

//// transport
@airport:           @commercial;
@aeroway:           @building;
@terminal:          @industrial;

//// boundary
@boundary-line:     #bcd5ec;
@boundary-casing:   @land;
@boundary-dash:     10, 5;

//// road
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

// desaturate gives rail slightly cool grey feel
@rail-line: 	    @ferry-line;
@rail-casing: 	    @land;
@rail-fill:         @educational;


//// labels
@label-admin0:      @boundary-line;
@label-admin1:      @boundary-line;
@label-place:       #7cd1d0;
@label-poi:         @label-place;

// transparency of halo color, set to 0% if 'smart halo'
// is used later in post processing
@label-fadeout:     30%;
@label-halo:        fadeout(@land, @label-fadeout); //#2c5d8e;

// controls text-halo-rasterizer fast/full
@halo-quality:      full;
@label-water:       darken(@ferry-line, 17%);
// green text is subtle so we don’t compute here
@label-park:        @label-place;
@label-physical:    @label-poi;
@label-motorway:    #AFAFD5;
@label-primary:     @label-motorway;
@label-path:        @label-primary;
@label-shield:      white;


// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        2;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;

@default-halo: 	    2;

//// text font
// TODO: use open sourced unicoa de font
@label-text-transform: uppercase;

@font-regular:      'Roboto Condensed Bold', 'Arial Unicode MS Regular';
@font-heavy:        'Roboto Black', 'Arial Unicode MS Bold';
@font-physical:     'Roboto Bold Italic', 'Arial Unicode MS Italic';
@font-poi:          'Roboto Bold', 'Arial Unicode MS Regular';
@font-motorway:     'Roboto Bold', 'Arial Unicode MS Regular';
@font-primary:      'Roboto Bold', 'Arial Unicode MS Regular';
@font-path:         'Roboto Medium', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Medium', 'Arial Unicode MS Bold';

//// map
Map {
//  buffer-size: 500;
}
