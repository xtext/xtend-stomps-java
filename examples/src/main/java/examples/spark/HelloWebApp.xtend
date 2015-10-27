package examples.spark

import idioms.spark.Get
import idioms.spark.SparkApp

@SparkApp
class HelloWebApp {
	
	@Get("/hello")
	static def hello() {
		"Hello World"
	}
	
	@Get("/hello/:name")
	static def hello() {
		"Hello " + name
	}
}