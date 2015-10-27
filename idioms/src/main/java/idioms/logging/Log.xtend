package idioms.logging

import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.TransformationContext
import java.util.logging.Logger

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