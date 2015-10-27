package examples.testing

import de.oehme.xtend.junit.Hamcrest
import de.oehme.xtend.junit.JUnit
import examples.rxjava.WikipediaDownloader

@JUnit
@Hamcrest
class TestingExample {

	def testWikipediaDownloader() {
		val articles = new WikipediaDownloader().getWikipediaArticles("Xtend")
		articles.toBlocking.forEach [ article |
			article => containsString("Xtend")
		]
	}
}