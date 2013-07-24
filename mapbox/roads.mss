
///////////////////////////////////////////////////
// Political boundary
///////////////////////////////////////////////////

.boundary {
  ::casing {
    line-width: 0;
  	line-color: @boundary-outline-color;
    line-opacity: 0.5;
  	line-join: round;
    line-cap: round;
  }
  ::body {
    line-width: 0;
  	line-color: @boundary-color;
  	line-join: round;
  }
}

#boundary_admin0,
#boundary_disupted  {
  ::casing {
  	[zoom=3] { line-width: 1; }
  	[zoom=4] { line-width: 2; }
  	[zoom=5] { line-width: 3; }
  	[zoom=6] { line-width: 4; }
  	[zoom>6] { line-width: 5; }
  }
  ::body {
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

#boundary_admin1 {
  [zoom=3][scalerank<=2],
  [zoom=4][scalerank<=3],
  [zoom=5][scalerank<=4],
  [zoom=6][scalerank<=5],
  [zoom>6],
  {
    ::casing {
      [zoom=4] { line-width: 1; }
      [zoom=5] { line-width: 1; }
      [zoom>=6] { line-width: 2; }
    }
    ::body {
      line-dasharray: 1,1;
      [zoom=3] { line-width: 0.25; }
      [zoom=4] { line-width: 0.5; }
      [zoom=5] { line-width: 0.75; }
      [zoom=6] { line-width: 1; }
      [zoom>6] { line-width: 1.5; }
    }
  }
}

#geographic_lines[zoom<7] {
  ::text
    [name='Equator'],
    [name='International Date Line'],
    [name='Arctic Circle'],
    [name='Antarctic Circle'],
    {
  line-width:1;
  line-color:@highway-casing-color;
  line-dasharray: 4,2;
  }
}



///////////////////////////////////////////////////
// Road skeleton
///////////////////////////////////////////////////
#roads_overview[zoom>=4][zoom<=8] {
  line-join: round;
  line-cap: round;
  line-width: 0;
//  line-comp-op: darken;
  [highway='motorway'],[highway='trunk'] {
    line-color: @highway-body-color;
    [zoom=4] { line-width: 0.2; line-opacity: 0.4;}
    [zoom=5] { line-width: 0.3; line-opacity: 0.4;}
    [zoom=6] { line-width: 0.6; line-opacity: 0.6;}
    [zoom=7] { line-width: 0.75; line-opacity: 0.8;}
    [zoom=8] { line-width: 1; line-opacity: 1;}
  }
  [highway='primary'],[highway='secondary'] {
    line-color: @major_road-body-color;
    [zoom=4] { line-width: 0.1; line-opacity: 0.2;}
    [zoom=5] { line-width: 0.2; line-opacity: 0.4;}
    [zoom=6] { line-width: 0.3; line-opacity: 0.6;}
    [zoom=7] { line-width: 0.4; line-opacity: 0.8;}
    [zoom=8] { line-width: 0.5; line-opacity: 1;}
  }

}

///////////////////////////////////////////////////
// High Roads
///////////////////////////////////////////////////

// TODO: Need turn generated xml layer range manually

