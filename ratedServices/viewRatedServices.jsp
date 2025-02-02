<%@ page import="java.util.List, dbaccess.Services" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
    <title>View Rated Cleaning Services</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f4f4f4; }
    </style>
</head>
<body>
    <h2>Rated Cleaning Services</h2>

    <form action="<%=request.getContextPath()%>/ViewRatedServicesServlet" method="get">
        <label for="type">View:</label>
        <select name="type" id="type" required>
            <option value="best">Best Rated</option>
            <option value="lowest">Lowest Rated</option>
        </select>
        <button type="submit">Search</button>
    </form>

    <%
        List<Services> services = (List<Services>) request.getAttribute("services");
        String type = (String) request.getAttribute("type");
        System.out.print("services in jsp"+services);

        if (services != null && !services.isEmpty()) {
    %>
        <h3><%= "best".equals(type) ? "Best Rated Cleaning Services" : "Lowest Rated Cleaning Services" %></h3>
        <table>
            <tr>
                <th>Service ID</th>
                <th>Service Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Category ID</th>
            </tr>
            <%
                for (Services service : services) {
            %>
                <tr>
                    <td><%= service.getServiceId() %></td>
                    <td><%= service.getServiceName() %></td>
                    <td><%= service.getDescription() %></td>
                    <td>$<%= service.getPrice() %></td>
                    <td><%= service.getCategoryId() %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>No services found.</p>
    <% } %>
</body>
</html>
