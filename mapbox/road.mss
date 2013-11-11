//// road overview
#roads_gen0[zoom>=5][zoom<=8] {
  line-cap: round;
  line-join: round;
  line-clip: false;
  
  [type='motorway'], [type='trunk'] { 
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

//// high level roads
#roads_gen1[zoom>=9][zoom<=11][class='highway'] {
  [render='casing'] {
  	line-join: round;    
  }
  [render='inline'] {
  	line-join: round;    
	line-cap: round;    
  }
  line-width: 0;
 
  [type='motorway'],[type='trunk'],
  [type='motoway_link'],[type='trunk_link'] { 
	[render='casing'] { line-color: @motorway-casing; }
	[render='inline'] { line-color: @motorway-fill; }
    [zoom=9] {
      [render='casing'] { line-width: 3; }
      [render='inline'] { line-width: 1; }      
    }
    [zoom>=10] {
      [render='casing'] { line-width: 4; }
      [render='inline'] { line-width: 2; }      
    }    
  }

  [type='primary'], [type='primary_link'] { 
    [render='casing'] { line-color: @primary-casing; }
	[render='inline'][zoom<=10] { line-color: @primary-line; }
	[render='inline'][zoom>=11] { line-color: @primary-fill; }    
    [zoom=9] { 
      [render='inline'] { line-width: 0.75; }
    }
    [zoom=10] { 
      [render='inline'] { line-width: 1; }
    }
	[zoom>=11] {
      [render='casing'] { line-width: 3; }
      [render='inline'] { line-width: 1; }            
    }
  }

  [type='secondary'], [type='secondary_link'] { 
	[render='inline'] { line-color: @primary-line; }
    [zoom=9] { 
      [render='inline'] { line-width: 0.4; }
    }
    [zoom=10] { 
      [render='inline'] { line-width: 0.6; }
    }
    [zoom>=11] { 
      [render='inline'] { line-width: 0.8; }
    }    
  }
  
  [type='tertiary'], [type='tertiary_link'] { 
	[render='inline'] { line-color: @minor-line; }
    [zoom>=11] { 
      [render='inline'] { line-width: 0.4; }
    }    
  }

}

#roads_gen1[zoom>=9][zoom<=11][class='railway'] {
  [render='inline'] { 
    line-width: 0.5; 
    line-color: @rail-line; 
    line-dasharray: 1, 1;
  }
}

// roads



