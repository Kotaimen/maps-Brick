//
// Road and railway, requires grouped render
//

@line-clip: false;
@line-rasterizer: full;

// road overview
#road_gen0[zoom>=5][zoom<=8] {

  line-cap: round;
  line-join: round;
  line-clip: @line-clip;
  line-rasterizer: @line-rasterizer;

  [type='motorway'][link=0] {
    line-color: @motorway-line;
  }
  [type='primary'] {
    line-color: @primary-line;
  }
  [type='secondary'] {
    line-color: @secondary-line;
  }

  [zoom=5] {
    [type='motorway'],[type='trunk'] { line-width: 0.5; }
    [type='primary'],[type='secondary'] { line-width: 0.1; }
  }
  [zoom=6] {
    [type='motorway'],[type='trunk'] { line-width: 0.6; }
    [type='primary'],[type='secondary'] { line-width: 0.2; }
  }
  [zoom=7] {
    [type='motorway'],[type='trunk'] { line-width: 0.8; }
    [type='primary'],[type='secondary'] { line-width: 0.3; }
  }
  [zoom=8] {
    [type='motorway'],[type='trunk'] { line-width: 1; }
    [type='primary'],[type='secondary'] { line-width: 0.4; }
  }
}

// Road widths

@rdz10_maj: 1.5; @rdz10_med: 1;   @rdz10_min: 0.5;  @rdz10_cas: 1;
@rdz11_maj: 2;   @rdz11_med: 1.2; @rdz11_min: 0.7;  @rdz11_cas: 1;
@rdz12_maj: 2.5; @rdz12_med: 1.5; @rdz12_min: 1;    @rdz12_cas: 2;
@rdz13_maj: 3;   @rdz13_med: 1.5; @rdz13_min: 1;    @rdz13_cas: 2;
@rdz14_maj: 4;   @rdz14_med: 3;   @rdz14_min: 1.5;  @rdz14_cas: 2;
@rdz15_maj: 6;   @rdz15_med: 4;   @rdz15_min: 3;    @rdz15_cas: 2;
@rdz16_maj: 8;   @rdz16_med: 6;   @rdz16_min: 4;    @rdz16_cas: 2;
@rdz17_maj: 12;  @rdz17_med: 8;   @rdz17_min: 6;    @rdz17_cas: 2;
@rdz18_maj: 20;  @rdz18_med: 12;  @rdz18_min: 10;   @rdz18_cas: 3;

// Define attachments render order here.

#road_stage_tunnel {
  ::casing { 
    opacity: 0.8; 
//    image-filters: invert();
  }
  // knock out the casing
  ::inline { 
    opacity: 1; 
    comp-op: dst-out;  
//    image-filters: scale-hsla(0,1,0,0.2,0,1,0,1);
  }  
  // transparent rail/marker
  ::rail { opacity: 0.5; }
  ::marker { opacity: 0.5; }
}

#road_stage_tunnel2 {
  ::casing { opacity: 0; }
  // then render transparent casing  
  ::inline { opacity: 0.1; }
  ::rail { opacity: 0; }
  ::marker { opacity: 0;}
}


#road_stage {
  ::casing { }
  ::inline {  }
  ::rail { }
  ::marker { }     
}

