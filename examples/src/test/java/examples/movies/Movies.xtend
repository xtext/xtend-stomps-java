package examples.movies

import com.google.common.base.CharMatcher
import com.google.common.base.Splitter
import de.oehme.xtend.junit.JUnit
import java.io.FileReader
import java.util.Set
import org.eclipse.xtend.lib.annotations.Data
import org.junit.Test

import static extension com.google.common.io.CharStreams.*
import static extension java.lang.Double.*
import static extension java.lang.Integer.*
import static extension java.lang.Long.*

@JUnit
class Movies {

	@Test def void numberOfActionMovies() {
		movies.filter[categories.contains('Action')].size => 828
	}

	@Test def void titleOfBestMovieFrom80ies() {
		movies.filter[(1980 .. 1989).contains(year)].maxBy[rating].title => "Dragon Ball Z"
	}

	@Test def void mostProductiveYear() {
		movies.groupBy[year].entrySet.maxBy[value.size].key => 2007
	}

	@Test def void totalNumberOfVotesCast() {
		movies.map[numberOfVotes].reduce[$0 + $1] => 135524691L
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