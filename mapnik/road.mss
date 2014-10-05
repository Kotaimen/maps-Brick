//
// Road and railway, requires grouped render
//

@line-clip: false;
@line-rasterizer: full;

// road overview
#road_gen1[zoom>=5][zoom<=8] {

  line-cap: round;
  line-join: round;
  line-clip: @line-clip;
  line-rasterizer: @line-rasterizer;

  [type='motorway'][is_link=0] {
    line-color: @motorway-line;
  }
  [type='primary'][is_link=0] {
    line-color: @primary-line;
  }
  [type='secondary'][is_link=0] {
    line-color: @secondary-line;
  }

  [zoom=5] {
    [type='motorway'] { line-width: 0.5; }
    [type='primary'],[type='secondary'] { line-width: 0.1; }
  }
  [zoom=6] {
    [type='motorway'] { line-width: 0.6; }
    [type='primary'],[type='secondary'] { line-width: 0.2; }
  }
  [zoom=7] {
    [type='motorway'] { line-width: 0.8; }
    [type='primary'],[type='secondary'] { line-width: 0.3; }
  }
  [zoom=8] {
    [type='motorway'] { line-width: 1; }
    [type='primary'],[type='secondary'] { line-width: 0.4; }
  }
}

// Detailed roads
#road_tunnel_gen0[zoom>=9][zoom<=12][class='highway'],
#road_tunnel2_gen0[zoom>=9][zoom<=12],
#road_gen0[zoom>=9][zoom<=12][class='highway'],
#road_tunnel[zoom>=13][class='highway'] ,
#road_tunnel2[zoom>=13],
#road[zoom>=13][class='highway'] {
  
  [type='motorway'] {
    ::casing {
      line-color: @motorway-casing;
      line-join: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [is_bridge=0] { line-cap: round; }
      [is_link=1] {
        // don’t need thin links since road are already thin zoom<=lv10
        [zoom=9]   { line-width: 0; }                     
        [zoom=10]  { line-width: 0; }             
        [zoom=11]  { line-width: 0; }                     
        [zoom=12]  { line-width: @r12_maj/2 + @r12_cas; }      
        [zoom=13]  { line-width: @r13_maj/2 + @r13_cas; }      
        [zoom=14]  { line-width: @r14_maj/2 + @r14_cas; }      
        [zoom=15]  { line-width: @r15_maj/2 + @r15_cas; }      
        [zoom=16]  { line-width: @r16_maj/2 + @r16_cas; }      
        [zoom=17]  { line-width: @r17_maj/2 + @r17_cas; }      
        [zoom=18]  { line-width: @r18_maj/2 + @r18_cas; }
        [zoom=19]  { line-width: @r19_maj/2 + @r19_cas; }
        [zoom>=20] { line-width: @r20_maj/2 + @r20_cas; }
      }
      [is_link=0] {  
        [zoom=9]   { line-width: 0; }                     
        [zoom=10]  { line-width: 0; }             
        [zoom=11]  { line-width: 0; }                     
        [zoom=12]  { line-width: @r12_maj + @r12_cas; }      
        [zoom=13]  { line-width: @r13_maj + @r13_cas; }      
        [zoom=14]  { line-width: @r14_maj + @r14_cas; }      
        [zoom=15]  { line-width: @r15_maj + @r15_cas; }      
        [zoom=16]  { line-width: @r16_maj + @r16_cas; }      
        [zoom=17]  { line-width: @r17_maj + @r17_cas; }      
        [zoom=18]  { line-width: @r18_maj + @r18_cas; }
        [zoom=19]  { line-width: @r19_maj + @r19_cas; }
        [zoom>=20] { line-width: @r20_maj + @r20_cas; }
      }
    }    
    ::inline {
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      line-color: @motorway-fill;
      [zoom<=10] { line-color: @motorway-line; }
      [is_link=1] {
        [zoom>=14] { line-color: @motorway-link; }
        [zoom=9]   { line-width: @r9_maj/2; line-color: @motorway-line; } 
        [zoom=10]  { line-width: @r10_maj/2; line-color: @motorway-line; } 
        [zoom=11]  { line-width: @r11_maj/2; line-color: @motorway-line; }         
        [zoom=12]  { line-width: @r12_maj/2; }      
        [zoom=13]  { line-width: @r13_maj/2; }      
        [zoom=14]  { line-width: @r14_maj/2; }      
        [zoom=15]  { line-width: @r15_maj/2; }      
        [zoom=16]  { line-width: @r16_maj/2; }      
        [zoom=17]  { line-width: @r17_maj/2; }      
        [zoom=18]  { line-width: @r18_maj/2; }
        [zoom=19]  { line-width: @r19_maj/2; }
        [zoom>=20] { line-width: @r20_maj/2; }
      }
      [is_link=0] {
        [zoom=9]   { line-width: @r9_maj; line-color: @motorway-line; } 
        [zoom=10]  { line-width: @r10_maj; line-color: @motorway-line; } 
        [zoom=11]  { line-width: @r11_maj; line-color: @motorway-line; }              
        [zoom=12]  { line-width: @r12_maj; }
        [zoom=13]  { line-width: @r13_maj; }
        [zoom=14]  { line-width: @r14_maj; }
        [zoom=15]  { line-width: @r15_maj; }
        [zoom=16]  { line-width: @r16_maj; }
        [zoom=17]  { line-width: @r17_maj; }
        [zoom=18]  { line-width: @r18_maj; }
        [zoom=19]  { line-width: @r19_maj; }
        [zoom>=20] { line-width: @r20_maj; }
      }
    }
  }
  
  [type='primary'] {
    ::casing {
      line-color: @primary-casing;
      line-join: round;
      [is_bridge=0] { line-cap: round; }      
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [is_link=1] {
        [zoom=9]  { line-width: 0; }                      
        [zoom=10] { line-width: 0; }              
        [zoom=11] { line-width: 0; }                      
        [zoom=12] { line-width: @r12_med/2 + @r12_cas; }      
        [zoom=13] { line-width: @r13_med/2 + @r13_cas; }      
        [zoom=14] { line-width: @r14_med/2 + @r14_cas; }      
        [zoom=15] { line-width: @r15_med/2 + @r15_cas; }      
        [zoom=16] { line-width: @r16_med/2 + @r16_cas; }      
        [zoom=17] { line-width: @r17_med/2 + @r17_cas; }      
        [zoom=18] { line-width: @r18_med/2 + @r18_cas; }
		[zoom=19] { line-width: @r19_med/2 + @r19_cas; }
		[zoom>=20] { line-width: @r20_med/2 + @r20_cas; }              
      }
      [is_link=0] {  
        [zoom=9]  { line-width: 0; }                              
        [zoom=10] { line-width: 0; }              
        [zoom=11] { line-width: 0; }              
        [zoom=12] { line-width: @r12_med + @r12_cas; }      
        [zoom=13] { line-width: @r13_med + @r13_cas; }      
        [zoom=14] { line-width: @r14_med + @r14_cas; }      
        [zoom=15] { line-width: @r15_med + @r15_cas; }      
        [zoom=16] { line-width: @r16_med + @r16_cas; }      
        [zoom=17] { line-width: @r17_med + @r17_cas; }      
        [zoom=18] { line-width: @r18_med + @r18_cas; }
		[zoom=19] { line-width: @r19_med + @r19_cas; }
		[zoom>=20] { line-width: @r20_med + @r20_cas; }  
      }
    }    
    ::inline {
      line-color: @primary-fill;               
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [is_link=1] {
        [zoom=9]  { line-width: @r9_med; line-color: @primary-line; }
        [zoom=10] { line-width: @r10_med; line-color: @primary-line; }
        [zoom=11] { line-width: @r11_med; line-color: @primary-line; }        
        [zoom=12] { line-width: @r12_med/2; }      
        [zoom=13] { line-width: @r13_med/2; }      
        [zoom=14] { line-width: @r14_med/2; }      
        [zoom=15] { line-width: @r15_med/2; }      
        [zoom=16] { line-width: @r16_med/2; }      
        [zoom=17] { line-width: @r17_med/2; }      
        [zoom=18] { line-width: @r18_med/2; }
		[zoom=19] { line-width: @r19_med/2; }
		[zoom>=20] { line-width: @r20_med/2; }              
      }
      [is_link=0] {      
        [zoom=9]  { line-width: @r9_med; line-color: @primary-line; }
        [zoom=10] { line-width: @r10_med; line-color: @primary-line; }
        [zoom=11] { line-width: @r11_med; line-color: @primary-line; }        
        [zoom=12] { line-width: @r12_med; }
        [zoom=13] { line-width: @r13_med; }
        [zoom=14] { line-width: @r14_med; }
        [zoom=15] { line-width: @r15_med; }
        [zoom=16] { line-width: @r16_med; }
        [zoom=17] { line-width: @r17_med; }
        [zoom=18] { line-width: @r18_med; }
        [zoom=19] { line-width: @r19_med; }
        [zoom>=20] { line-width: @r20_med; }    
      }
    }
  }

  [type='secondary']{
    ::casing {
      line-color: @secondary-casing;
      line-join: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [is_bridge=0]  { line-cap: round; }
      [zoom=9]  { line-width: 0; }
      [zoom=10] { line-width: 0; }
      [zoom=11] { line-width: 0; }
      [zoom=12] { line-width: 0; }      
      [zoom=13] { line-width: @r13_norm + @r13_cas; }      
      [zoom=14] { line-width: @r14_norm + @r14_cas; }      
      [zoom=15] { line-width: @r15_norm + @r15_cas; }      
      [zoom=16] { line-width: @r16_norm + @r16_cas; }      
      [zoom=17] { line-width: @r17_norm + @r17_cas; }      
      [zoom=18] { line-width: @r18_norm + @r18_cas; }
	  [zoom=19] { line-width: @r19_norm + @r19_cas; }
	  [zoom>=20] { line-width: @r20_norm + @r20_cas; } 
    }    
    ::inline[zoom>=11] {
      line-color: @secondary-fill;               
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=9]  { line-width: @r10_norm; line-color: @secondary-line;}
      [zoom=10] { line-width: @r10_norm; line-color: @secondary-line;}
      [zoom=11] { line-width: @r11_norm; line-color: @secondary-line;}
      [zoom=12] { line-width: @r12_norm; line-color: @secondary-line;}
      [zoom=13] { line-width: @r13_norm; }
      [zoom=14] { line-width: @r14_norm; }
      [zoom=15] { line-width: @r15_norm; }
      [zoom=16] { line-width: @r16_norm; }
      [zoom=17] { line-width: @r17_norm; }
      [zoom=18] { line-width: @r18_norm; }
	  [zoom=19] { line-width: @r19_norm; } 
	  [zoom>=20] { line-width: @r20_norm; }             
    }
  }
 
  [type='minor'] {
    ::casing[zoom>=14] {
      line-color: @minor-casing;
      line-join: round;
      [is_bridge=0] { line-cap: round; }
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=12] { line-width: 0; }      
      [zoom=13] { line-width: 0; }      
      [zoom=14] { line-width: 0; }      
      [zoom=15] { line-width: @r15_min + @r15_cas; }      
      [zoom=16] { line-width: @r16_min + @r16_cas; }      
      [zoom=17] { line-width: @r17_min + @r17_cas; }      
      [zoom=18] { line-width: @r18_min + @r18_cas; }
	  [zoom=19] { line-width: @r19_min + @r19_cas; }
	  [zoom=20] { line-width: @r20_min + @r20_cas; }      
    }    
    ::inline[zoom>=12] {
      line-color: @minor-fill;
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;
      [zoom=12] { line-width: @r12_min; line-color: @minor-line; } 
      [zoom=13] { line-width: @r13_min; line-color: @minor-line; }
      [zoom=14] { line-width: @r14_min; line-color: @minor-line; }
      [zoom=15] { line-width: @r15_min; }
      [zoom=16] { line-width: @r16_min; }
      [zoom=17] { line-width: @r17_min; }
      [zoom=18] { line-width: @r18_min; }
      [zoom=19] { line-width: @r19_min; }
      [zoom>=20] { line-width: @r20_min; }
    }
  }

  [type='path']  {    
    ::casing[zoom>=14] {
      line-color: @path-casing;
      line-join: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [is_bridge=0] { line-cap: round; }
      [zoom=14] { line-width: 0; }      
      [zoom=15] { line-width: 0; }      
      [zoom=16] { line-width: @r16_path + @r16_cas; }      
      [zoom=17] { line-width: @r17_path + @r17_cas; }      
      [zoom=18] { line-width: @r18_path + @r18_cas; }
	  [zoom=19] { line-width: @r19_path + @r19_cas; }
	  [zoom=20] { line-width: @r20_path + @r20_cas; }      
    }    
    ::inline[zoom>=14] {      
      line-color: @path-fill;               
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=14] { line-width: @r14_path; line-color: @minor-line; }      
      [zoom=15] { line-width: @r15_path; line-color: @minor-line; }
      [zoom=16] { line-width: @r16_path; }
      [zoom=17] { line-width: @r17_path; }
      [zoom=18] { line-width: @r18_path; }
	  [zoom=19] { line-width: @r19_path; }
	  [zoom=20] { line-width: @r20_path; }            
    }    
  }

  [type='pedestrian']  {    
    ::casing[zoom>=14] {
      line-color: @trail-casing;
      line-join: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [is_bridge=0] { line-cap: round; }
      [zoom=14] { line-width: 0; }      
      [zoom=15] { line-width: 0; }      
      [zoom=16] { line-width: @r16_path/3 + @r16_cas; }      
      [zoom=17] { line-width: @r17_path/3 + @r17_cas; }      
      [zoom=18] { line-width: @r18_path/3 + @r18_cas; }
	  [zoom=19] { line-width: @r19_path/3 + @r19_cas; }
	  [zoom>=20] { line-width: @r20_path/3 + @r20_cas; }    
    }    
    ::inline[zoom>=14] {      
      line-color: @trail-fill;               
      line-join:round;
      line-cap: round;
      line-clip: @line-clip;
      line-rasterizer: @line-rasterizer;      
      [zoom=14] { line-width: @r14_path/2; line-color: @trail-line; }      
      [zoom=15] { line-width: @r15_path/2; line-color: @trail-line; }
      [zoom=16] { line-width: @r16_path/2; }
      [zoom=17] { line-width: @r17_path/2; }
      [zoom=18] { line-width: @r18_path/2; }
	  [zoom=19] { line-width: @r19_path/2; }
	  [zoom>=20] { line-width: @r20_path/2; }         
    }    
  }
  
  [type='proposed'] {    
    ::casing[zoom>=14] {
      line-color: @path-casing;
	  line-dasharray: @road-dash;
      line-join: round;
      line-clip: @line-clip;
      [zoom=14] { line-width: 0; }      
      [zoom=15] { line-width: 0; }      
      [zoom=16] { line-width: @r16_min/2 + @r16_cas; }      
      [zoom=17] { line-width: @r17_min/2 + @r17_cas; }      
      [zoom>=18] { line-width: @r18_min/2 + @r18_cas; }      
    }    
    ::inline[zoom>=14] {      
      line-color: @path-fill;               
	  line-dasharray: @road-dash;
      line-join:round;
      line-cap: butt;
      line-clip: @line-clip;
      [zoom=14] { line-width: @r14_min/2; line-color: @path-line; }      
      [zoom=15] { line-width: @r15_min/2; line-color: @path-line; }
      [zoom=16] { line-width: @r16_min/2; }
      [zoom=17] { line-width: @r17_min/2; }
      [zoom>=18] { line-width: @r18_min/2; }            
    }    
  }  
    
}

// Detailed railways
#road_tunnel_gen0[zoom>=9][zoom<=12][class='railway'] ,
#road_gen0[zoom>=9][zoom<=12][class='railway'],
#road_tunnel[zoom>=13][class='railway'] ,
#road[zoom>=13][class='railway'] {
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
      [is_bridge=1] {
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
      [is_bridge=1] {
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
      [is_bridge=1] {
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
      [is_bridge=1] {
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

#road_tunnel2[zoom>=15],
#road[zoom>=15] {
  ::marker[class='highway'][is_oneway!=0]  {
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
      [is_oneway=-1] { marker-file: url("res/arrow/oneway-reverse.svg") }
      [zoom<=16] { marker-transform: "scale(0.6)"; }
      marker-spacing: 200;
      marker-ignore-placement: true;
    }
  }
}