// Detailed roads
#road_stage_tunnel[zoom>=9][class='highway'] ,
#road_stage_tunnel2[zoom>=9],
#road_stage[zoom>=9][class='highway'] {
  
  [type='motorway'] {
    ::casing {
      line-color: @motorway-casing;
      line-join: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [bridge=0] { line-cap: round; }
      [link=1] {
        // don’t need thin links since road are already thin zoom<=lv11
        [zoom=9] { line-width: @rdz10_maj + @rdz10_cas; }                     
        [zoom=10] { line-width: @rdz10_maj + @rdz10_cas; }             
        [zoom=11] { line-width: @rdz11_maj + @rdz11_cas; }                     
        [zoom=12] { line-width: @rdz12_maj/2 + @rdz12_cas/2; }      
        [zoom=13] { line-width: @rdz13_maj/2 + @rdz13_cas/2; }      
        [zoom=14] { line-width: @rdz14_maj/2 + @rdz14_cas/2; }      
        [zoom=15] { line-width: @rdz15_maj/2 + @rdz15_cas/2; }      
        [zoom=16] { line-width: @rdz16_maj/2 + @rdz16_cas/2; }      
        [zoom=17] { line-width: @rdz17_maj/2 + @rdz17_cas/2; }      
        [zoom>=18] { line-width: @rdz18_maj/2 + @rdz18_cas/2; }              
      }
      [link=0] {  
        [zoom=9] { line-width: @rdz10_maj + @rdz10_cas; }
        [zoom=10] { line-width: @rdz10_maj + @rdz10_cas; }             
        [zoom=11] { line-width: @rdz11_maj + @rdz11_cas; }             
        [zoom=12] { line-width: @rdz12_maj + @rdz12_cas; }      
        [zoom=13] { line-width: @rdz13_maj + @rdz13_cas; }      
        [zoom=14] { line-width: @rdz14_maj + @rdz14_cas; }      
        [zoom=15] { line-width: @rdz15_maj + @rdz15_cas; }      
        [zoom=16] { line-width: @rdz16_maj + @rdz16_cas; }      
        [zoom=17] { line-width: @rdz17_maj + @rdz17_cas; }      
        [zoom>=18] { line-width: @rdz18_maj + @rdz18_cas; }      
      }
    }    
    ::inline {
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      line-color: @motorway-fill;         
      [link=1] {
        [zoom>=14] { line-color: @motorway-link; }
        [zoom=9] { line-width: @rdz10_maj; } 
        [zoom=10] { line-width: @rdz10_maj; } 
        [zoom=11] { line-width: @rdz11_maj; }         
        [zoom=12] { line-width: @rdz12_maj/2 }      
        [zoom=13] { line-width: @rdz13_maj/2 }      
        [zoom=14] { line-width: @rdz14_maj/2 }      
        [zoom=15] { line-width: @rdz15_maj/2 }      
        [zoom=16] { line-width: @rdz16_maj/2 }      
        [zoom=17] { line-width: @rdz17_maj/2 }      
        [zoom>=18] { line-width: @rdz18_maj/2 }              
      }
      [link=0] {
        [zoom=9] { line-width: @rdz10_maj; } 
        [zoom=10] { line-width: @rdz10_maj; } 
        [zoom=11] { line-width: @rdz11_maj; }              
        [zoom=12] { line-width: @rdz12_maj; }
        [zoom=13] { line-width: @rdz13_maj; }
        [zoom=14] { line-width: @rdz14_maj; }
        [zoom=15] { line-width: @rdz15_maj; }
        [zoom=16] { line-width: @rdz16_maj; }
        [zoom=17] { line-width: @rdz17_maj; }
        [zoom>=18] { line-width: @rdz18_maj; }      
      }
    }
  }
  
  [type='primary'] {
    ::casing {
      line-color: @primary-line;
      line-join: round;
      [bridge=0] { line-cap: round; }      
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [link=1] {
        [zoom=9] { line-width: @rdz10_med + @rdz10_cas; }                      
        [zoom=10] { line-width: @rdz10_med + @rdz10_cas; }              
        [zoom=11] { line-width: @rdz11_med + @rdz11_cas; }                      
        [zoom=12] { line-width: @rdz12_med/2 + @rdz12_cas; }      
        [zoom=13] { line-width: @rdz13_med/2 + @rdz13_cas; }      
        [zoom=14] { line-width: @rdz14_med/2 + @rdz14_cas; }      
        [zoom=15] { line-width: @rdz15_med/2 + @rdz15_cas; }      
        [zoom=16] { line-width: @rdz16_med/2 + @rdz16_cas; }      
        [zoom=17] { line-width: @rdz17_med/2 + @rdz17_cas; }      
        [zoom>=18] { line-width: @rdz18_med/2 + @rdz18_cas; }              
      }
      [link=0] {  
        [zoom=9] { line-width: @rdz10_med + @rdz10_cas; }                              
        [zoom=10] { line-width: @rdz10_med + @rdz10_cas; }              
        [zoom=11] { line-width: @rdz11_med + @rdz11_cas; }              
        [zoom=12] { line-width: @rdz12_med + @rdz12_cas; }      
        [zoom=13] { line-width: @rdz13_med + @rdz13_cas; }      
        [zoom=14] { line-width: @rdz14_med + @rdz14_cas; }      
        [zoom=15] { line-width: @rdz15_med + @rdz15_cas; }      
        [zoom=16] { line-width: @rdz16_med + @rdz16_cas; }      
        [zoom=17] { line-width: @rdz17_med + @rdz17_cas; }      
        [zoom>=18] { line-width: @rdz18_med + @rdz18_cas; }      
      }
    }    
    ::inline {
      line-color: @primary-fill;               
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [link=1] {
        [zoom=9] { line-width: @rdz10_med; }
        [zoom=10] { line-width: @rdz10_med; }
        [zoom=11] { line-width: @rdz11_med; }        
        [zoom=12] { line-width: @rdz12_med/2 }      
        [zoom=13] { line-width: @rdz13_med/2 }      
        [zoom=14] { line-width: @rdz14_med/2 }      
        [zoom=15] { line-width: @rdz15_med/2 }      
        [zoom=16] { line-width: @rdz16_med/2 }      
        [zoom=17] { line-width: @rdz17_med/2 }      
        [zoom>=18] { line-width: @rdz18_med/2 }              
      }
      [link=0] {      
        [zoom=9] { line-width: @rdz10_med; }
        [zoom=10] { line-width: @rdz10_med; }
        [zoom=11] { line-width: @rdz11_med; }        
        [zoom=12] { line-width: @rdz12_med; }
        [zoom=13] { line-width: @rdz13_med; }
        [zoom=14] { line-width: @rdz14_med; }
        [zoom=15] { line-width: @rdz15_med; }
        [zoom=16] { line-width: @rdz16_med; }
        [zoom=17] { line-width: @rdz17_med; }
        [zoom>=18] { line-width: @rdz18_med; }      
      }
    }
  }

  [type='secondary']{
    ::casing {
      line-color: @secondary-casing;
      line-join: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [bridge=0]  { line-cap: round; }
      [zoom=9] { line-width: 0.5; line-color: @secondary-line; }
      [zoom=10] { line-width: 1; line-color: @secondary-line; }
      [zoom=11] { line-width: @rdz11_min + @rdz11_cas; }
      [zoom=12] { line-width: @rdz12_min + @rdz12_cas; }      
      [zoom=13] { line-width: @rdz13_min + @rdz13_cas; }      
      [zoom=14] { line-width: @rdz14_min + @rdz14_cas; }      
      [zoom=15] { line-width: @rdz15_min + @rdz15_cas; }      
      [zoom=16] { line-width: @rdz16_min + @rdz16_cas; }      
      [zoom=17] { line-width: @rdz17_min + @rdz17_cas; }      
      [zoom>=18] { line-width: @rdz18_min + @rdz18_cas; }      
    }    
    ::inline[zoom>=11] {
      line-color: @secondary-fill;               
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=9] { line-width: @rdz10_min; }
      [zoom=10] { line-width: @rdz10_min; }
      [zoom=11] { line-width: @rdz11_min; }
      [zoom=12] { line-width: @rdz12_min; }
      [zoom=13] { line-width: @rdz13_min; }
      [zoom=14] { line-width: @rdz14_min; }
      [zoom=15] { line-width: @rdz15_min; }
      [zoom=16] { line-width: @rdz16_min; }
      [zoom=17] { line-width: @rdz17_min; }
      [zoom>=18] { line-width: @rdz18_min; }            
    }
  }
 
  [type='minor'] {
    ::casing[zoom>=12] {
      line-color: @minor-casing;
      line-join: round;
      [bridge=0] { line-cap: round; }
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=12] { line-width: 0.5; line-color: @minor-line; }      
      [zoom=13] { line-width: 1; line-color: @minor-line;}      
      [zoom=14] { line-width: @rdz14_min + @rdz14_cas; }      
      [zoom=15] { line-width: @rdz15_min + @rdz15_cas; }      
      [zoom=16] { line-width: @rdz16_min + @rdz16_cas; }      
      [zoom=17] { line-width: @rdz17_min + @rdz17_cas; }      
      [zoom>=18] { line-width: @rdz18_min + @rdz18_cas; }      
    }    
    ::inline[zoom>=14] {
      line-color: @minor-fill;               
      line-join:round;
      [bridge=0][tunnel=0] { line-cap: round; }
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=13] { line-width: @rdz13_min; }
      [zoom=14] { line-width: @rdz14_min; }
      [zoom=15] { line-width: @rdz15_min; }
      [zoom=16] { line-width: @rdz16_min; }
      [zoom=17] { line-width: @rdz17_min; }
      [zoom>=18] { line-width: @rdz18_min; }            
    }
  }

  [type='path']  {    
    ::casing[zoom>=14] {
      line-color: @path-casing;
      line-join: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [bridge=0] { line-cap: round; }
      [zoom=14] { line-width: @rdz14_min/2 + @rdz15_cas;}      
      [zoom=15] { line-width: @rdz15_min/2 + @rdz15_cas; }      
      [zoom=16] { line-width: @rdz16_min/2 + @rdz16_cas; }      
      [zoom=17] { line-width: @rdz17_min/2 + @rdz17_cas; }      
      [zoom>=18] { line-width: @rdz18_min/2 + @rdz18_cas; }      
    }    
    ::inline[zoom>=14] {      
      line-color: @path-fill;               
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=14] { line-width: @rdz14_min/2; }      
      [zoom=15] { line-width: @rdz15_min/2; }
      [zoom=16] { line-width: @rdz16_min/2; }
      [zoom=17] { line-width: @rdz17_min/2; }
      [zoom>=18] { line-width: @rdz18_min/2; }            
    }    
  }

  [type='pedestrian']  {    
    ::casing[zoom>=14] {
      line-color: @trail-casing;
      line-join: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [bridge=0] { line-cap: round; }
      [zoom=14] { line-width: @rdz14_min/3 + @rdz15_cas;}      
      [zoom=15] { line-width: @rdz15_min/3 + @rdz15_cas; }      
      [zoom=16] { line-width: @rdz16_min/3 + @rdz16_cas; }      
      [zoom=17] { line-width: @rdz17_min/3 + @rdz17_cas; }      
      [zoom>=18] { line-width: @rdz18_min/3 + @rdz18_cas; }      
    }    
    ::inline[zoom>=14] {      
      line-color: @trail-fill;               
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=14] { line-width: @rdz14_min/3; }      
      [zoom=15] { line-width: @rdz15_min/3; }
      [zoom=16] { line-width: @rdz16_min/3; }
      [zoom=17] { line-width: @rdz17_min/3; }
      [zoom>=18] { line-width: @rdz18_min/3; }            
    }    
  }
  
  [type='proposed'] {    
    ::casing[zoom>=14] {
      line-color: @path-casing;
	  line-dasharray: @road-dash;
      line-join: round;
      line-clip: @line-clip;
      [zoom=14] { line-width: @rdz14_min/2 + @rdz15_cas;}      
      [zoom=15] { line-width: @rdz15_min/2 + @rdz15_cas; }      
      [zoom=16] { line-width: @rdz16_min/2 + @rdz16_cas; }      
      [zoom=17] { line-width: @rdz17_min/2 + @rdz17_cas; }      
      [zoom>=18] { line-width: @rdz18_min/2 + @rdz18_cas; }      
    }    
    ::inline[zoom>=14] {      
      line-color: @path-fill;               
	  line-dasharray: @road-dash;
      line-join:round;
      line-cap: butt;
      line-clip: @line-clip;
      [zoom=14] { line-width: @rdz14_min/2; }      
      [zoom=15] { line-width: @rdz15_min/2; }
      [zoom=16] { line-width: @rdz16_min/2; }
      [zoom=17] { line-width: @rdz17_min/2; }
      [zoom>=18] { line-width: @rdz18_min/2; }            
    }    
  }  
    
}

