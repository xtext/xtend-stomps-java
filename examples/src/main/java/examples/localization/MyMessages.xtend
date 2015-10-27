package examples.localization

import de.oehme.xtend.contrib.localization.Messages
import java.util.Locale

@Messages
class MyMessages {
	def static void main(String[] args) {
		val messages = new MyMessages(Locale.GERMAN)
		println(messages.hello("World"))
		println(messages.filesRead(3))
	}
}