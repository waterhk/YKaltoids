class Component:
	
	def __init__(self, name, capitalizedName, className, protocolName, includePath, isAppDelegate, isInstanceFactoryProduct, dependencies):
		self.name = name
		self.capitalizedName = capitalizedName
		self.className = className
		self.protocolName = protocolName
		self.includePath = includePath
		self.isAppDelegate = isAppDelegate
		self.isInstanceFactoryProduct = isInstanceFactoryProduct
		self.dependencies = dependencies
		self.setterName = self.name[0:1].upper() + self.name[1:]

		if not len(self.capitalizedName):
			self.capitalizedName = self.setterName
		if not len(self.className):
			self.className = self.capitalizedName
			if not self.isAppDelegate:
				self.className = "YA" + self.className
		if not len(self.protocolName):
			self.protocolName = self.capitalizedName

	def __str__(self):
		str = "Component "
		if self.isAppDelegate:
			str = "AppDelegate "
		if self.isInstanceFactoryProduct:
			str = "InstanceFactoryProduct "

		str += self.name + " (capitalized: " + self.capitalizedName + "; class: " + self.className + ") depends on: "
		for dependency in self.dependencies:
			str += dependency + " "
		return str

	def __cmp__(self, other):
		result = cmp(self.includePath, other.includePath)
		if result == 0:
			result = cmp(self.name, other.name)
		return result

