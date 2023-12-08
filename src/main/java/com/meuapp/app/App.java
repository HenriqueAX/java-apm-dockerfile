import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class App {

    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:13306/mydatabase";
        String user = "root"; // Replace with your database username
        String password = "root"; // Replace with your database password

        try {

            Connection connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connected to the database successfully");

            connection.close();
        } catch (SQLException e) {
            System.out.println("Database connection failed");
            e.printStackTrace();
        }
    }
}
