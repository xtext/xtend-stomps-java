package examples.javafx

import javafx.application.Application
import javafx.geometry.Pos
import javafx.scene.Scene
import javafx.scene.control.Button
import javafx.scene.layout.VBox
import javafx.scene.text.Text
import javafx.stage.Stage

import static extension idioms.javafx.BindExtensions.*

class FxApp extends Application {
	def static void main(String[] args) {
		launch(args)
	}

	override start(Stage stage) throws Exception {
		val aspectRatio = stage.widthProperty / stage.heightProperty
		val root = new VBox => [
			alignment = Pos.CENTER
			children += new Button => [
				text = 'Log aspect ratio'
				onAction = [
					println('''Aspect ratio is «aspectRatio.get»''')
				]
			]
			children += new Text => [
				textProperty << aspectRatio.asString
			]
		]
		stage.title = "Hello World!"
		stage.scene = new Scene(root, 300, 200)
		stage.show
	}

}