// Detailed railways

#road_stage_tunnel[zoom>=9][class='railway'] ,
#road_stage[zoom>=9][class='railway'] {
  [zoom=9] {
    ::rail {
      [type='rail'] {
        line-width: 0.75;
        line-color: @rail-line;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
      }
    }
  }
  
  [zoom>=10][zoom<12] {
    ::rail {
      [type='rail'] {
        line-width: 1;
        line-color: @rail-line;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;
      }
    }
  }
  
  [zoom>=12][zoom<=14] {
    ::casing {
      [bridge=1] {
        line-color: @rail-line;
        line-width: 4;
        fill/line-color: @land;
        fill/line-width: 2;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        fill/line-clip: @line-clip;
        fill/line-rasterizer: @line-rasterizer;        
      }
    }
    ::rail {
      [type='monorail'] {
        line-color: @rail-line;
        line-width: 0.5;
        dash/line-color: @rail-line;
        dash/line-width: 1;
        dash/line-dasharray: 1, 4;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
      [type='subway'] {
        line-color: @rail-fill;
        line-width: 1.5;
        dash/line-color: @rail-line;
        dash/line-width: 1;
        dash/line-dasharray: 1.5, 1;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
      [type='rail'] {
        line-color: @rail-line;
        line-width: 1.5;
        dash/line-color: @rail-casing;
        dash/line-width: 1;
        dash/line-dasharray: 5, 5;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
    }
  }  
  
  [zoom=15] {
    ::casing {
      [bridge=1] {
        line-color: @rail-line;
        line-width: 5;
        fill/line-color: @land;
        fill/line-width: 3;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        fill/line-clip: @line-clip;
        fill/line-rasterizer: @line-rasterizer;           
      }
    }
    ::rail {
      [type='monorail'] {
        line-color: @rail-line;
        line-width: 0.5;
        dash/line-color: @rail-line;
        dash/line-width: 1.5;
        dash/line-dasharray: 1, 5;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
      [type='subway'] {
        line-color: @rail-casing;
        line-width: 2;
        dash/line-color: @rail-line;
        dash/line-width: 1;
        dash/line-dasharray: 1.5, 1;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
      [type='rail'] {
        line-color: @rail-line;
        line-width: 1.5;
        dash/line-color: @rail-casing;
        dash/line-width: 1;
        dash/line-dasharray: 6, 6;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
    }
  }    
  

  [zoom=16] {
    ::casing {
      [bridge=1] {
        line-color: @rail-line;
        line-width: 7;
        fill/line-color: @land;
        fill/line-width: 5;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        fill/line-clip: @line-clip;
        fill/line-rasterizer: @line-rasterizer;           
      }
    }
    ::rail {
      [type='monorail'] {
        line-color: @rail-line;
        line-width: 1;
        dash/line-color: @rail-line;
        dash/line-width: 3;
        dash/line-dasharray: 1, 7;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
      [type='subway'] {
        line-color: @rail-casing;
        line-width: 3;
        dash/line-color: @rail-line;
        dash/line-width: 2;
        dash/line-dasharray: 1.5, 1;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
      [type='rail'] {
        line-color: @rail-line;
        line-width: 3;
        dash/line-color: @rail-casing;
        dash/line-width: 2;
        dash/line-dasharray: 8, 8;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
    }
  }      
  
  [zoom>=17] {
    ::casing {
      [bridge=1] {
        line-color: @rail-line;
        line-width: 10;
        fill/line-color: @land;
        fill/line-width: 7;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        fill/line-clip: @line-clip;
        fill/line-rasterizer: @line-rasterizer;           
      }
    }
    ::rail {
      [type='monorail'] {
        line-color: @rail-line;
        line-width: 1.2;
        dash/line-color: @rail-line;
        dash/line-width: 4;
        dash/line-dasharray: 1, 9;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
      [type='subway'] {
        line-color: @rail-casing;
        line-width: 5;
        dash/line-color: @rail-line;
        dash/line-width: 4;
        dash/line-dasharray: 2, 1;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
      [type='rail']{
        line-color: @rail-line;
        line-width: 5;
        dash/line-color: @rail-casing;
        dash/line-width: 3;
        dash/line-dasharray: 14, 14;
        line-clip: @line-clip;
        line-rasterizer: @line-rasterizer;        
        dash/line-clip: @line-clip;
      }
    }
  }      
}


#road_stage_tunnel[zoom>=15],
#road_stage[zoom>=15] {
  ::marker[class='highway'][oneway!=0]  {
    [zoom=15][type='motorway'],
    [zoom=15][type='primary'],
    [zoom>=16]
    {
      [type='motorway'] {
        marker-fill: @motorway-casing;
      }
      marker-fill: @primary-casing;
      marker-line-width: 0;
      marker-placement: line;
      marker-type: arrow;
      marker-clip: false;
      marker-height: 6;
      marker-file: url("res/arrow/oneway.svg");
      [oneway=-1] { marker-file: url("res/arrow/oneway-reverse.svg") }
      [zoom<=16] { marker-transform: "scale(0.6)"; }
      marker-spacing: 200;
      marker-ignore-placement: true;
    }
  }
}
