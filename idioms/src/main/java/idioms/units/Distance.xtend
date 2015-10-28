package idioms.units

import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Data

@Data class Distance {
	BigDecimal meters

	def +(Distance other) {
		plus(other)
	}
	
	def plus(Distance other) {
		new Distance(this.meters + other.meters)
	}

	def -(Distance other) {
		new Distance(this.meters - other.meters)
	}
	
	def *(int times) {
		multiply(times)
	}
	
	def multiply(int times) {
		new Distance(this.meters * new BigDecimal(times))
	}

	def /(int times) {
		new Distance(this.meters / new BigDecimal(times))
	}

	def static mm(int millimeters) {
		m(millimeters / 100)
	}

	def static cm(int centimeters) {
		m(centimeters / 10)
	}

	def static m(int meters) {
		new Distance(BigDecimal.valueOf(meters))
	}

	def static km(int kilometers) {
		m(kilometers * 1000)
	}

}