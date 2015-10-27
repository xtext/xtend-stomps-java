package examples.units

import org.junit.Test

import static org.junit.Assert.*

import static extension idioms.units.Distance.*
import static extension idioms.units.Speed.*
import static extension idioms.units.Time.*

class UnitsTest {

	@Test 
	def distances() {
		assertEquals(15.km, 13.km + 2_000.m)
		assertEquals(30.km, (13.km + 2_000.m) * 2)

		// if you implement +, you get += for free
		var distance = 10.km
		for (i : 1 .. 10) {
			distance += i.km
		}
		assertEquals(65.km, distance)
	}

	@Test 
	def time() {
		assertEquals(1.h, 65.s + 59.min - 5_000.ms)
	}

	@Test 
	def speed() {
		assertEquals(42.km / h, (40_000.m + 2.km) / 60.min)
	}
}