.roads {
  [zoom>=9] {
  	line-cap: round;
  	line-join: round;
  	line-clip: false;
    line-width: 0;

    [render='casing'] { line-gamma: 1.5; }
    [render='outline'] { line-gamma: 1; }
    [render='inline'] { line-gamma: 1.2; }

    [zoom=17][is_link=1]{ line-smooth: 0.3; }
    [zoom>17][is_link=1]{ line-smooth: 0.5; }

    [road_class='highway'][render='casing'] {
      line-color: @highway-casing-color;
    }
    [road_class='highway'][render='outline'] {
      line-color: @highway-casing-color;
    }
    [road_class='highway'][render='inline'] {
      line-color: @highway-body-color;
    }
    [road_class='highway'][render='inline'][is_tunnel=1][zoom>=15] {
      line-color: lighten(@highway-body-color, 12%);
    }
    [road_class='highway'][render='inline'][is_link=1][zoom>=15] {
      line-color: @highway-link-color;
    }
    [road_class='trunk'][render='casing'] {
      line-color: @highway-casing-color;
    }
    [road_class='trunk'][render='outline'] {
      line-color: @highway-casing-color;
    }
    [road_class='trunk'][render='inline'] {
      line-color: @highway-body-color;
    }
    [road_class='trunk'][render='inline'][is_tunnel=1][zoom>=14] {
      line-color: lighten(@highway-body-color, 12%);
    }
    [road_class='trunk'][render='inline'][is_link=1][zoom>=14] {
      line-color: @highway-link-color;
    }
    [road_class='major_road'][render='outline'] {
      line-color: @major_road-casing-color;
      [zoom<11] { line-color: @major_road-casing-color-alt; }
    }
    [road_class='major_road'][render='casing'] {
      line-color: @major_road-casing-color;
    }
    [road_class='major_road'][render='inline'] {
      line-color: @major_road-body-color;
    }

    [road_class='minor_road'][render='outline'] {
      line-color: @minor_road-casing-color;
      [zoom<13] { line-color: @major_road-casing-color-alt; }
      [zoom=13] { line-color: @minor_road-casing-color-alt; }
    }
    [road_class='path'][render='outline'] {
      line-color: @path-casing-color;
      [zoom=14] { line-color: @path-casing-color-alt; }
    }

    [road_class='minor_road'][render='casing'] {
      line-color: @minor_road-casing-color;
    }
    [road_class='minor_road'][render='inline'] {
        line-color: @minor_road-body-color;
    }
    [road_class='path'][render='casing'] {
      line-color: @path-casing-color;
    }
    [road_class='path'][render='outline'] {
      line-color: @path-casing-color;
    }
    [road_class='path'][render='inline'] {
      line-color: @path-body-color;
    }
    [road_class!='rail'][render='casing'] {
      line-cap: butt;
    }
	[road_class='rail'] {
      line-cap: butt;
    }
  }
}

///// Ferry
#ferry[zoom>6] {
  line-color: @ferry-color;
  [zoom<10] { line-width: 0.5; }
  [zoom<=12] { line-width: 0.5; }
  [zoom<15][zoom>12] { line-width: 0.75; }
  [zoom>=15] { line-width: 1; line-smooth: 0.8; }
  line-dasharray: @road-dash;
  line-join: round;
  line-clip: false;
}

#road_z10[zoom=9] {
  [road_class!='rail'] {
    [render='outline'] {
      [road_class='highway'], [road_class='trunk'], { line-width: 2; }
      [road_class='major_road'] { line-width: 1; }
    }
    [render='inline'] {
      [road_class='highway'], [road_class='trunk'] { line-width: 1; }
      [road_class='major_road'] { line-width: 0.6; }
    }
  }
}

#road_z10[zoom=10] {
  [road_class!='rail'] {
    [render='outline'] {
      [road_class='highway'], [road_class='trunk'], { line-width: 3; }
      [road_class='major_road'] { line-width: 1.6; }
      [road_class='minor_road'] { line-width: 0.2; }
    }
    [render='inline'] {
      [road_class='highway'], [road_class='trunk'] { line-width: 2; }
      [road_class='major_road'] { line-width: 1; }
    }
  }
}

#road_z10[zoom=11] {
  [road_class!='rail'] {
    [render='outline'] {
      [road_class='highway'], [road_class='trunk'] {line-width: 3; }
      [road_class='major_road'] {line-width: 2; }
      [road_class='minor_road'] {line-width: 1; }
    }
    [render='inline'] {
      [road_class='highway'], [road_class='trunk'] {line-width: 2; }
      [road_class='major_road'] {line-width: 1; }
    }
  }
}

#road_z13[zoom=12] {
  [road_class!='rail'] {
    [render='outline'] {
      [road_class='highway'][is_link=0] { line-width: 5; }
      [road_class='highway'][is_link=1] { line-width: 3; }
      [road_class='trunk'][is_link=0] { line-width: 5; }
      [road_class='trunk'][is_link=1] { line-width: 3; }
      [road_class='major_road'][is_link=0] {line-width: 2.5; }
      [road_class='major_road'][is_link=1] {line-width: 1.5; }
      [road_class='minor_road'] {line-width: 0.5; }
    }
    [render='inline'] {
      [road_class='highway'][is_link=0] { line-width: 3; }
      [road_class='highway'][is_link=1] { line-width: 1.5; }
      [road_class='trunk'][is_link=0] { line-width: 3; }
      [road_class='trunk'][is_link=1] { line-width: 1.5; }
      [road_class='major_road'][is_link=0] {line-width: 1.5; }
      [road_class='major_road'][is_link=1] {line-width: 1; }
    }
  }
}

