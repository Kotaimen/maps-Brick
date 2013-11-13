
// natural earth boundary
#10m_admin0, #10m_disurpted
{
  ::casing {
    line-width: 0;
  	line-color: @boundary-casing;
    line-opacity: 0.5;
  	line-join: round;
    line-cap: round;
  	[zoom=3] { line-width: 1; }
  	[zoom=4] { line-width: 2; }
  	[zoom=5] { line-width: 3; }
  	[zoom=6] { line-width: 4; }
  	[zoom>6] { line-width: 5; }
  }
  ::body {
    line-width: 0;
  	line-color: @boundary-line;
  	line-join: round;
    [zoom=2] { line-width: 0.25; }
  	[zoom=3] { line-width: 0.75; }
  	[zoom=4] { line-width: 1; }
  	[zoom=5] { line-width: 1; }
  	[zoom=6] { line-width: 1.5; }
  	[zoom>6] { line-width: 2; }
    [featurecla='Disputed (please verify)'] {
      [zoom=3] { line-dasharray:4,1; }
      [zoom=4] { line-dasharray:5,2; }
      [zoom=5] { line-dasharray:6,2; }
      [zoom=6] { line-dasharray:8,3; }
      [zoom>6] { line-dasharray:10,3; }
    }
    [featurecla='Breakaway'] {
      [zoom=3] { line-dasharray: 3,2; }
      [zoom=4] { line-dasharray: 4,4; }
      [zoom=5] { line-dasharray: 5,5; }
      [zoom=6] { line-dasharray: 6,6; }
      [zoom>6] { line-dasharray: 8,8; }
    }
    [featurecla='Claim boundary'] {
      line-dasharray: 1,3;
      [zoom>6] { line-dasharray: 2,4; }
    }
    [featurecla='Indefinite (please verify)'] {
      line-dasharray: 6,1;
    }
  }
}


#10m_marine_indicator {
  [zoom=2][scalerank<=2], 
  [zoom=3][scalerank<=3], 
  [zoom=4][scalerank<=4], 
  [zoom=5][scalerank<=4], 
  [zoom=6][scalerank<=5], 
  [zoom=7][scalerank<=6], 
  [zoom>=8] {
    ::casing {
      line-color: @boundary-casing;
      line-opacity: 0.5;
      line-join: round;
      line-cap: round;
      line-width: 3;    
    }  
    ::body {
        [featurecla='Marine Indicator Disputed'] {
        [zoom=3] { line-dasharray:4,1; }
        [zoom=4] { line-dasharray:5,2; }
        [zoom=5] { line-dasharray:6,2; }
        [zoom=6] { line-dasharray:8,3; }
        [zoom>6] { line-dasharray:10,3; }
      }
      line-color: @boundary-line;
      line-join: round;
      line-cap: round;
      line-width: 1.5;    
    }  
  }
}


#10m_admin1 {
  [zoom=3][scalerank<=1],
  [zoom=4][scalerank<=2],
  [zoom=5][scalerank<=3],
  [zoom=6][scalerank<=4],
  [zoom>6],
  {
    ::casing {
      line-width: 0;
      line-color: @boundary-casing;
      line-opacity: 0.25;
      line-join: round;
      line-cap: round;
      [zoom=4] { line-width: 1; }
      [zoom=5] { line-width: 1; }
      [zoom>=6] { line-width: 3; }
    }
    ::body {
      line-width: 0;
  	  line-color: @boundary-line;
      line-opacity: 0.5;
      line-join: round;
      line-dasharray: @boundary-dash;
      [zoom=3] { line-width: 0.25; }
      [zoom=4] { line-width: 0.4; }
      [zoom=5] { line-width: 0.5; }
      [zoom=6] { line-width: 0.6; }
      [zoom>6] { line-width: 1; }
    }
  }
}

#10m_geographicline[zoom<=8] {
  ::text
    [name='Equator'],
    [name='International Date Line'],
    [name='Arctic Circle'],
    [name='Antarctic Circle'],
    {
  line-width: 0.75;
  line-color: @boundary-line;
  line-dasharray: 5,2;
   }
}


// osm admin areas
#osm_admin[zoom>=11] {
  [admin_level=4] {
    ::casing {
      line-color: @boundary-casing;
      line-join: round;
      line-cap: round;
      line-width: 3;
    }
    ::body {
      line-color: @boundary-line;
      line-join: round;
      line-width: 1.5;
    }
  }
}
