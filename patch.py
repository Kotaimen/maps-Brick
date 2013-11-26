#!/usr/bin/env python

import xml.etree.cElementTree as ET
import sys
import os, os.path
import subprocess
import json
import re
import argparse

def compile_mml(mml, xml):
    with open(xml, 'wb') as fp:
        subprocess.check_call(['carto', '-n', '-l', mml, ], stdout=fp)

def patch_xml(filename):
    tree = ET.parse(filename)

    # os.path.abspath() doesn't follow symbolic link
    base = os.path.join(os.getenv('PWD'), 'mapnik')

    print 'Patching map attributes.'
    print '  ...set base to:', base
    root = tree.getroot()

    root.attrib['font-directory'] = 'font'
    root.attrib['base'] = base


    print 'Patching map styles.'
    for style in root.findall('Style'):
        n = 0
        for rule in style.findall('Rule'):
            delete = False
            # delete rules with stroke width = 0
            for line in rule.findall('''.//LineSymbolizer[@stroke-width='0']'''):
                delete = True
                break
            # delete rule with empty text/shield name field
            for text in rule.findall('''.//TextSymbolizer'''):
                if text.text == '':
                    delete = True
                    break
            for shield in rule.findall('''.//ShieldSymbolizer'''):
                if shield.text == '':
                    delete = True
                    break
            if delete:
                n += 1
                style.remove(rule)
        if n > 0:
            print '  ...deleted %d useless rules in style "%s"'% (n, style.attrib['name'])

    print 'Patching map layers.'
    for layer in root.findall('Layer'):
        if layer.attrib['name'] == '10m_geographicline':
            print '  ...set clear-label-cache'
            layer.attrib['clear-label-cache'] = 'yes'
        # add "cache-features" option to layer if they contian more than one styles
        style_num = len(layer.findall('StyleName'))
        if style_num > 1:
            print '  ...enable cache-features for layer "%s"' % layer.attrib['name']
            layer.attrib['cache-features'] = 'yes'
        elif style_num == 0:
            print '  ...delete empty layer "%s"' % layer.attrib['name']
            root.remove(layer)


    print 'Overwiting %s' % filename
    tree.write(filename)


def make_theme(theme, smart=False):
    with open('mapnik/project.mml') as fp:
        base_mml = json.load(fp)

    # generate default palette_all.xml
    print '>>>>> Theme "%s"' % theme

    def compile(stylesheets, xml_name):
        base_mml['Stylesheet'] = stylesheets

        mml_filename = 'mapnik/~project.mml'
        xml_filename = 'mapnik/xml/%s_%s.xml' % (theme, xml_name)
        with open(mml_filename, 'w') as fp:
            json.dump(base_mml, fp, indent=2)
        compile_mml(mml_filename, xml_filename)
        patch_xml(xml_filename)

    theme_palette = 'palette.%s.mss' % theme
    with open(os.path.join('mapnik', theme_palette), 'r') as fp:
        mss = fp.read()
        with open('mapnik/~palette.mss', 'w') as wfp:
            wfp.write(re.sub(r'@smart-halo:\s+\d+', '@smart-halo: 0', mss))
        with open('mapnik/~palette_halo.mss', 'w') as wfp:
            wfp.write(re.sub(r'@smart-halo:\s+\d+', '@smart-halo: 1', mss))

    if not smart:
        compile([theme_palette, 'base.mss', 'road.mss', 'boundary.mss', 'label.mss'], 'all')
    else:
#     compile(['~palette.mss', 'base.mss', 'road.mss', 'boundary.mss'], 'base_road')
        compile(['~palette.mss', 'base.mss'], 'base')
        compile(['~palette.mss', 'road.mss', 'boundary.mss'], 'road')
        compile(['~palette.mss', 'label.mss'], 'label')
        compile(['~palette_halo.mss', 'label.mss'], 'label_halo')

def main():
    
    if not os.path.exists('mapnik/xml'):
        os.mkdir('mapnik/xml')
        
    parser = argparse.ArgumentParser()
    
    parser.add_argument('themes',
                        type=str,
                        nargs='+',
                        metavar='themes',                        
                        help='''theme names''',
                       )
    parser.add_argument('--smart',
                        dest='smart',
                        default=False,
                        action='store_true',
                        help='''generate smart halo style'''
                       )                       
    options = parser.parse_args()
    
    for theme in options.themes:
        make_theme(theme, options.smart)


if __name__ == '__main__':
    main()



