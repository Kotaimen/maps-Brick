#!/usr/bin/env python

"""Patch carto compiled mapnik style xml files for better load performance
and for "smart halo" (aka variable depth haloing) rendering.

This is ugly since its not likly portable between mapnik versions.

Current targeting the still unreleased 2.3.x.
"""

import xml.etree.cElementTree as ET
import sys
import os, os.path
import subprocess
import json
import re
import argparse
import time


def compile_mml(mml, xml):
    """compile to mapnik xml using carto"""
    print 'Compiling "%s" to "%s"...' % (mml, xml)
    with open(xml, 'wb') as fp:
        subprocess.check_call(['carto', '-n', '-l', mml, ], stdout=fp)
    print '  ...done'


def patch_xml(filename):
    """patch a carto compiled mapnik xml file"""
    tree = ET.parse(filename)

    # os.path.abspath() doesn't follow symbolic link
    base = os.path.join(os.environ['PWD'], 'mapnik')

    print 'Patching map attributes.'
    print '  ...set base to:', base
    root = tree.getroot()
    root.attrib['font-directory'] = 'font'
    root.attrib['base'] = base
    
    # return tree

    styles = {}

    for style in root.findall('Style'):
        print 'Patching style "%s"...' % style.attrib['name']

        useless_rules = 0
        num_of_rules = 0

        style_max_scales = []
        style_min_scales = []

        for rule in style.findall('Rule'):
            num_of_rules += 1
            delete = False
            # delete rules with stroke width = 0
            for line in rule.findall(
                    '''.//LineSymbolizer[@stroke-width='0']'''):
                delete = True
                break
            # delete rule with empty text/shield name field
            for text in rule.findall('''.//TextSymbolizer'''):
                try:
                    if text.attrib['placement-type'] == 'dummy':
                        # delete dummy placements to disable mapnik load warning
                        del text.attrib['placements']
                except KeyError:
                    pass
                if text.text == '':
                    delete = True
                    break
            for shield in rule.findall('''.//ShieldSymbolizer'''):
                if shield.text == '':
                    delete = True
                    break
            for max_scale in rule.findall('MaxScaleDenominator'):
                style_max_scales.append(int(max_scale.text))
                break
            for min_scale in rule.findall('MinScaleDenominator'):
                style_min_scales.append(int(min_scale.text))
                break

            if delete:
                useless_rules += 1
                style.remove(rule)
        else:
            if num_of_rules == 0:
                print '  ...deleted empty style'
                root.remove(style)
        if useless_rules > 0:
            print '  ...deleted %d useless rules' % useless_rules

        styles[style.attrib[
            'name']] = style_max_scales, style_min_scales, num_of_rules

    for layer in root.findall('Layer'):
        print 'Patching layer "%s"...' % layer.attrib['name']
        # counting styles&rules in a layer
        rule_num = 0
        style_num = 0
        max_scale = 0
        min_scale = 2 ** 32 - 1

        for style_name in layer.findall('StyleName'):
            style_max_scales, style_min_scales, num_of_rules = styles[
                style_name.text]
            rule_num += num_of_rules
            style_num += 1
            if style_max_scales:
                max_scale = max(max_scale, max(style_max_scales))
            if style_min_scales:
                min_scale = min(min_scale, min(style_min_scales))
        # limit layer scale range
        if max_scale > 0:
            print  '  ...limit max scale to', max_scale
            layer.attrib['maxzoom'] = str(max_scale)
        if min_scale < 2 * 32 - 1:
            print  '  ...limit min scale to', min_scale

            layer.attrib['minzoom'] = str(min_scale)


        # enable async postgis render
        datasource = layer.find('Datasource')

        # apply async postgis read for speed
        for parameter in datasource.findall('Parameter'):
            if parameter.attrib['name'] == 'type' and \
               parameter.text == 'postgis' and \
               '_gen' not in layer.attrib['name']:
                new_params = {
                    'max_size': '10',
                    'asynchronous_request': 'true',
                    'max_async_connection': '5', }
                print '  ...applying async postgis options'
                for k, v in new_params.iteritems():
                    p = ET.Element('Parameter')
                    p.attrib['name'] = k
                    p.text = v
                    datasource.append(p)
                break

        # add "cache-features" to layer if they contain more than one styles
        if style_num > 1 and '_gen' not in layer.attrib['name']:
            print '  ...enable cache-features'
            layer.attrib['cache-features'] = 'yes'

        # and delete any layers without any rules
        if rule_num == 0:
            print '  ...delete useless layer'
            root.remove(layer)
            
    return tree


