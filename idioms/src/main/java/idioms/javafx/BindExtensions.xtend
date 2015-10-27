package idioms.javafx

import javafx.beans.binding.DoubleExpression
import javafx.beans.property.StringProperty
import javafx.beans.value.ObservableStringValue

class BindExtensions {
	static def <<(StringProperty property, ObservableStringValue value) {
		property.bind(value)
	}

	static def /(DoubleExpression left, DoubleExpression right) {
		left.divide(right)
	}
}