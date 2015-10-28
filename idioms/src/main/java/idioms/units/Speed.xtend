package idioms.units

import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Data

@Data class Speed {
	BigDecimal metersPerSecond

	def static /(Distance d, Time t) {
		speed(d, t)
	}
	
	def static speed(Distance d, Time t) {
		new Speed(d.meters / t.seconds)
	}
}