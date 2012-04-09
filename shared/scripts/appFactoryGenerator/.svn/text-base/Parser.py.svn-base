import os
import App
import Scanner
import Component

class Parser:

	# syntactically meaningful symbols for our definition file
	# we'll sorta escape these by surrounding them with whitespace to make it easier to parse words
	symbols = [ ":", "~", "/", "!" , "{", "}", "<", ">", "@", "%", "*" ]

	def __init__(self, verbose):
		self.verbose = verbose


	def readDefinitionFromFile(self, fileName):

		self.dirName = os.path.dirname(fileName)
		if not self.dirName:
			self.dirName = "."
		if self.dirName[-1] != "/":
			self.dirName += "/"

		file = open(fileName, "r")
		if self.verbose:
			print "processing", file

		definition = ''

		for line in file:

			# strip comments
			hash = line.find("#")
			if not hash == -1:
				line = line[0:hash]

			# pad symbols to make our parsing easier (symbol tokens we be guaranteed to be separated from word tokens by whitespace)
			for symbol in self.symbols:
				line = line.replace(symbol, " " + symbol + " ")

			line = line.strip()
			if line:
				definition += line + ' '

		file.close()
		return definition


	def parseComponent(self, scanner):
		isAppDelegate = scanner.consumePrefix("!")
		isInstanceFactoryProduct = scanner.consumePrefix("*")

		if isAppDelegate and isInstanceFactoryProduct:
			raise Exception("the app delegate cannot be an instance factory product")

		name = scanner.consumeNextWord()
		capitalizedName = ""
		className = ""
		includePath = ""
		protocolName = ""

		if scanner.consumePrefix(":"):
			capitalizedName = scanner.consumeNextWord()
		if scanner.consumePrefix('~'):
			className = scanner.consumeNextWord()
		if scanner.consumePrefix("@"):
			protocolName = scanner.consumeNextWord()
		if scanner.consumePrefix("/"):
			includePath = scanner.consumeNextWord()
		if not scanner.consumePrefix("{"):
			raise Exception("expected '{' to begin dependency list")

		dependencies = []
		while not scanner.consumePrefix("}"):
			dependency = scanner.consumeUntilAndThrowAway(";")

			# un-pad symbols
			dependency = " " + dependency;
			for symbol in self.symbols:
				dependency = dependency.replace(" " + symbol + " ", symbol)

			dependencies.append(dependency.strip())

		return Component.Component(name, capitalizedName, className, protocolName, includePath, isAppDelegate, isInstanceFactoryProduct, dependencies)


	def parseComponents(self, app, scanner):
		while not scanner.eof():
			if scanner.consumePrefix("<"):
				self.parseIncludedFile(app, scanner.consumeUntilAndThrowAway(">"))
				continue

			component = self.parseComponent(scanner)
			app.components.append(component)


	def parseIncludedFile(self, app, fileName):
		subParser = Parser(self.verbose)
		fileName = fileName.replace(" / ", "/").strip()		# undo what we'd done to make the parsing nicer -- ugh
		subApp = subParser.parse(self.dirName + fileName)
		app.components += subApp.components
		app.externalHeaderFiles += subApp.externalHeaderFiles


	def parseExternalHeaderFiles(self, app, scanner):
		while scanner.consumePrefix("<  < "):
			fileName = scanner.consumeUntilAndThrowAway(" >  > ")
			fileName = fileName.replace(" / ", "/").strip()		# undo what we'd done to make the parsing nicer -- ugh
			app.externalHeaderFiles.append(fileName)

	def parseExternalHeaderFilesForProtocolHeader(self, app, scanner):
		while scanner.consumePrefix("<  <  < "):
			fileName = scanner.consumeUntilAndThrowAway(" >  >  > ")
			fileName = fileName.replace(" / ", "/").strip()		# undo what we'd done to make the parsing nicer -- ugh
			app.externalHeaderFilesForProtocolHeader.append(fileName)

	def parseLibraryHeaderFiles(self, app, scanner):
		while scanner.consumePrefix("%"):
			fileName = scanner.consumeUntilAndThrowAway("%")
			fileName = fileName.replace(" / ", "/").strip()
			app.libraryHeaderFiles.append(fileName)


	def parse(self, fileName):
		scanner = Scanner.Scanner(self.readDefinitionFromFile(fileName))
		app = App.App()
		self.parseExternalHeaderFilesForProtocolHeader(app, scanner)
		self.parseExternalHeaderFiles(app, scanner)
		self.parseLibraryHeaderFiles(app, scanner)
		self.parseComponents(app, scanner)
		return app
