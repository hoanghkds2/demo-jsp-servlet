
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
    
public class DBConnection {

    public static String url = "jdbc:sqlserver://THANH-HOANG;databaseName=demo;encrypt=true;trustServerCertificate=true";
    public static String user = "sa";
    public static String password = "admin123";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection(url, user, password);
            return con;
        } catch (Exception e) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public static void main(String[] args) {
        try (Connection con = DBConnection.getConnection();) {
            System.out.println("Success!");
        } catch (SQLException e) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
