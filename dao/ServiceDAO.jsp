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
    
    
 // Get all services
    public List<Services> getAllServices() throws SQLException {
        Connection conn = DBConnection.getConnection();
        List<Services> servicesList = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // SQL query to fetch all services
            String sql = "SELECT * FROM services";
            stmt = conn.prepareStatement(sql);
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

        return servicesList;  // Return the list of services
    }
    
 // Get all categories
    public List<ServiceCategories> getAllCategories() throws SQLException {
        Connection conn = DBConnection.getConnection();
        List<ServiceCategories> categoryList = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM service_categories";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                ServiceCategories category = new ServiceCategories();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));

                categoryList.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }

        return categoryList;
    }
    
    public List<Services> getTopRatedServices(boolean bestRated) {
        List<Services> services = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT s.*, COALESCE(AVG(f.rating), 0) AS avg_rating " +
                         "FROM services s " +
                         "JOIN bookings b ON s.service_id = b.service_id " +
                         "JOIN feedbacks f ON b.booking_id = f.booking_id " +
                         "GROUP BY s.service_id " +
                         "HAVING COUNT(f.rating) > 0 " +
                         "ORDER BY avg_rating " + (bestRated ? "DESC" : "ASC") +
                         " LIMIT 10";

            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Services service = new Services();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setAvgRating(rs.getDouble("avg_rating"));
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return services;
    }
    
    public List<Services> getServicesByRating(double minRating) {
        List<Services> servicesList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT s.*, COALESCE(AVG(f.rating), 0) AS avg_rating " +
                         "FROM services s " +
                         "JOIN bookings b ON s.service_id = b.service_id " +
                         "JOIN feedbacks f ON b.booking_id = f.booking_id " +
                         "GROUP BY s.service_id " +
                         "HAVING avg_rating >= ? " +  // Filter for rating >= minRating
                         "ORDER BY avg_rating DESC";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, minRating); // Set the minimum rating parameter
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Services service = new Services();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setAvgRating(rs.getDouble("avg_rating")); // Ensure getter & setter exists

                servicesList.add(service);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return servicesList;
    }
    
    public List<Services> getRatingAllServices() {
        List<Services> servicesList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT s.*, " +
                         "COALESCE((SELECT AVG(f.rating) FROM bookings b " +
                         "JOIN feedbacks f ON b.booking_id = f.booking_id " +
                         "WHERE b.service_id = s.service_id), 0) AS avg_rating " +
                         "FROM services s";
            
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Services service = new Services();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setCategoryId(rs.getInt("category_id"));
                service.setAvgRating(rs.getDouble("avg_rating")); // ✅ Now avgRating is set correctly

                servicesList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return servicesList;
    }

}
