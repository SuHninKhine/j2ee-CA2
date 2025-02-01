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
}
