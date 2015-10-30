package examples.spark;

import spark.Spark;

public class HelloWebAppJava {
	public static void main(String[] args) {
		Spark.get("/hello", (req, res) -> "Hello World");
		Spark.get("/hello/:name", (req, res) -> "Hello " + req.params(":name"));
	}
}
