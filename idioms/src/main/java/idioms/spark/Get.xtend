package idioms.spark

import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.MethodDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import spark.Request
import spark.Response
import spark.Route
import spark.Spark

@Active(SparkAppProcessor)
annotation SparkApp {
}

annotation Get {
	String value
}

class SparkAppProcessor extends AbstractClassProcessor {

	override doTransform(MutableClassDeclaration cls, extension TransformationContext context) {
		val handlers = cls.declaredMethods.filter[findAnnotation(Get.findTypeGlobally) !== null]

		handlers.forEach [
			if (!static)
				addError("Handlers must be static")
			returnType = object
			addParameter("request", Request.newTypeReference)
			addParameter("response", Response.newTypeReference)
			getRequestParameters(context).forEach [ requestParameter |
				addParameter(requestParameter.substring(1), string)
			]
		]
		cls.addMethod("main") [
			addParameter("args", string.newArrayTypeReference)
			static = true
			returnType = primitiveVoid
			body = '''
				«FOR method : handlers»
					«Spark».get("«method.getPath(context)»", new «Route»() {
						public Object handle(«Request» request, «Response» response) {
							return «method.simpleName»(request, response«FOR p : method.getRequestParameters(context)», request.params("«p»")«ENDFOR»);
						}
					});
				«ENDFOR»
			'''
		]
	}

	private def getPath(MethodDeclaration method, extension TransformationContext context) {
		val get = method.findAnnotation(Get.findTypeGlobally)
		get.getStringValue("value")
	}

	private def getRequestParameters(MethodDeclaration method, extension TransformationContext context) {
		method.getPath(context).split("/").filter[startsWith(":")]
	}
}