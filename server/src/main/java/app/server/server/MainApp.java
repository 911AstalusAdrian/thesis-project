package app.server.server;

import app.server.server.model.User;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@SpringBootApplication
public class MainApp {

	public static void main(String[] args) throws IOException {

//		User testUser = new User("John", "Doe", "johndoe@gmail.com", "ItsDJoe");
//
//		FileInputStream refreshToken = new FileInputStream("D:\\Uni\\PBT\\thesis-project-firebase-24b03-4ca113bd8e4b.json");
//		FirebaseOptions options = FirebaseOptions.builder()
//				.setCredentials(GoogleCredentials.fromStream(refreshToken))
//				.setDatabaseUrl("https://thesis-project-firebase-24b03-default-rtdb.europe-west1.firebasedatabase.app/")
//				.build();
//		FirebaseApp myApp = FirebaseApp.initializeApp(options);
//		FirebaseDatabase myDatabase = FirebaseDatabase.getInstance(myApp);
//		DatabaseReference ref = myDatabase.getReference();
//
//		DatabaseReference usersRef = ref.child("users");
//		DatabaseReference newUser = usersRef.push();


//		newUser.setValue(testUser, new OnSuccessListener)


		SpringApplication.run(MainApp.class, args);
	}

}
