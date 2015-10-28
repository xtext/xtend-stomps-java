package examples.javafx;

import javafx.application.Application;
import javafx.beans.binding.DoubleBinding;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class FxAppJava extends Application {
	public static void main(final String[] args) {
		Application.launch(args);
	}

	@Override
	public void start(final Stage stage) throws Exception {
		DoubleBinding aspectRatio = stage.widthProperty().divide(stage.heightProperty());

		Button button = new Button();
		button.setText("Log aspect ratio");
		button.setOnAction(e -> {
			System.out.println("Aspect ratio is " + aspectRatio.get());
		});

		Text text = new Text();
		text.textProperty().bind(aspectRatio.asString());

		VBox root = new VBox();
		root.setAlignment(Pos.CENTER);
		root.getChildren().add(button);
		root.getChildren().add(text);

		stage.setTitle("Hello World!");
		stage.setScene(new Scene(root, 300, 200));
		stage.show();
	}
}
