package abc;

import java.sql.*;
import java.util.Scanner;

public class DeptDB {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        Connection c = null;
        Statement sm = null;

        try {
            // Load JDBC driver (optional for newer versions)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/practical", "root", "1234");

            sm = c.createStatement();
            System.out.println("Database Connected...");

            int ch;
            do {
                System.out.println("Enter Choice:\n1 - Insert\n2 - Select\n3 - Update\n4 - Delete\n5 - Exit");
                ch = input.nextInt();
                input.nextLine(); // consume newline

                switch (ch) {
                    case 1:
                        String sqlInsert = "INSERT INTO Student VALUES (8, 1010, 'Pooja', 'Deore', 18, 'Nashik')";
                        sm.executeUpdate(sqlInsert);
                        System.out.println("Record is Inserted...");
                        break;

                    case 2:
                        String sqlSelect = "SELECT first_name, last_name, age, city FROM Student";
                        ResultSet rs = sm.executeQuery(sqlSelect);
                        while (rs.next()) {
                            String fname = rs.getString("first_name");
                            String lname = rs.getString("last_name");
                            int age = rs.getInt("age");
                            String city = rs.getString("city");

                            System.out.println("First Name: " + fname);
                            System.out.println("Last Name: " + lname);
                            System.out.println("Age: " + age);
                            System.out.println("City: " + city);
                            System.out.println("---------------------------");
                        }
                        break;

                    case 3:
                        String sqlUpdate = "UPDATE Student SET first_name='Manoj' WHERE id=5";
                        sm.executeUpdate(sqlUpdate);
                        System.out.println("Record is Updated...");
                        break;

                    case 4:
                        String sqlDelete = "DELETE FROM Student WHERE id=8"; // example
                        sm.executeUpdate(sqlDelete);
                        System.out.println("Record is Deleted...");
                        break;

                    case 5:
                        System.out.println("Exiting...");
                        break;

                    default:
                        System.out.println("Invalid Choice!");
                }
            } while (ch != 5);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (sm != null) sm.close();
                if (c != null) c.close();
                input.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
