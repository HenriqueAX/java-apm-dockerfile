import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class App {

    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:13306/mydatabase?useSSL=true&&enabledTLSProtocols=TLSv1&requireSSL=true&verifyServerCertificate=true&trustCertificateKeyStoreUrl=file:///app/ssl/ca.pem&trustCertificateKeyStorePassword=Henrique@00&clientCertificateKeyStoreUrl=file:///app/ssl/client-cert.pem&clientCertificateKeyStorePassword=Henrique@00";
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
