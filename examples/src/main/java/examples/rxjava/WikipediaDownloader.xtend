package examples.rxjava

import com.google.common.base.Charsets
import com.google.common.io.Resources
import java.net.URL
import rx.Observable

class WikipediaDownloader {

	def static void main(String[] args) {
		new WikipediaDownloader()
			.getWikipediaArticles("Tiger", "Elephant")
			.map[substring(0, Math.min(125, length)) + "..."]
			.subscribe[article|
				println("Article-------------")
				println(article)
			]
	}

	def Observable<String> getWikipediaArticles(String... subjects) {
		return Observable.create [ subscriber |
			new Thread [
				for (subject : subjects) {
					if (subscriber.unsubscribed) {
						return
					}
					val articleUrl = new URL("https://en.wikipedia.org/wiki/" + subject)
					val article = Resources.toString(articleUrl, Charsets.US_ASCII)
					subscriber.onNext(article)
				}
				if (!subscriber.unsubscribed) {
					subscriber.onCompleted
				}
			].start
		]
	}
}