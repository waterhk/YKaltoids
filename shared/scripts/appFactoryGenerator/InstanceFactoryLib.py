def getOperationalDependencies(app, component):
	operationalDependencies = []
	for dependency in component.dependencies:
		if dependency[0] == "*":
			operationalDependencies.append(dependency[1:].strip())
		elif dependency.startswith(":*"):
			operationalDependencies.append(':' + dependency[2:].strip())
	return operationalDependencies


def factoryMethodSignature(app, component):
	signature = ""
	signature += "- (id<"
	signature += component.protocolName
	signature += ">) "

	signature += "create"
	signature += component.capitalizedName

	operationalDependencies = getOperationalDependencies(app, component)

	if operationalDependencies:
		signature += "With"
		for dependency in operationalDependencies:
			if dependency[0] == ":":
				dependency = dependency[1:]
			tokens = dependency.split(":")
			if len(tokens) != 2:
				raise Exception("Expected name:type for operational dependency but got: " + dependency)

			parameterName = tokens[0].strip()

			signature += parameterName
			signature += ":"
			signature += tokens[1].strip()
			signature += "op_"
			signature += parameterName[0].lower() + parameterName[1:]
			signature += " "

	signature = signature.strip()

	return signature

