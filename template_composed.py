# -*- encoding: utf-8 -*-

metadata = dict(
    title=title,
    version='3.0.0',
    abstract=abstract,
    attribution='Map Design: K&R, Data: Natural Earth, Open Street Map',
    origin=(-122, 37),
    origin_zoom=4,
)

pyramid = dict(
    stride=1,
    geogcs='WGS84',
    projcs="+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0.0 +k=1.0 +units=m +nadgrids=@null +wktext +no_defs +over",
    levels=range(2, 20),
)

maptype = 'image'

tileformat = dict(format=imageformat)

THEME = dict(
    name=name,
    metadata=metadata,
    pyramid=pyramid,
    maptype=maptype,
    tileformat=tileformat,
    schemas=[]
)

for scale in [1, 2]:
    tag = '' if (scale == 1) else ('@%dx' % scale)

    schema = dict(
        tag='%s%s' % (tag, extension),
        pyramid=pyramid,
        maptype=maptype,
        tileformat=tileformat,
        # storage={
        # 'prototype': 'disk',
        #     'stride': 8,
        #     'root': '{{ theme_root }}/cache/%s' % name,
        # },
        renderer={
            'prototype': 'image',
            'layers': {
                'root': {
                    'prototype': 'mapnik.composer',
                    'style_sheets': [
                        "{{ theme_root }}/mapnik/xml/%s%s_road.xml" % (name, tag),
                        "{{ theme_root }}/mapnik/xml/%s%s_label_halo.xml" % (name, tag),
                        "{{ theme_root }}/mapnik/xml/%s%s_base.xml" % (name, tag),
                        "{{ theme_root }}/mapnik/xml/%s%s_label.xml" % (name, tag),

                    ],
                    'commands': [
                        ('src_atop', 0.5),
                        ('dst_over', 1),
                        ('src_over', 1),
                    ],
                    'base_path': '{{ theme_root }}/mapnik',
                    'default_scale': scale,
                    'buffer_size': 256 * scale
                }
            }
        }
    )

    THEME['schemas'].append(schema)