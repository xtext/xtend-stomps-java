package examples.codegen

import javafx.application.Application
import javafx.scene.Group
import javafx.scene.Scene
import javafx.scene.shape.Circle
import javafx.scene.shape.Rectangle
import javafx.stage.Stage
import javafx.scene.shape.Ellipse
import javafx.scene.paint.Color
import java.io.FileWriter

class ExampleScene extends Application {
	
	def static void main(String[] args) {
		launch
	}
	
	override start(Stage it) throws Exception {
		scene = new Scene(new Group => [
			children += newEye => [
				relocate(80, 90)
			]
			children += newEye => [
				relocate(180, 90)
			]
			children += new Rectangle(140, 140, 20,30) => [
				fill = Color.GREEN
			]
			children += new Ellipse(150, 210, 50,10) => [
				fill = Color.RED
			]
		],300,300)
		exportToSvg
		show
	}
	
	def newEye() {
		new Group => [
			children += new Circle(0, 0, 20) => [
				fill = Color.BLUE
			]
			children += new Circle(5, -5, 10) => [
				fill = Color.BLACK
			]
		]
	}
	
	def exportToSvg(Stage stage) {
		new FileWriter('Scene.svg') => [
			write(println(new JavaFx2SvgConverter().toSvg(stage.scene)))
			close	
		]
	}
}