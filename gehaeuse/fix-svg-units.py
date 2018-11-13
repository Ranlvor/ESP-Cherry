# Convert an .SVG file to have units of mm, irregardless of prior setting

import sys
import xml.etree.ElementTree as ET
import re

units = ["em", "ex","px", "in", "cm", "mm", "pt", "pc"]


if len (sys.argv) > 0:

    # For every file passed to program
    for fileName in sys.argv[1:]:
        print "\nProcessing File: ", fileName

        # Parse as XML tree
        tree = ET.parse (fileName)
        root = tree.getroot()

        if (('width' in root.attrib) and ('height' in root.attrib)):

            # Read the width and height
            width = root.attrib['width']
            height = root.attrib['height']

            print "Old values: width=", width, " height=", height

            #Strip any existing unit, add 'mm'
            noUnits = re.compile('|'.join(map(re.escape, units)))        
            root.attrib['width']  = noUnits.sub("", width) + 'mm'
            root.attrib['height'] = noUnits.sub("", height) + 'mm'

            print "New values: width=", root.attrib['width'],
            print " height=", root.attrib['height']

            #Save the modification
            print "Saving data...",
            tree.write(fileName)
            print "OK\n\n"

# END OF FILE

