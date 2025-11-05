package abc;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

public class MongoConnectTest {
    public static void main(String[] args) {
        // Create a Mongo client connected to localhost on port 27017
        MongoClient mongoClient = new MongoClient("localhost", 27017);

        // Access database (if not exists, MongoDB creates it automatically when data is inserted)
        MongoDatabase db = mongoClient.getDatabase("test");

        // Print confirmation message
        System.out.println("Connected to Database: " + db.getName());

        // Close the connection
        mongoClient.close();
    }
}
