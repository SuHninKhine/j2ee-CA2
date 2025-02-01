package dbaccess;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

    // Method to get popular cleaning services based on demand
    public static List<Services> getPopularCleaningServices() {
        List<Services> popularServices = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            // Debug print
            System.out.println("Connected to DB: Fetching popular services...");

            // Query to find services with high demand based on booking trends
            String sql = "SELECT s.service_Id, s.service_name, s.description, s.price, s.category_Id, s.image_path \r\n"
            		+ "                         FROM services s \r\n"
            		+ "                         JOIN booking_trends bt ON s.service_Id = bt.service_Id \r\n"
            		+ "                         WHERE bt.bookings_Count > ?\r\n"
            		+ "                         ORDER BY bt.bookings_Count DESC"; 

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, 1);  // Lower threshold to test data

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Services service = new Services();
                service.setServiceId(rs.getInt("service_Id"));
                service.setServiceName(rs.getString("service_name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setCategoryId(rs.getInt("category_Id"));
                service.setImagePath(rs.getString("image_path"));

                popularServices.add(service);

                // Debug output
                System.out.println("Found popular service: " + service.getServiceName());
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (popularServices.isEmpty()) {
            System.out.println("No popular services found.");
        }

        return popularServices;
    }
    
    
    public static List<Services> getTopRatedServices(boolean bestRated) {
        List<Services> services = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT s.*, COALESCE(AVG(f.rating), 0) AS avg_rating " +
                         "FROM services s " +
                         "JOIN bookings b ON s.service_id = b.service_id " +
                         "JOIN feedbacks f ON b.booking_id = f.booking_id " +
                         "GROUP BY s.service_id " +
                         "HAVING COUNT(f.rating) > 0 " + 
                         "ORDER BY avg_rating " + (bestRated ? "DESC" : "ASC") + 
                         " LIMIT 10";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Services service = new Services();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setCategoryId(rs.getInt("category_id"));
                service.setImagePath(rs.getString("image_path"));

                services.add(service);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return services;
    }
}
