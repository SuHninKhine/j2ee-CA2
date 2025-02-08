<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dbaccess.Services" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Best & Least Rated Services</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <h2>Best Rated Services</h2>
    <table>
        <tr>
            <th>Service Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Average Rating</th>
        </tr>
        <%
            List<Services> bestRatedServices = (List<Services>) request.getAttribute("bestRatedServices");
            if (bestRatedServices != null && !bestRatedServices.isEmpty()) {
                for (Services service : bestRatedServices) {
        %>
        <tr>
            <td><%= service.getServiceName() %></td>
            <td><%= service.getDescription() %></td>
            <td>$<%= service.getPrice() %></td>
            <td><%= service.getAvgRating() %></td>
        </tr>
        <%  
                }
            } else {
        %>
        <tr><td colspan="4">No best-rated services found.</td></tr>
        <% } %>
    </table>

    <h2>Least Rated Services</h2>
    <table>
        <tr>
            <th>Service Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Average Rating</th>
        </tr>
        <%
            List<Services> leastRatedServices = (List<Services>) request.getAttribute("leastRatedServices");
            if (leastRatedServices != null && !leastRatedServices.isEmpty()) {
                for (Services service : leastRatedServices) {
        %>
        <tr>
            <td><%= service.getServiceName() %></td>
            <td><%= service.getDescription() %></td>
            <td>$<%= service.getPrice() %></td>
            <td><%= service.getAvgRating() %></td>
        </tr>
        <%  
                }
            } else {
        %>
        <tr><td colspan="4">No least-rated services found.</td></tr>
        <% } %>
    </table>

</body>
</html>
