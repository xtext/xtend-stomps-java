package examples.movies

import com.google.common.base.CharMatcher
import com.google.common.base.Splitter
import java.io.FileReader
import java.util.Set
import org.eclipse.xtend.lib.annotations.Data
import org.junit.Test

import static org.junit.Assert.*

import static extension com.google.common.io.CharStreams.*
import static extension java.lang.Double.*
import static extension java.lang.Integer.*
import static extension java.lang.Long.*

class Movies {

	@Test def void numberOfActionMovies() {
		assertEquals(828, movies.filter[categories.contains('Action')].size)
	}

	@Test def void titleOfBestMovieFrom80ies() {
		assertEquals("Dragon Ball Z", movies.filter[(1980 .. 1989).contains(year)].maxBy[rating].title)
	}

	@Test def void mostProductiveYear() {
		assertEquals(2007, movies.groupBy[year].entrySet.maxBy[value.size].key)
	}

	@Test def void totalNumberOfVotesCast() {
		assertEquals(135524691, movies.map[numberOfVotes].reduce[$0 + $1])
	}

	val movies = new FileReader('data.csv').readLines.map [ line |
		val segments = line.splitLine.map[trimQuotes].iterator
		return new Movie(
			segments.next,
			segments.next.parseInt,
			segments.next.parseDouble,
			segments.next.parseLong,
			segments.toSet
		)
	]
	
	private def splitLine(CharSequence line) {
		Splitter.on('  ').split(line)
	}

	private def trimQuotes(CharSequence segment) {
		CharMatcher.is('"').trimFrom(segment)
	}
}

@Data class Movie {
	String title
	int year
	double rating
	long numberOfVotes
	Set<String> categories
}