#road_z13[zoom=13] {
  [road_class!='rail'] {
    [render='outline'] {
      [road_class='highway'][is_link=0] { line-width: 5; }
      [road_class='highway'][is_link=1] { line-width: 3; }
      [road_class='trunk'][is_link=0] { line-width: 5; }
      [road_class='trunk'][is_link=1] { line-width: 3; }
      [road_class='major_road'][is_link=0] {line-width: 3.5; }
      [road_class='major_road'][is_link=1] {line-width: 2; }
      [road_class='minor_road'] {line-width: 1; }
      [road_class='path'] {line-width: 1; }
      [road_class='rail'] {line-width: 1;}
    }
    [render='inline'] {
      [road_class='highway'][is_link=0] { line-width: 3; }
      [road_class='highway'][is_link=1] { line-width: 1.5; }
      [road_class='trunk'][is_link=0] { line-width: 3; }
      [road_class='trunk'][is_link=1] { line-width: 1.5; }
      [road_class='major_road'][is_link=0] {line-width: 2; }
      [road_class='major_road'][is_link=1] {line-width: 1; }
    }
  }
}

#road_z15[zoom>=14][render!='marker'] {
  ////////// Highway
  [road_class='highway'], [road_class='trunk'] {

    [zoom=14] {
      [is_link=0] { line-width: 6.5; }
      [is_link=0][is_bridge=1] { line-width: 7.5; }
      [is_link=1] { line-width: 4.5; }
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
      [is_link=0] { line-width: 10; }
      [is_link=0][is_bridge=1] { line-width: 11; }
      [is_link=1] { line-width: 5; }
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
  [road_class='major_road'] {
    [zoom=14] {
      line-width: 4;
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        line-width: 2.5;
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
  [road_class='minor_road'] {
    [zoom=14] {
      line-width: 3;
      [render='casing'][is_tunnel=1] { line-width: 3;}
      [render='inline'] {
        line-width: 1.5;
      }
    }
    [zoom=15] {
      line-width: 5;
      [is_bridge=1] { line-width: 6; }
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
      line-width: 6;
      [is_bridge=1] { line-width: 7; }
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
      line-width: 16;
      [is_bridge=1] { line-width: 18; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 13; }
      }
    }
  }
  ////////// Paths
  [road_class='path'] {
    [zoom=14] {
      line-width: 0;
      [render='casing'] {
        [is_link=0] { line-width: 1; }
      }
    }
    [zoom=15] {
      line-width: 2.5;
      [is_bridge=1] { line-width: 4; }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 1.5; }
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
        [is_link=0] { line-width: 1.5; }
      }
    }
    [zoom=17] {
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
    [zoom>=18] {
      line-width: 6;
      [is_bridge=1] { line-width: 7; }
      [render='outline'] {
        [is_tunnel=1] { line-opacity:0; }
      }
      [render='casing'] {
        [is_tunnel=1] { line-dasharray: @road-dash; }
      }
      [render='inline'] {
        [is_link=0] { line-width: 5; }
      }
    }
  }
}

///////////////////////////////////////////////////
// High Rails
///////////////////////////////////////////////////
#road_z10[zoom>9][zoom<=10],
#road_z10[zoom=11]
{
   [road_class='rail'] {
    [render='inline'] {
      line-color: @rail-color;
      line-width: 0.25;
      dash/line-dasharray: 1, 5;
      dash/line-color: @rail-color;
      dash/line-width: 0.75;
    }
  }
}

#road_z13[zoom=12],
#road_z13[zoom=13] {
  [road_class='rail'][ {
    [render='inline'] {
      line-color: @rail-color;
      line-width: 0.6;
      dash/line-dasharray: 4, 4;
      dash/line-color: @rail-casing-color;
      dash/line-width: 0.4;
    }
  }
}

#road_z15[zoom>=14] {
  [road_class='rail'] {
    [render='casing'] {
      [is_tunnel=1] {
        line-opacity: 0.5;
        fill/line-opacity: 0.5;
      }
    }
    [render='inline'] {
      [is_tunnel=1] {
        line-opacity: 0.5;
        dash/line-opacity: 0.5;
      }
    }
    [zoom<=15] {
      [render='casing'][is_bridge=1] {
        line-color: @rail-color;
        line-width: 5;
        fill/line-color: @land-color;
        fill/line-width: 4;
      }
      [render='casing'][is_bridge=0] {
        fill/line-color: @land-color;
        fill/line-width: 4;
      }
      [render='inline'] {
        [road_type='monorail'], [road_type='tram'], [road_type='narrow_gauage'],
        [road_type='miniature'],
        {
          line-color: @rail-color;
          line-width: 0.75;
          dash/line-color: @rail-color;
          dash/line-width: 2;
          dash/line-dasharray: 1, 5;
        }
        [road_type='subway'], [road_type='lightrail'] {
          line-color: @rail-casing-color;
          line-width: 2.5;
          dash/line-color: @rail-color;
          dash/line-width: 1.5;
          dash/line-dasharray: 1.5, 1;
        }
        [road_type!='monorail'][road_type!='tram'][road_type!='narrow_gauge'][road_type!='miniature'],
        [road_type!='subway'][road_type!='lightrail'] {
          line-color: @rail-color;
          line-width: 2.5;
          dash/line-color: @rail-casing-color;
          dash/line-width: 1.5;
          dash/line-dasharray: 6, 6;
        }
      }
    }
    [zoom=16] {
      [render='casing'][is_bridge=1] {
        line-color: @rail-color;
        line-width: 7;
        fill/line-color: @land-color;
        fill/line-width: 5;
      }
      [render='casing'][is_bridge=0] {
        fill/line-color: @land-color;
        fill/line-width: 5;
      }
      [render='inline'] {
        [road_type='monorail'], [road_type='tram'], [road_type='narrow_gauage'] {
          line-color: @rail-color;
          line-width: 1;
          dash/line-color: @rail-color;
          dash/line-width: 3;
          dash/line-dasharray: 1, 7;
        }
        [road_type='subway'], [road_type='lightrail'] {
          line-color: @rail-casing-color;
          line-width: 3;
          dash/line-color: @rail-color;
          dash/line-width: 2;
          dash/line-dasharray: 1.5, 1;
        }
        [road_type!='monorail'][road_type!='tram'][road_type!='narrow_gauge']
        [road_type!='subway'][road_type!='lightrail'] {
          line-color: @rail-color;
          line-width: 3;
          dash/line-color: @rail-casing-color;
          dash/line-width: 2;
          dash/line-dasharray: 8, 8;
        }
      }
    }
    [zoom>=17] {
      [render='casing'][is_bridge=1] {
        line-color: @rail-color;
        line-width: 10;
        fill/line-color: @land-color;
        fill/line-width: 7;
      }
      [render='casing'][is_bridge=0] {
        fill/line-color: @land-color;
        fill/line-width: 7;
      }
      [render='inline'] {
        [road_type='monorail'], [road_type='tram'], [road_type='narrow_gauage'] {
          line-color: @rail-color;
          line-width: 1.2;
          dash/line-color: @rail-color;
          dash/line-width: 4;
          dash/line-dasharray: 1, 9;
        }
        [road_type='subway'], [road_type='lightrail'] {
          line-color: @rail-casing-color;
          line-width: 5;
          dash/line-color: @rail-color;
          dash/line-width: 4;
          dash/line-dasharray: 2, 1;
        }
        [road_type!='monorail'][road_type!='tram'][road_type!='narrow_gauge']
        [road_type!='subway'][road_type!='lightrail'] {
          line-color: @rail-color;
          line-width: 5;
          dash/line-color: @minor_road-body-color;
          dash/line-width: 3;
          dash/line-dasharray: 10, 10;
        }
      }
    }
  }
}

#road_z15[zoom>=15][road_class!='rail'][is_oneway=1][render='marker'] {
  [zoom=15][road_class='major_road'],
  [zoom=16][road_class!='highway'][road_class!='path'],
  [zoom=17][road_class!='highway'],
  [zoom=17][road_class='highway'][is_link=1],
  [zoom>=18]
  {
    [road_class='major_road'] {  marker-fill: @major_road-casing-color; }
    [road_class='minor_road'] {  marker-fill: @minor_road-casing-color; }
    marker-fill: @highway-casing-color;
    marker-line-width: 0;
    marker-placement: line;
    marker-type: arrow;
    marker-clip: false;
    marker-height: 6;
    marker-spacing: 200;
    marker-ignore-placement: true;
  }
}
