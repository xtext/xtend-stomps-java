package examples.spark;

import spark.Spark;

public class HelloWebAppJava {
	public static void main(String[] args) {
		Spark.get("/hello", (req, res) -> {
			return "Hello World";
		});
		Spark.get("/hello/:name", (req, res) -> {
			return "Hello " + req.params(":name");
		});
	}
}