def make_theme(theme, smart=False):
    with open('mapnik/project.mml') as fp:
        base_mml = json.load(fp)

    print '>>>>> Patching theme "%s" <<<<<' % theme

    def compile(stylesheets, xml_name):
        base_mml['Stylesheet'] = stylesheets

        mml_filename = 'mapnik/~project.mml'
        xml_filename = 'mapnik/xml/%s%s.xml' % (theme, xml_name)
        with open(mml_filename, 'w') as fp:
            json.dump(base_mml, fp, indent=2)
        compile_mml(mml_filename, xml_filename)
        tree = patch_xml(xml_filename)
        print 'Overwiting %s' % xml_filename
        tree.write(xml_filename)


    theme_palette = 'palette.%s.mss' % theme
    with open(os.path.join('mapnik', theme_palette), 'r') as fp:
        mss = fp.read()
        with open('mapnik/~palette.mss', 'w') as wfp:
            out = re.sub(r'@scale-factor:\s+\d+', '@scale-factor: 1', mss)
            out = re.sub(r'@smart-halo:\s+\d+', '@smart-halo: 0', out)
            out = re.sub(r'@default-halo:\s+\d+', '@default-halo: 0', out)
            wfp.write(out)
        with open('mapnik/~palette_halo.mss', 'w') as wfp:
            out = re.sub(r'@scale-factor:\s+\d+', '@scale-factor: 1', mss)
            # out = re.sub(r'@smart-halo:\s+\d+', '@smart-halo: 1', mss)
            # out = re.sub(r'@default-halo:\s+\d+', '@default-halo: 1', out)
            wfp.write(out)
        with open('mapnik/~palette@2x.mss', 'w') as wfp:
            out = re.sub(r'@scale-factor:\s+\d+', '@scale-factor: 2', mss)
            out = re.sub(r'@smart-halo:\s+\d+', '@smart-halo: 0', out)
            out = re.sub(r'@default-halo:\s+\d+', '@default-halo: 0', out)
            wfp.write(out)
        with open('mapnik/~palette@2x_halo.mss', 'w') as wfp:
            out = re.sub(r'@scale-factor:\s+\d+', '@scale-factor: 2', mss)
            # out = re.sub(r'@smart-halo:\s+\d+', '@smart-halo: 1', mss)
            # out = re.sub(r'@default-halo:\s+\d+', '@default-halo: 1', out)
            wfp.write(out)

    if not smart:
        compile(
            ['~palette_halo.mss', 'base.mss', 'road.mss', 'bound.mss',
             'label.mss'],
            '_all')
        compile(
            ['~palette@2x_halo.mss', 'base.mss', 'road.mss', 'bound.mss',
             'label.mss'],
            '@2x_all')
    else:
        compile(['~palette.mss', 'base.mss'], '_base')
        compile(['~palette.mss', 'road.mss', 'bound.mss'], '_road')
        compile(['~palette.mss', 'label.mss'], '_label')
        compile(['~palette_halo.mss', 'label.mss'], '_label_halo')
        compile(['~palette@2x.mss', 'base.mss'], '@2x_base')
        compile(['~palette@2x.mss', 'road.mss', 'bound.mss'], '@2x_road')
        compile(['~palette@2x.mss', 'label.mss'], '@2x_label')
        compile(['~palette@2x_halo.mss', 'label.mss'], '@2x_label_halo')

    print '>>>>> Theme "%s" patched' % theme


def main():
    # Arg paring

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

    parser.add_argument('-w', '--watch',
                        dest='watch',
                        default=False,
                        action='store_true'
    )

    options = parser.parse_args()

    # Startup
    if not os.path.exists('mapnik/xml'):
        os.mkdir('mapnik/xml')

    # Compile
    for theme in options.themes:
        make_theme(theme, options.smart)
    if not options.watch:
        return

    # Watching file change
    watched_files = ['mapnik/base.mss', 'mapnik/road.mss', 'mapnik/label.mss',
                     'mapnik/bound.mss', 'mapnik/project.mml']
    for theme in options.themes:
        watched_files.append('mapnik/palette.%s.mss' % theme)
    print 'Watching: %s' % watched_files
    time_stamps = dict(zip(watched_files,
                           (os.stat(file).st_mtime for file in watched_files)))
    changed = False
    while True:
        if changed:
            for theme in options.themes:
                make_theme(theme, options.smart)
            changed = False

        time.sleep(2)
        for watched_file, mtime in time_stamps.iteritems():
            if os.stat(watched_file).st_mtime != mtime:
                print '"%s" changed, repatching' % watched_file
                time_stamps[watched_file] = os.stat(watched_file).st_mtime
                changed = True
                break


if __name__ == '__main__':
    main()



