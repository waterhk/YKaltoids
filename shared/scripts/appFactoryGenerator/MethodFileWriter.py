import datetime
import InstanceFactoryLib


class MethodFileWriter:

	def __init__(self, verbose):
		self.verbose = verbose

	def constructDependencyAccessor(self, componentMap, dependency, isInstanceFactory):
		if isInstanceFactory:
			return "self"

		instanceFactoryProduct = False
		if componentMap.has_key(dependency):
			component = componentMap[dependency]
			if component.isInstanceFactoryProduct:
				instanceFactoryProduct = True

		accessor = "[self "

		if not instanceFactoryProduct:
			accessor += dependency
		else:
			accessor += "create"
			accessor += component.capitalizedName

		accessor += "]"
		return accessor


	def writeDesignatedInitializer(self, file, componentMap, component, name):
		initializer = name

		designatedInitializerParameters = []
		for dependency in component.dependencies:
			if dependency[0] == ":":
				designatedInitializerParameters.append(dependency[1:])

		firstDesignatedInitializerParameter = True
		if designatedInitializerParameters:
			initializer += "With"
			for dependency in designatedInitializerParameters:
				isInstanceFactory = False
				if dependency.endswith("InstanceFactory"):
					isInstanceFactory = True
					dependency = dependency[0:len(dependency) - len("InstanceFactory")]

				if not componentMap.has_key(dependency):
				 	initializer += dependency
				else:
					dependencyComponent = componentMap[dependency]
					if(firstDesignatedInitializerParameter):
						initializer += dependencyComponent.capitalizedName
					else:
					 	initializer += dependencyComponent.name
					initializer += ":"
					initializer += self.constructDependencyAccessor(componentMap, dependency, isInstanceFactory)

				initializer += " "
				firstDesignatedInitializerParameter = False

			initializer = initializer.strip()

		file.write(initializer)


	def writeDependencySetterInjections(self, file, componentMap, component, componentVariableName, indentLevel):
		for dependency in component.dependencies:
			if dependency[0] == ":":
				continue

			file.write("\t" * indentLevel)

			file.write("[")
			file.write(componentVariableName);
			file.write(" set");

			isInstanceFactory = False
			if dependency.endswith("InstanceFactory"):
				isInstanceFactory = True
				dependency = dependency[0:len(dependency) - len("InstanceFactory")]

			if componentMap.has_key(dependency):
				dependencyComponent = componentMap[dependency]
				file.write(dependencyComponent.setterName)
				if isInstanceFactory:
					file.write("InstanceFactory")
				file.write(":")
				file.write(self.constructDependencyAccessor(componentMap, dependency, isInstanceFactory))
			else:
				file.write(dependency)
			file.write("];\n")


	def writeInstanceFactoryMethods(self, file, app, componentMap):
		for component in app.components:
			if not component.isInstanceFactoryProduct:
				continue

			file.write(InstanceFactoryLib.factoryMethodSignature(app, component))
			file.write("\n{\n")

			file.write("\t" + component.className + "* impl = [[" + component.className + " alloc] init")

			initDependencies = []
			for dependency in component.dependencies:
				if dependency[0] == ":":
					initDependencies.append(dependency[1:])

			init = ""

			if initDependencies:
				init = "With"
				firstDesignatedInitializerParameter = True
				for dependency in initDependencies:
					isInstanceFactory = False
					if dependency.endswith("InstanceFactory"):
						isInstanceFactory = True
						dependency = dependency[0:len(dependency) - len("InstanceFactory")]

					if not componentMap.has_key(dependency):
						if dependency[0] == "*":
							tokens = dependency[1:].split(":")
							name = tokens[0].strip()
							name = name[0].lower() + name[1:]
							if firstDesignatedInitializerParameter:
								init += name[0].upper() + name[1:]
							else:
								init += name
							init += ":"
							init += "op_" + name
						else:
							init += dependency
					else:
						dependencyComponent = componentMap[dependency]
						if(firstDesignatedInitializerParameter):
							init += dependencyComponent.capitalizedName
						else:
							init += dependencyComponent.name
						init += ":"
						init += self.constructDependencyAccessor(componentMap, dependency, isInstanceFactory)

					init += " "
					firstDesignatedInitializerParameter = False

			init = init.strip()
			file.write(init)

			file.write("];\n")

			self.writeDependencySetterInjections(file, componentMap, component, "impl", 1)

			file.write("\treturn impl;\n}\n")


	def write(self, app):

		now = datetime.datetime.now()

		# map component names to component objects
		componentMap = dict()
		appDelegate = None
		for component in app.components:
			if component.isAppDelegate:
				appDelegate = component

			componentMap[component.name] = component


		with open(app.className + ".m", "w") as file:

			# header
			file.write("//\n// " + app.className + ".h\n//\n")
			file.write("// DO NOT EDIT!\n")
			file.write("// THIS FILE WAS GENERATED BY appFactoryFactory AT " + str(now) + "\n")
			file.write("//\n\n")
			file.write("#import \"" + app.className + ".h\"\n\n")


			# import component header files
			for component in app.components:
				file.write("#import \"")
				if component.includePath:
					file.write(component.includePath)
					file.write("/")
				file.write(component.className)
				file.write(".h\"\n")
			file.write("\n")


			# import library header files
			for libraryHeaderFile in app.libraryHeaderFiles:
				file.write("#import <")
				file.write(libraryHeaderFile)
				file.write(">\n")
			file.write("\n")

			# import external header files
			for externalHeaderFile in app.externalHeaderFiles:
				file.write("#import \"")
				file.write(externalHeaderFile)
				file.write("\"\n")
			file.write("\n")

			# define "private" properties
			file.write("@interface " + app.className  + "()\n")
			file.write("// \"private\" properties:\n")
			for component in app.components:
				if not component.isAppDelegate and not component.isInstanceFactoryProduct:
					file.write("@property (nonatomic, strong) ")
					file.write("id<")
					file.write(component.protocolName)
					file.write("> ")
					file.write(component.name)
					file.write(";\n")
			file.write("@end\n\n\n")


			# open implementation
			file.write("@implementation " + app.className  + "\n\n")
			file.write("@synthesize");
			componentList = "";
			for component in app.components:
				if not component.isAppDelegate and not component.isInstanceFactoryProduct:
					componentList += " "
					componentList += component.name
					componentList += ","
			file.write(componentList[:-1])
			file.write(";\n\n")

			# app delegate injection
			file.write("- (void)injectDependenciesIntoAppDelegate:(id<InjectableAppDelegate>)anInjectableAppDelegate\n")
			file.write("{\n")
			file.write("\t[anInjectableAppDelegate ")
			self.writeDesignatedInitializer(file, componentMap, appDelegate, "inject")
			file.write("];\n")
			file.write("}\n\n")

			# accessor implementations
			for component in app.components:
				if component.isAppDelegate or component.isInstanceFactoryProduct:
					continue

				# - (id<FooProtocol>) foo
				file.write("\n- (id<")
				file.write(component.protocolName)
				file.write(">) ")
				file.write(component.name)
				file.write("\n{\n")

				# if(!foo)
				file.write("\tif(!")
				file.write(component.name)
				file.write(")\n")
				file.write("\t{\n")

				componentImplName = component.name + "Impl"

				# foo = [[Foo alloc] init];
				file.write("\t\t")
				file.write(component.className);
				file.write("* ");
				file.write(componentImplName)
				file.write(" = [[")
				file.write(component.className)
				file.write(" alloc] ");
				self.writeDesignatedInitializer(file, componentMap, component, "init");
				file.write("];\n");

				 # [foo setDependency1:dependency1]
				 # [foo setDependency2:dependency2]
				self.writeDependencySetterInjections(file, componentMap, component, componentImplName, 2)

				file.write("\t\t[self set")
				file.write(component.name[0].capitalize())
				file.write(component.name[1:])
				file.write(":")
				file.write(componentImplName)
				file.write("];\n")

				file.write("\t}\n")

				# return foo;
				file.write("\treturn ")
				file.write(component.name)
				file.write(";\n}\n\n")

			self.writeInstanceFactoryMethods(file, app, componentMap)

			# close implementation
			file.write("\n@end\n")
