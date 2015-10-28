package examples.movies;

import static com.google.common.collect.Lists.newArrayList;
import static com.google.common.io.CharStreams.readLines;
import static java.lang.Double.parseDouble;
import static java.lang.Integer.parseInt;
import static java.lang.Long.parseLong;
import static java.util.Comparator.comparing;
import static java.util.stream.Collectors.counting;
import static java.util.stream.Collectors.groupingBy;
import static org.junit.Assert.assertEquals;

import java.io.FileReader;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Stream;

import org.junit.Test;

import com.google.common.base.CharMatcher;
import com.google.common.base.Splitter;
import com.google.common.collect.ImmutableSet;

public class MoviesJava {
	
	@Test
	public void numberOfActionMovies() throws Exception {
		assertEquals(828, getMovies().filter(it -> it.getCategories().contains("Action")).count());
	}
	@Test
	public void titleOfBestMovieFrom80ies() throws Exception {
		assertEquals(
			"Dragon Ball Z", 
			getMovies()
				.filter(it -> it.getYear() >= 1980 && it.getYear() <= 1989)
				.max(comparing(Movie::getRating))
				.get().getTitle()
		);
	}
	@Test
	public void mostProductiveYear() throws Exception {
		assertEquals(
			Integer.valueOf(2007), 
			getMovies()
				.collect(groupingBy(Movie::getYear, counting()))
				.entrySet().stream()
				.max(comparing(Map.Entry::getValue))
				.get().getKey()
		);
	}
	@Test
	public void totalNumberOfVotesCast() throws Exception {
		assertEquals(
			135524691L, 
			getMovies().mapToLong(Movie::getNumberOfVotes).sum()
		);
	}
	
	private Stream<Movie> getMovies() throws Exception {
		FileReader fileReader = new FileReader("data.csv");
		List<String> lines = readLines(fileReader);
		return lines.stream().map(line -> {
			Iterator<String> segments = splitLine(line).stream().map(this::trimQuotes).iterator();
			return new Movie(
				segments.next(),
				parseInt(segments.next()),
				parseDouble(segments.next()),
				parseLong(segments.next()),
				ImmutableSet.copyOf(segments)
			);
		});
	}
	
	private List<String> splitLine(CharSequence line) {
		return newArrayList(Splitter.on("  ").split(line));
	}

	private String trimQuotes(CharSequence segment) {
		return CharMatcher.is('"').trimFrom(segment);
	}
}

class MovieJava {
	private String title;
	private int year;
	private double rating;
	private long numberOfVotes;
	private Set<String> categories;

	public MovieJava(String title, int year, double rating, long numberOfVotes, Set<String> categories) {
		this.title = title;
		this.year = year;
		this.rating = rating;
		this.numberOfVotes = numberOfVotes;
		this.categories = categories;
	}

	public String getTitle() {
		return title;
	}

	public int getYear() {
		return year;
	}

	public double getRating() {
		return rating;
	}

	public long getNumberOfVotes() {
		return numberOfVotes;
	}

	public Set<String> getCategories() {
		return categories;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((categories == null) ? 0 : categories.hashCode());
		result = prime * result + (int) (numberOfVotes ^ (numberOfVotes >>> 32));
		long temp;
		temp = Double.doubleToLongBits(rating);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + year;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MovieJava other = (MovieJava) obj;
		if (categories == null) {
			if (other.categories != null)
				return false;
		} else if (!categories.equals(other.categories))
			return false;
		if (numberOfVotes != other.numberOfVotes)
			return false;
		if (Double.doubleToLongBits(rating) != Double.doubleToLongBits(other.rating))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (year != other.year)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MovieJava [title=" + title + ", year=" + year + ", rating=" + rating + ", numberOfVotes="
				+ numberOfVotes + ", categories=" + categories + "]";
	}

}
