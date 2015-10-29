package idioms.javafx

import javafx.animation.Animation
import javafx.animation.PathTransition
import javafx.animation.RotateTransition
import javafx.application.Application
import javafx.geometry.Point2D
import javafx.scene.Group
import javafx.scene.Node
import javafx.scene.Scene
import javafx.scene.image.Image
import javafx.scene.image.ImageView
import javafx.scene.shape.QuadCurve
import javafx.stage.Stage

import static java.lang.Math.*
import static javafx.animation.Animation.Status.*
import static javafx.animation.Interpolator.*

import static extension javafx.util.Duration.*

class CatchTheQuirk extends Application {

	static val QUIRK_WIDTH = 100
	static val HALF_A_QUIRK = QUIRK_WIDTH / 2
	static val WINDOW_WIDTH = 640
	static val WINDOW_HEIGHT = 480
	
	Node quirk

	Animation ditherAnimation
	Animation evadeAnimation
	
	def static void main(String[] args) {
		launch
	}
	
	override start(Stage it) throws Exception {
		scene = new Scene(
			new Group => [
				children += quirk = new ImageView(loadQuirk) => [
					preserveRatio = true
					fitWidth = QUIRK_WIDTH
					translateX = WINDOW_WIDTH / 2 - HALF_A_QUIRK
					translateY = WINDOW_HEIGHT / 2 - HALF_A_QUIRK
					onMouseEntered = [
						evade
					]
					onMouseExited = [
						ditherAnimation?.stop
						evade
					]
					onMousePressed = [
						evadeAnimation?.stop
						dither
					]
					onMouseReleased = [
						ditherAnimation?.stop
						evade
					]
				] 
			], WINDOW_WIDTH, WINDOW_HEIGHT)
		show
	}
	
	private def evade() {
		if(!ditherAnimation.isRunning && !evadeAnimation.isRunning) {
			val newPosition = newRandomPosition
			val oldPosition = new Point2D(
				quirk.translateX + HALF_A_QUIRK, 
				quirk.translateY + HALF_A_QUIRK)
			evadeAnimation = new PathTransition => [
				node = quirk
				path = new QuadCurve => [
					startX = oldPosition.x
					startY = oldPosition.y
					if(random > 0.5) {
						controlX = oldPosition.x 
						controlY = newPosition.y
					} else {
						controlX = newPosition.x
						controlY = oldPosition.y
					} 
					endX = newPosition.x
					endY = newPosition.y
				]
				duration = 400.millis
				delay = 50.millis
				interpolator = EASE_OUT
				play
			]
		}
	}
	
	private def dither() {
		ditherAnimation = new RotateTransition => [
			node = quirk
			fromAngle = -10
			toAngle = 10
			duration = 80.millis
			autoReverse = true
			cycleCount = -1
			play
		]
	}
	
	private def isRunning(Animation animation) {
		animation?.status == RUNNING  
	}
	
	private def loadQuirk() {
		new Image(class.getResourceAsStream('Quirk.png'))
	}
	
	private def newRandomPosition() {
		val angle = 2 * random * PI
		val dx = 2 * cos(angle) * QUIRK_WIDTH
		var newX = quirk.translateX + dx
		if(newX < 0 || newX > WINDOW_WIDTH - QUIRK_WIDTH) 
			newX = quirk.translateX - dx
			
		val dy = 2 * sin(angle) * QUIRK_WIDTH
		var newY = quirk.translateY - dy
		if(newY < 0 || newY > WINDOW_HEIGHT - QUIRK_WIDTH)
			newY = quirk.translateY + dy
		return new Point2D(newX + HALF_A_QUIRK, newY + HALF_A_QUIRK)
	}
}