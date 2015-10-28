package examples.logging;

import java.util.logging.Logger;

public class LoggingClientJava {
	private final static Logger log = Logger.getLogger(LoggingClientJava.class.getName());

	public void saySomething() {
		log.info("Hello World");
	}

}
