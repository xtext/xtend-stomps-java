package examples.rxjava;

import java.net.URL;

import com.google.common.base.Charsets;
import com.google.common.io.Resources;

import rx.Observable;

public class WikipediaDownloaderJava {
	
	public static void main(String[] args) {
		new WikipediaDownloaderJava()
			.getWikipediaArticles("Tiger", "Elephant")
			.map(article -> article.substring(0,Math.min(125, article.length())) + "...")
			.subscribe(article -> {
				System.out.println("Article--------");
				System.out.println(article);
			});
	}

	public Observable<String> getWikipediaArticles(String... subjects) {
		return Observable.create(subscriber -> {
			new Thread(()-> {
				for (String subject : subjects) {
					if (subscriber.isUnsubscribed())
						return;
					URL articleUrl;
					try {
						articleUrl = new URL("https://en.wikipedia.org/wiki/" + subject);
						String article = Resources.toString(articleUrl, Charsets.UTF_8);
						subscriber.onNext(article);
					} catch (Exception e) {
						subscriber.onError(e);
					}
				}
				if (!subscriber.isUnsubscribed())
					subscriber.onCompleted();
			}).start();
		});
	}
}
