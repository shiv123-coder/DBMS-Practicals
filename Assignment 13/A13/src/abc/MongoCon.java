package abc;

import com.mongodb.client.*;
import org.bson.Document;
import java.util.Scanner;

public class MongoCon {
    public static void main(String[] args) {
        MongoClient mongo = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase db = mongo.getDatabase("studentDB");
        MongoCollection<Document> col = db.getCollection("students");
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("\n1.Add  2.View  3.Edit  4.Delete  5.Exit");
            System.out.print("Enter choice: ");
            int ch = sc.nextInt(); sc.nextLine();

            if (ch == 1) {
                System.out.print("Roll No: "); int r = sc.nextInt(); sc.nextLine();
                System.out.print("Name: "); String n = sc.nextLine();
                System.out.print("Branch: "); String b = sc.nextLine();
                col.insertOne(new Document("roll", r).append("name", n).append("branch", b));
                System.out.println("Record Added!");
            } 
            else if (ch == 2) {
                for (Document d : col.find()) System.out.println(d.toJson());
            } 
            else if (ch == 3) {
                System.out.print("Roll No to Edit: "); int r = sc.nextInt(); sc.nextLine();
                System.out.print("New Branch: "); String nb = sc.nextLine();
                col.updateOne(new Document("roll", r), new Document("$set", new Document("branch", nb)));
                System.out.println("Record Updated!");
            } 
            else if (ch == 4) {
                System.out.print("Roll No to Delete: "); int r = sc.nextInt();
                col.deleteOne(new Document("roll", r));
                System.out.println("Record Deleted!");
            } 
            else if (ch == 5) {
                System.out.println("Exiting...");
                break;
            } 
            else {
                System.out.println("Invalid Choice!");
            }
        }

        sc.close();
        mongo.close();
    }
}
