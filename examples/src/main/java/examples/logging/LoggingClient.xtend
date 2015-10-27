package examples.logging

import idioms.logging.Log

@Log
class LoggingClient {
	def void saySomething() {
		log.info("Hello World")
	}
}