package idioms.logging

import java.util.logging.Logger
import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration

@Active(LogProcessor)
annotation Log {
}

class LogProcessor extends AbstractClassProcessor {

	override doTransform(MutableClassDeclaration cls, extension TransformationContext context) {
		cls.addField("log") [
			static = true
			final = true
			type = Logger.newTypeReference
			initializer = '''«Logger».getLogger("«cls.qualifiedName»")'''
		]
	}

}