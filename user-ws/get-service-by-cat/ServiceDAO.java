package com.service.ca2_ws.dbaccess;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

    // Get list of services by categoryId
    public List<Services> getServicesByCategory(int categoryId) throws SQLException {
        Connection conn = DBConnection.getConnection();
        List<Services> servicesList = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // SQL query to fetch services by category ID
            String sql = "SELECT * FROM services WHERE category_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);

            rs = stmt.executeQuery();

            while (rs.next()) {
                Services service = new Services();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setCategoryId(rs.getInt("category_id"));
                service.setImagePath(rs.getString("image_path"));

                servicesList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }

        return servicesList;  // Returns an empty list if no services are found
    }
}
