#roads_gen0[zoom>=5][zoom<=8] {  	
  [type='motorway'],[type='trunk'] { 
    line-color: @highway-line;
  }
  [type='primary'],[type='secondary'] { 
    line-color: @major_road-line; 
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
    [type='primary'],[type='secondary'] { line-width: 0.4; }    
  }
  [zoom=8] {
	[type='motorway'],[type='trunk'] { line-width: 1; }
	[type='primary'],[type='secondary'] { line-width: 0.5; }    
  }
}

#roads_gen1[zoom>=9][zoom<=10] {
  [type='motorway'],[type='trunk'], [type='motoway_link'], [type='trunk_link'] { 
    line-color: @highway-line;
  }
  [type='primary'] { 
    line-color: @major_road-line; 
  }
  [type='secondary'] { 
    line-color: @minor_road-line; 
  }
  [type='rail'] { 
    line-color: @rail-line;
  }
  
  [zoom=9] {
	[type='motorway'],[type='trunk'],
	[type='motoway_link'], [type='trunk_link'] {      
      line-width: 1.5; 
    }
	[type='primary'],[type='secondary'] { 
      line-width: 0.75; 
    }    
    [type='rail'] { 
      line-width: 0.5;
      line-dasharray: 2,1;
    }
  }
  [zoom=10] {
	[type='motorway'],[type='trunk'],
	[type='motoway_link'], [type='trunk_link'] {      
      line-width: 1.5; 
    }
	[type='primary'],[type='secondary'] { 
      line-width: 1; 
    }    
    [type='rail'] { 
      line-width: 1;
      line-dasharray: 2,1;
    }
  }  
}
