package examples.codegen

import javafx.scene.Group
import javafx.scene.Scene
import javafx.scene.shape.Circle
import javafx.scene.shape.Ellipse
import javafx.scene.shape.Rectangle
import javafx.scene.paint.Color

class JavaFx2SvgConverter {

	def dispatch String toSvg(Scene it) '''
		<?xml version="1.0" standalone="no"?>
		<!DOCTYPE svg PUBLIC 
			"-//W3C//DTD SVG 1.1//EN" 
			"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
		<svg 
			xmlns="http://www.w3.org/2000/svg" 
			xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"
			viewBox="«x» «y» «width» «height»">
			«root.toSvg»
		</svg>
	'''
	
	def dispatch String toSvg(Group it) '''
		<g transform="translate(«layoutX», «layoutY»)">
			«FOR child: children»
				«child.toSvg»
			«ENDFOR»
		</g>
	'''

	def dispatch String toSvg(Circle it) '''
		<circle cx="«centerX»" cy="«centerY»" r="«radius»" «fill.toSvg»/>
	'''

	def dispatch String toSvg(Rectangle it) '''
		<rect x="«x»" y="«y»" width="«width»" height="«height»" «fill.toSvg»/>
	'''

	def dispatch String toSvg(Ellipse it) '''
		<ellipse cx="«centerX»" cy="«centerY»" rx="«radiusX»" ry="«radiusY»" «fill.toSvg»/>
	'''
	
	def dispatch String toSvg(Color it) '''
		«IF it != null»fill="rgb(«red.toRgb», «green.toRgb», «blue.toRgb»)"«ENDIF»'''
		
	def toRgb(double value) {
		(value * 255) as int
	}
}