//====== global palette file ======
// change this file to change color theme
// this one assumes you use medium to light colors, change
// 'lighten' to 'darken' if your theme is dark

//// base
@land:              #ebe9e6;
@water:             #b2b1ad;
@river:             #9a9893;
@beach:             #d9d8d4;

//// landuse
@park:              #ccccca;
@wooded:            #ccccca;
@agriculture:       #ccccca;
@religion:          #d9d9d7;
@healthcare:        #d9d9d7;
@educational:       @beach;
@sports:            #ccccca;
@building:          #e3e3e3;

//// zone
@residential:       darken(@building, 2%);
@pedestrian:        desaturate(@sports, 4%);
@commercial:        darken(@building, 3%);
@industrial:        #d9d9d7;
@military:          #d9d9d7;

//// transport
@parking:           #d9d9d7;
@airport:           @beach;
@aeroway:           lighten(@beach, 5%);
@terminal:          darken(@beach, 4%);

//// boundary
@boundary-line:     #212121;
@boundary-casing:   lighten(@boundary-line, 40%);

//// road
// reduce casing contrast by changing 'lighten' parameter below

@ferry-line:        #a3a2a1;

@motorway-fill:     #b7b7b7; //#d3d1d0;
@motorway-line:     #646464;
@motorway-casing:   #313131;
@motorway-link:     @motorway-fill;

@primary-line:      @motorway-line;
@primary-fill:   	  @motorway-fill;
@primary-casing: 	  @motorway-casing;

@secondary-line:    @primary-line;
@secondary-fill:   	@primary-fill;
@secondary-casing: 	@primary-casing;

@minor-line:        @motorway-line;
@minor-fill:   	    @motorway-fill;
@minor-casing: 	    @motorway-casing;

@path-line:         @motorway-line;
@path-fill:	        @minor-fill;
@path-casing:       @minor-casing;

@rail-line: 		    #404040;
@rail-casing: 		@land;
@rail-fill:         @minor-casing;
@road-dash:         5,2;

//// labels
@label-admin0:      #202020;
@label-admin1:      #202020;
@label-place:       #202020;
@label-poi:         #202020;

// transparency of halo color, to handle this correctly
// you will need mapnik 2.2+
@label-fadeout:     0%;
@label-halo:        fadeout(#ebe9e6, @label-fadeout);

@label-water:       #212a42;
// green text is subtle so we don’t compute here
@label-park:        #162b21;
@label-physical:    #202020;
@label-motorway:    #202020;
@label-primary:     #202020;
@label-path:        #202020;

// variable depth halo size, set to a float value requries
// mapnik 2.2+ to handle rendering correctly
@smart-halo:        2;
// deal with incorrect mapnik scale factor for some attributes
// (eg: text wrap)
@scale-factor:      2;

@default-halo:      2;

//// text font
// TODO: use open sourced unicode font

@font-regular:      'Avenir Next Condensed Regular', 'Arial Unicode MS Regular';
@font-heavy:        'Avenir Next Condensed Medium', 'Arial Unicode MS Bold';
@font-physical:     'Avenir Next Condensed Medium Italic', 'Arial Unicode MS Italic';
@font-poi:          'Avenir Next Condensed Regular', 'Arial Unicode MS Regular';
@font-motorway:     'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-primary:      'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-path:         'Avenir Next Regular', 'Arial Unicode MS Regular';
@font-shield:       'Roboto Bold', 'Arial Unicode MS Regular';


//// map
Map {
  buffer-size: 200;
}
