package DAO;

import java.util.ArrayList;
import java.util.List;
import model.*;
import DAO.DBConnection;
import static DAO.DBConnection.password;
import static DAO.DBConnection.url;
import static DAO.DBConnection.user;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {

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

    public List<User> getAllUsers() {
        String query = "SELECT * FROM Users";
        List<User> users = new ArrayList<>();
        try (Connection con = getConnection()) {
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int iD = rs.getInt("userID");
                String usernames = rs.getString("username");
                String firstname = rs.getString("first_name");
                String lastname = rs.getString("last_name");
                String phonenumber = rs.getString("phone_number");

                User us = new User(iD, usernames, firstname, lastname, phonenumber);
                users.add(us);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return users;
    }

    public void insertUser(String username, String firstname, String lastname, String phonenumber) {
        String query = "insert into Users(username,first_name, last_name,phone_number)"
                + "values(?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, firstname);
            ps.setString(3, lastname);
            ps.setString(4, phonenumber);
            try {
                ps.executeUpdate();
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception err) {
            System.out.println(err);
        }
    }

    public void deleteUserByID(int userID) {
        String query = "delete from Users where userID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userID);
            try {
                ps.executeUpdate();
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updateUserByID(int userID, String username, String firstname, String lastname, String phonenumber) {
        String query = "update Users set username = ?, first_name = ?, last_name = ?, phone_number = ? where userID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, firstname);
            ps.setString(3, lastname);
            ps.setString(4, phonenumber);
            ps.setInt(5, userID);
            try {
                ps.executeUpdate();
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
