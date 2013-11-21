#!/usr/bin/env python

import xml.etree.cElementTree as ET
import sys
import os, os.path
import subprocess 
import json

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

    root.attrib['font-directory'] = 'fonts'
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
        # add "cache-features" option to layer if they contian more than one styles
        if len(layer.findall('StyleName')) > 1:
            print '  ...enable cache-features for layer "%s"' % layer.attrib['name']
            layer.attrib['cache-features'] = 'yes'

    print 'Overwiting %s' % filename
    tree.write(filename)


def make_theme(theme):
    with open('mapnik/project.mml') as fp:
        base_mml = json.load(fp)
    theme_palette = 'palette.%s.mss' % theme

    base_mml['Stylesheet'] = [
        theme_palette, 
        'base.mss',
        'road.mss',
        'boundary.mss',
        'label.mss'
      ]
    
    mml_all = 'mapnik/~all.mml'
    xml_all = 'mapnik/xml/%s_all.xml' % theme
    print 'Generate %s:all' % theme
    with open(mml_all, 'w') as fp:
        json.dump(base_mml, fp, indent=2)
    compile_mml(mml_all, xml_all)
    patch_xml(xml_all)

def main():
    if not os.path.exists('mapnik/xml'):
        os.mkdir('mapnik/xml')
    make_theme('brick')
    make_theme('saga')    
    make_theme('moonlight')


if __name__ == '__main__':
    main()



