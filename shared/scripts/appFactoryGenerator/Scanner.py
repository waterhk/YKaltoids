class Scanner:

	def __init__(self, source):
		self.source = source.expandtabs(1)

	def consumeNextWord(self):
		self.lstrip()
		partition = self.source.partition(' ')
		if not partition[1]:
			raise Exception("expected to find whitespace")

		if not partition[0]:
			raise Exception("expected to find a word")

		if not partition[0][0:1].isalpha():
			raise Exception("expected first character of component name to be alphabetic: " + partition[0])

		self.source = partition[2]
		return partition[0]

	def consumeUntilAndThrowAway(self, stopCharacter):
		partition = self.source.partition(stopCharacter)
		if not partition[1]:
			raise Exception("expected to find " + stopCharacter)
		self.source = partition[2]
		return partition[0]

	def consumePrefix(self, prefix):
		self.lstrip()
		if self.source.startswith(prefix):
			self.source = self.source[len(prefix):]
			return True
		return False

	def lstrip(self):
		self.source = self.source.lstrip()

	def eof(self):
		self.lstrip()
		return not self.source
