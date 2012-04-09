#!/usr/bin/python -B

import sys
from optparse import OptionParser
import App
import Parser
import ProtocolFileWriter
import HeaderFileWriter
import MethodFileWriter


def main(appFactoryProtocolName, appFactoryClassName, fileName, verbose):

	parser = Parser.Parser(verbose)
	app = parser.parse(fileName)
	app.protocolName = appFactoryProtocolName
	app.className = appFactoryClassName
	app.components.sort()

	if verbose:
		print "app factory protocol name:", app.protocolName
		print "app factory class name:", app.className
		print "external header files:", app.externalHeaderFiles
		i = 0;
		for component in app.components:
			print "component", i, component
			i+=1

	protocolFileWriter = ProtocolFileWriter.ProtocolFileWriter(verbose)
	protocolFileWriter.write(app)

	headerFileWriter = HeaderFileWriter.HeaderFileWriter(verbose)
	headerFileWriter.write(app)

	methodFileWriter = MethodFileWriter.MethodFileWriter(verbose)
	methodFileWriter.write(app)

	return len(app.protocolName) and len(app.className) and  len(app.components)


parser = OptionParser(usage="usage: %prog [options] AppFactory_protocol_name AppFactory_class_name definition_input_filename")
parser.add_option("-v", "--verbose", dest="verbose", action="store_true", default=False, help="print status messages to stdout");
(options, args) = parser.parse_args()
if main(args[0], args[1], args[2], options.verbose):
	exit(0)
exit(-1)
