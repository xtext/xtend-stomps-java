package examples.localization;

import java.text.MessageFormat;
import java.util.Locale;
import java.util.ResourceBundle;

public class MyMessagesJava {
	public static void main(final String[] args) {
		MyMessages messages = new MyMessages(Locale.GERMAN);
		System.out.println(messages.hello("World"));
		System.out.println(messages.filesRead(Integer.valueOf(3)));
	}

	private ResourceBundle bundle;

	public MyMessagesJava(Locale locale) {
		this.bundle = ResourceBundle.getBundle("examples.localization.MyMessages", locale);
	}

	public String getMessage(final String key) {
		return bundle.getString(key);
	}

	public final static String FILES_READ = "FILES_READ";

	public String filesRead(final Number arg0) {
		String pattern = bundle.getString(FILES_READ);
		MessageFormat format = new MessageFormat(pattern);
		return format.format(new Object[] { arg0 });
	}

	public final static String HELLO = "HELLO";

	public String hello(final Object arg0) {
		String pattern = bundle.getString(HELLO);
		MessageFormat format = new MessageFormat(pattern);
		return format.format(new Object[] { arg0 });
	}
}
