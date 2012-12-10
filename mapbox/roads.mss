/*
#building[zoom>12][zoom<=16] {
  polygon-fill:@building-color;
  [zoom>=14] {
    line-color:darken(@building-color,10);
    line-width:0.2;
    
  }
  [zoom>=16] {
    line-color:darken(@building-color,20);
    line-width:0.4;
  }
}

#building_3d[zoom>=17] {
  building-fill:@building-color;
  building-fill-opacity: 0.7;
  [zoom=17] { building-height:4; }
  [zoom>=18] { building-height:8; }
}


///////////////////////////////////////////////////
// Political boundary
///////////////////////////////////////////////////

.boundary {
  ::casing {
    line-width: 0;
  	line-color: @land-color;
    line-opacity: 0.5;
  	line-join: round;
  	line-cap: round;
  }
  ::body {
    line-width: 0;    
  	line-color: @boundary-color;
  	line-join: round;
  	line-cap: round;
  }
}

#10m_admin0 {
  ::casing {
  	[zoom=3] { line-width: 2; }
  	[zoom=4] { line-width: 3; }
  	[zoom=5] { line-width: 3.5; }
  	[zoom>5] { line-width: 4; }
  }
  ::body {
  	[zoom=2] { line-width: 1; }
  	[zoom=3] { line-width: 1; }
  	[zoom=4] { line-width: 2; }
  	[zoom=5] { line-width: 2.5; }
  	[zoom>5] { line-width: 3; }
  }
}

#10m_admin1 {
  [zoom=3][scalerank<=3],  
  [zoom=4][scalerank<=4],
  [zoom=5][scalerank<=5],
  [zoom=6][scalerank<=6],    
  [zoom>=7],    
  {
  ::casing {
  	[zoom=4] { line-width: 2; }
  	[zoom=5] { line-width: 2; }
  	[zoom>5] { line-width: 3; }
  }
  ::body {
    line-dasharray: 8, 4,1,4;
  	[zoom=3] { line-width: 0.7; }      
  	[zoom=4] { line-width: 1; }
  	[zoom=5] { line-width: 1; }
  	[zoom>5] { line-width: 1.5; }
  }
  }
}

///////////////////////////////////////////////////
// Road skeleton
///////////////////////////////////////////////////


#10m_roads[zoom>4][zoom<10][roadType!='Ferry Route'] {
  [ScaleRank>=8]
  {
  	::casing {
      line-color: @major_road-casing-color;
      line-width: 0;
  	}
    ::body[zoom>=6] {
      line-color: @major_road-body-color;
      [zoom=7] { line-width: 0.5;}
      [zoom=8] { line-width: 0.75;}
      [zoom=9] { line-width: 1;}
  	}
  }
  [ScaleRank>5][ScaleRank<8] {
  ::casing[zoom>=9] {
      line-color: @major_road-casing-color;
//      [zoom=9] { line-width: 2.;}
  	}
    ::body[zoom>=5] {
      line-color: @major_road-body-color;
      [zoom=5] { line-width: 0.5;}
      [zoom=6] { line-width: 1;}
      [zoom=7] { line-width: 1.5;}
      [zoom=8] { line-width: 1.5;}
      [zoom=9] { line-width: 2;}
  	}
  }
  [ScaleRank<=5]
  {
  	::casing[zoom>=7] {
      line-color: @highway-casing-color;
      [zoom=7] { line-width: 2.5;}
      [zoom=8] { line-width: 3;}
      [zoom=9] { line-width: 4;}
  	}
    ::body[zoom>=4] {
      line-color: @highway-body-color;
      [zoom=4] { line-width: 0.75;}
      [zoom=5] { line-width: 1.25;}
      [zoom=6] { line-width: 1.5;}
      [zoom=7] { line-width: 2;}
      [zoom=8] { line-width: 2;}
      [zoom=9] { line-width: 2;}
  	}
  }
}

#10m_rail[zoom>=7][zoom<11] {
  ::dash {
	[scalerank<=8][zoom=6] {line-width: 2; line-color: @rail-color; line-dasharray: 1,4;}
	[scalerank<=8][zoom=7] {line-width: 2.4; line-color: @rail-color; line-dasharray: 1,6;}
	[scalerank<=9][zoom=8] {line-width: 3; line-color: @rail-color; line-dasharray: 1,7;}
    [zoom>8] {line-width: 3; line-color: @rail-color; line-dasharray: 1,8;}
  }
  ::body {
    [scalerank<=8][zoom=6] {line-width: 0.6; line-color: @rail-color; line-join: round; }
    [scalerank<=8][zoom=7] {line-width: 0.75; line-color: @rail-color; line-join: round; }
	[scalerank<=9][zoom=8] {line-width: 1; line-color: @rail-color; line-join: round; }
    [zoom>8] { line-width: 1; line-color: @rail-color; line-join: round; }
  }
}

///////////////////////////////////////////////////
// High Roads
///////////////////////////////////////////////////

// TODO: Need turn generated xml layer range manually

.roads {
  [zoom>=10] {
  	line-cap: round;
  	line-join: round;
  	line-clip: false;
    line-width: 0;
    
    [category='highway'][category='major_road'] {
      [zoom=16][is_link=1] { line-smooth: 0.3; }
      [zoom=17] {
        [is_link=1] { line-smooth: 0.5; }
        [is_link=0] { line-smooth: 0.2; }
      }
      [zoom>17] {
        [is_link=1] { line-smooth: 0.8; }
        [is_link=0] { line-smooth: 0.4; }
      }
    }
    [category='highway'][render='casing'] {
      line-color: @highway-casing-color;
    }
    [category='highway'][render='outline'] {
      line-color: @highway-casing-color;
    }
    [category='highway'][render='inline'] {
      line-color: @highway-body-color;
    }
    [category='highway'][render='inline'][is_link=1][zoom>=15] {
      line-color: @highway-link-color;
    }

    [category='major_road'][render='outline'] {
      line-color: @major_road-casing-color;
      [zoom<11] { line-color: @major_road-casing-color-alt; }
    }
    [category='major_road'][render='casing'] {
      line-color: @major_road-casing-color;
    }
    [category='major_road'][render='inline'] {
      line-color: @major_road-body-color;

    }

    [category='minor_road'][render='outline'] {
      line-color: @minor_road-casing-color;
      [zoom<13] { line-color: @major_road-casing-color-alt; }
      [zoom=13] { line-color: @minor_road-casing-color-alt; }
    }
    [category='path'][render='outline'] {
      line-color: @path-casing-color;
      [zoom=14] { line-color: @path-casing-color-alt; }
    }

    [category='minor_road'][render='casing'] {
      line-color: @minor_road-casing-color;
    }
    [category='minor_road'][render='inline'] {
        line-color: @minor_road-body-color;
    }
    [category='path'][render='casing'] {
      line-color: @path-casing-color;
    }
    [category='path'][render='outline'] {
      line-color: @path-casing-color;
    }
    [category='path'][render='inline'] {
      line-color: @path-body-color;
    }
    [category!='rail'][render='casing'] {
      line-cap: butt;
    }
	[category='rail'] {
      line-cap: butt;
    }
    [category='rail'][render='inline'][is_bridge=0] {
      [kind!='rail'] { line-color: darken(@rail-color, 20%); }
      [kind='rail'] { line-color: @rail-color; }
    }
    [category='rail'][render='inline'][is_bridge=1] {
      line-color: darken(@rail-color, 7%);
    }
    [category='rail'][render='casing'][is_bridge=1] {
      line-color: darken(@rail-casing-color, 0%);
    }
    [category='rail'][render='casing'][is_bridge=0] {
      line-color: @rail-casing-color;
    }
    [category='rail'][render='outline'] {
      line-color: @rail-outline-color;
    }
  }
}

///// Ferry
#10m_roads[roadType='Ferry Route'][zoom>4][zoom<10],
#ferry[zoom>=10] {
  line-color: @ferry-color;
  [zoom<=11] { line-width: 0.75; }
  [zoom<15][zoom>11] { line-width: 1; }
  [zoom>=15] { line-width: 1.6; line-smooth: 0.8; }
  line-dasharray: @road-dash;
  line-join: round;
  line-clip: false;
}

#road_z10[zoom=10] {
  [category!='rail'] {
    [render='outline'] {
      [category='highway'] { line-width: 4; }
      [category='major_road'] { line-width: 2; }
    }
    [render='inline'] {
      [category='highway'] { line-width: 2; }
      [category='major_road'] { line-width: 1; }
    }
  }
}

#road_z11[zoom=11] {
  [category!='rail'] {
    [render='outline'] {
      [category='highway'] {line-width: 5; }
      [category='major_road'] {line-width: 2.25; }
      [category='minor_road'] {line-width: 0.2; }
    }
    [render='inline'] {
      [category='highway'] {line-width: 3; }
      [category='major_road'] {line-width: 1.25; }
    }
  }
}

#road_z12[zoom=12] {
  [category!='rail'] {
    [render='outline'] {
      [category='highway'][is_link=0] { line-width: 5; }
      [category='highway'][is_link=1] { line-width: 3; }
      [category='major_road'][is_link=0] {line-width: 2.5; }
      [category='major_road'][is_link=1] {line-width: 1.5; }
      [category='minor_road'] {line-width: 0.5; }
    }
    [render='inline'] {
      [category='highway'][is_link=0] { line-width: 3; }
      [category='highway'][is_link=1] { line-width: 1.5; }
      [category='major_road'][is_link=0] {line-width: 1.5; }
      [category='major_road'][is_link=1] {line-width: 1; }
    }
  }
}

#road_z13[zoom=13] {
  [category!='rail'] {
    [render='outline'] {
      [category='highway'][is_link=0] { line-width: 5; }
      [category='highway'][is_link=1] { line-width: 3; }
      [category='major_road'][is_link=0] {line-width: 3.5; }
      [category='major_road'][is_link=1] {line-width: 2; }
      [category='minor_road'] {line-width: 1; }
      [category='path'] {line-width: 1; }
      [category='rail'] {line-width: 1;}
    }
    [render='inline'] {
      [category='highway'][is_link=0] { line-width: 3; }
      [category='highway'][is_link=1] { line-width: 1.5; }
      [category='major_road'][is_link=0] {line-width: 2; }
      [category='major_road'][is_link=1] {line-width: 1; }
    }
  }
}

#road_z15[zoom>=14] {
  ////////// Highway
  [category='highway'] {
    [zoom=14] {
      [is_link=0] { line-width: 6; }
      [is_link=0][is_bridge=1] { line-width: 7; }
      [is_link=1] { line-width: 4; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 4; }
        [is_link=1] { line-width: 2; }
      }
    }
    [zoom=15] {
      [is_link=0] { line-width: 9; }
      [is_link=0][is_bridge=1] { line-width: 10; }
      [is_link=1] { line-width: 4; }
      [is_link=1][is_bridge=1] { line-width: 5; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 7; }
        [is_link=1] { line-width: 3; }
      }
    }
    [zoom=16] {
      [is_link=0] { line-width: 12; }
      [is_link=0][is_bridge=1] { line-width: 13.5; }
      [is_link=1] { line-width: 6; }
      [is_link=1][is_bridge=1] { line-width: 7; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 9; }
        [is_link=1] { line-width: 4; }
      }
    }
    [zoom=17] {
      [is_link=0] { line-width: 17; }
      [is_link=0][is_bridge=1] { line-width: 19; }
      [is_link=1] { line-width: 9; }
      [is_link=1][is_bridge=1] { line-width: 11; }
      [render='outline'] {
          [is_tunnel=1] { line-opacity:0; }
        }
        [render='casing'] {
          [is_tunnel=1] { line-dasharray: @road-dash; }
        }
        [render='inline'] {
          [is_link=0] { line-width: 13; }
          [is_link=1] { line-width: 7; }
        }
    }
    [zoom>=18] {
      [is_link=0] { line-width: 24; }
      [is_link=0][is_bridge=1] { line-width: 26; }
      [is_link=1] { line-width: 14; }
      [is_link=1][is_bridge=1] { line-width: 16; }
      [render='outline'] {
          [is_tunnel=1] { line-opacity:0; }
        }
        [render='casing'] {
          [is_tunnel=1] { line-dasharray: @road-dash; }
        }
        [render='inline'] {
          [is_link=0] { line-width: 20; }
          [is_link=1] { line-width: 11; }
        }
    }

  }
  ////////// Major Road
  [category='major_road'] {
    [zoom=14] {
      line-width: 4;
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        line-width: 3;
      }
    }
    [zoom=15] {
      [is_link=0] { line-width: 7; }
      [is_link=0][is_bridge=1] { line-width: 8; }
      [is_link=1] { line-width: 3; }
      [is_link=1][is_bridge=1] { line-width: 4; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 5; }
        [is_link=1] { line-width: 2; }
      }
    }
    [zoom=16] {
      [is_link=0] { line-width: 9; }
      [is_link=0][is_bridge=1] { line-width: 11; }
      [is_link=1] { line-width: 4; }
      [is_link=1][is_bridge=1] { line-width: 6; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 7; }
        [is_link=1] { line-width: 3; }
      }
    }
    [zoom=17] {
      [is_link=0] { line-width: 16; }
      [is_link=0][is_bridge=1] { line-width: 18; }
      [is_link=1] { line-width: 8; }
      [is_link=1][is_bridge=1] { line-width: 10; }
      [render='outline'] {
          [is_tunnel=1] { line-opacity:0; }
        }
        [render='casing'] {
          [is_tunnel=1] { line-dasharray: @road-dash; }
        }
        [render='inline'] {
          [is_link=0] { line-width: 12; }
          [is_link=1] { line-width: 6; }
      }
    }
    [zoom>=18] {
      [is_link=0] { line-width: 18; }
      [is_link=0][is_bridge=1] { line-width: 20; }
      [is_link=1] { line-width: 12; }
      [is_link=1][is_bridge=1] { line-width: 14; }
      [render='outline'] {
          [is_tunnel=1] { line-opacity:0; }
        }
        [render='casing'] {
          [is_tunnel=1] { line-dasharray: @road-dash; }
        }
        [render='inline'] {
          [is_link=0] { line-width: 14; }
          [is_link=1] { line-width: 10; }
      }
    }

  }
  ////////// Minor Road
  [category='minor_road'] {
    [zoom=14] {
      line-width: 2;
      [render='casing'] { line-width: 0;}
      [render='inline'] {
        [is_link=0] { line-width: 1.4; }
      }
    }
    [zoom=15] {
      line-width: 4;
      [is_bridge=1] { line-width: 5; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 3; }
      }
    }
    [zoom=16] {
      line-width: 5;
      [is_bridge=1] { line-width: 6.5; }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 4; }
      }
    }
    [zoom=17] {
      line-width: 8;
      [is_bridge=1] { line-width: 10; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 6; }
      }
    }
    [zoom>=18] {
      line-width: 12;
      [is_bridge=1] { line-width: 14; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 9; }
      }
    }
  }
  ////////// Paths
  [category='path'] {
    [zoom=14] {
      line-width: 0;
      [render='outline'] {
        [is_link=0] { line-width: 1; }
      }
    }
    [zoom=15] {
      line-width: 2;
      [is_bridge=1] { line-width: 3; }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 1; }
      }
    }
    [zoom=16] {
      line-width: 3;
      [is_bridge=1] { line-width: 4; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 2; }
      }
    }
    [zoom>=17] {
      line-width: 4;
      [is_bridge=1] { line-width: 5; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 3; }
      }
    }
  }
}

///////////////////////////////////////////////////
// High Rails
///////////////////////////////////////////////////

#road_z12[zoom=12],
#road_z13[zoom=13] {
  [category='rail'][ {
    line-cap:butt;
    [render='casing'] {
      line-width: 1;
    }
    [render='inline'] {
      line-width: 1;
      line-dasharray: 1,2;
    }
  }
}


#road_z15[zoom>=14]
{
  [category='rail'] {
    line-cap:butt;
    [render='inline'][is_tunnel=1] { line-opacity: 0.5;}
    [render='casing'][is_tunnel=1] { line-opacity: 0.5;}

    [zoom=14] {
      [render='casing'] { line-width: 1.5; }
      [render='inline'] {
        line-width: 1;
        line-dasharray: 1,1;
      }
    }
    [zoom=15] {
      [render='outline'][is_bridge=1] { line-width: 5;}
      [render='casing'] { line-width: 3; }
      [render='inline'] {
        line-width: 1.5;
        line-dasharray: 1,1;
      }
    }
    [zoom=16] {
      [render='outline'][is_bridge=1] { line-width: 6;}
      [render='casing'] { line-width: 4; }
      [render='inline'] {
        line-width: 2;
        line-dasharray: 2,1;
      }
    }
    [zoom=17] {
      [render='outline'][is_bridge=1] { line-width: 9;}
      [render='casing'] { line-width: 6; }
      [render='inline'] {
        line-width: 4;
        line-dasharray: 2,1;
      }
    }
    [zoom>=18] {
      [render='outline'][is_bridge=1] { line-width: 11; }
      [render='casing'] { line-width: 7; }
      [render='inline'] {
        line-width: 5;
        line-dasharray: 2,1;
        line-opacity: 0.5;
      }
    }
  }
}

#road_z15[zoom>=15] {
  ::oneway_arrow[category!='rail'][oneway=1][render='casing'] {
    
      [zoom=15][category='major_road'],
      [zoom=16][category!='highway'][category!='path'],
      [zoom=17][category!='highway'],
      [zoom=17][category='highway'][is_link=1],
      [zoom>=18]{
        marker-fill: @highway-casing-color;
        marker-line-width: 0;
        marker-placement: line;
        marker-type: arrow;
        marker-clip: false;
        //marker-allow-overlap: false;
        marker-ignore-placement: true;
        [zoom=15] { marker-height: 4; marker-spacing: 120; }
        [zoom=16] { marker-height: 5; marker-spacing: 120; }
        [zoom=17] { marker-height: 6; marker-spacing: 150; }
        [zoom>=18] { marker-height: 8; marker-spacing: 300; }
	    [category='highway'][category='major_road'] {
          [zoom=17] {
            [is_link=1] { marker-smooth: 0.5; }
            [is_link=0] { marker-smooth: 0.2; }
          }
          [zoom>17] {
            [is_link=1] { marker-smooth: 0.8; }
            [is_link=0] { marker-smooth: 0.4; }
          }
        }
    }
  }
}

#admin1-label[zoom>=3][zoom<=9] {
  [zoom=3] { 
    text-face-name: @label-font-heavy;    
    text-name: "[label_z4]"; 
    text-size: 10;
  	text-transform: uppercase;    
  }
  [zoom=4] { 
    text-name: "[label_z4]"; 
    text-size: 16;
    text-spacing: 1;
  	text-opacity: 0.6;
  	text-transform: uppercase;    
  }
  [zoom=5] { 
    text-name: "[label_z5]"; 
    text-size: 20;
    text-spacing: 2;
  	text-opacity: 0.5;
  	text-transform: uppercase;    
  }
  [zoom=6] { 
    text-name: "[label_z6]"; 
    text-opacity: 0.4;
    text-size: 20;
    text-spacing: 2;
  	text-transform: uppercase;    
	text-wrap-width: 160;         
  }
  [zoom=7] { 
    text-name: "[label_z7]"; 
    text-opacity: 0.3;
    text-size: 32;
    text-spacing: 4;
  	text-transform: uppercase;    
	text-wrap-width: 200;        
  }
  [zoom>=8] { 
    text-name: "[name]"; 
    text-opacity: 0.2;
    text-size: 48;
    text-spacing: 6;
	text-wrap-width: 250;    
  	text-transform: uppercase;    
  }
  text-name: "[name]";
  text-face-name: @label-font-heavy;
  text-allow-overlap: true;
  //text-transform: uppercase;
  text-fill: @boundary-color;
  text-comp-op: multiply;
  text-placement: interior;
}
*/