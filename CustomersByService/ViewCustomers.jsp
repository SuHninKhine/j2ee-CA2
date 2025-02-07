<%@ page import="java.util.List, dbaccess.Users, dbaccess.ServiceCategories, dbaccess.Services" %>
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
    <h2>Customers Who Booked Services</h2>

    <form action="CategoryServiceServlet" method="get">
        <label for="category_id">Select Category:</label>
        <select name="category_id" id="categorySelect" onchange="this.form.submit()">
            <option value="">-- Choose a Category --</option>
            <% List<ServiceCategories> categories = (List<ServiceCategories>) request.getAttribute("categories");
               if (categories != null) {
                   for (ServiceCategories category : categories) { %>
                       <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                   <% }
               } %>
        </select>
    </form>

    <br>

    <% List<Services> services = (List<Services>) request.getAttribute("services");
       if (services != null && !services.isEmpty()) { %>
        <form action="ViewCustomersServlet" method="get">
            <label for="service_id">Select Service:</label>
            <select name="service_id" required>
                <% for (Services service : services) { %>
                    <option value="<%= service.getServiceId() %>"><%= service.getServiceName() %></option>
                <% } %>
            </select>
            <button type="submit">Search</button>
        </form>
    <% } %>

    <br>

    <% List<Users> customers = (List<Users>) request.getAttribute("customers");
       if (customers != null && !customers.isEmpty()) { %>
        <h3>Customers</h3>
        <table>
            <tr><th>User ID</th><th>Username</th><th>Email</th></tr>
            <% for (Users user : customers) { %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>
