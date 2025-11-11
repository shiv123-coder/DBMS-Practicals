package abc;

import java.sql.Connection;
import java.sql.DriverManager;

public class CheckConnection {
    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/practical", "root", "1234");
        System.out.println("Database Connected...");
        c.close();
    }
}
