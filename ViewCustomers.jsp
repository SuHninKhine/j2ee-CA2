<%@ page import="java.util.List, dbaccess.Users" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
    <title>View Customers</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f4f4f4; }
    </style>
</head>
<body>
    <h2>Customers Who Booked Cleaning Service</h2>

    <form action="<%=request.getContextPath()%>/ViewCustomersServlet" method="get">
        <label for="service_id">Select Service ID:</label>
        <input type="number" name="service_id" required>
        <button type="submit">Search</button>
    </form>

    <%
        List<Users> customers = (List<Users>) request.getAttribute("customers");
        Integer service_id = (Integer) request.getAttribute("service_id");

        if (customers != null && !customers.isEmpty()) {
    %>
        <h3>Customers for Service ID: <%= service_id %></h3>
        <table>
            <tr>
                <th>User ID</th>
                <th>Username</th>
                <th>Email</th>
            </tr>
            <%
                for (Users user : customers) {
            %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                </tr>
            <% } %>
        </table>
    <% } else if (service_id != null) { %>
        <p>No customers found for Service ID: <%= service_id %>.</p>
    <% } %>
</body>
</html>
