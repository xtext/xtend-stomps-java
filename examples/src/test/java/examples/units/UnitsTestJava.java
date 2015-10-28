package examples.units;

import static idioms.units.Distance.km;
import static idioms.units.Distance.m;
import static idioms.units.Speed.speed;
import static idioms.units.Time.h;
import static idioms.units.Time.min;
import static idioms.units.Time.ms;
import static idioms.units.Time.s;
import static org.junit.Assert.assertEquals;

import org.junit.Test;

import idioms.units.Distance;

public class UnitsTestJava {

	@Test
	public void testDistances() {
		assertEquals(km(15), km(13).plus(m(2_000)));
		assertEquals(km(30), km(13).plus(m(2_000)).multiply(2));

		Distance distance = km(10);
		for (int i = 0; i <= 10; i++) {
			distance = distance.plus(km(i));
		}
		assertEquals(km(65), distance);
	}

	@Test
	public void testTime() {
		assertEquals(h(1), s(65).plus(min(59)).minus(ms(5_000)));
	}

	@Test
	public void testSpeed() {
		assertEquals(speed(km(42), h()), speed(m(40_000).plus(km(2)), min(60)));
	}
}
