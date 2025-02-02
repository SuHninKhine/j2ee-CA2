package dbaccess;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Method to retrieve customers who booked a specific service
    public static List<Users> getCustomersByService(int service_id) {
        List<Users> customers = new ArrayList<>();
        
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT DISTINCT u.* FROM users u " +
                         "JOIN bookings b ON u.id = b.user_id " +
                         "WHERE b.service_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, service_id);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRoleId(rs.getInt("role_id")); // Assuming roleId is for role management

                customers.add(user);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return customers;
    }
    
    public static List<Users> getTopSpendingUsers() throws Exception {
        List<Users> topSpendingUsers = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            // Query to get top 10 users by total spending, calculated from the Payments and Receipts tables
            String sql = "SELECT u.id, u.username, u.email, SUM(p.amount) AS total_spent " +
                         "FROM users u " +
                         "JOIN receipt r ON u.id = r.user_id " +
                         "JOIN payments p ON r.receipt_id = p.receipt_id " +
                         "GROUP BY u.id " +
                         "ORDER BY total_spent DESC " +
                         "LIMIT 10";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Users user = new Users();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                // Set the total spent directly from the query result
                user.setTotalSpent(rs.getBigDecimal("total_spent"));

                topSpendingUsers.add(user);
            }

            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return topSpendingUsers;
    }
}
