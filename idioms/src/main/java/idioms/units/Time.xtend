package idioms.units

import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Data

@Data class Time {
	BigDecimal seconds

	def +(Time other) {
		plus(other)
	}
	
	def plus(Time other) {
		new Time(this.seconds + other.seconds)
		
	}

	def -(Time other) {
		minus(other)
	}

	def minus(Time other) {
		new Time(this.seconds - other.seconds)
	}

	def *(int times) {
		new Time(this.seconds * new BigDecimal(times))
	}

	def /(int times) {
		new Time(this.seconds / new BigDecimal(times))
	}

	def static ms(int ms) {
		s(ms / 1000)
	}

	def static s(int s) {
		new Time(new BigDecimal(s))
	}

	def static min(int min) {
		s(min * 60)
	}

	def static h(int h) {
		min(h * 60)
	}

	def static h() {
		h(1)
	}
}