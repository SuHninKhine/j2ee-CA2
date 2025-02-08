<%@ page import="java.util.List, dbaccess.Users" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Top Spending Users</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="mb-4">Top Spending Users</h2>

    <!-- Filter Options -->
    <form action="ViewTopSpendingUsersServlet" method="GET" class="mb-4">
        <button type="submit" name="filter" value="top10" class="btn btn-primary">View Top 10 Spenders</button>
        
        <div class="form-group d-inline-block ml-3">
            <label for="minSpent">Filter users who spent at least:</label>
            <input type="number" name="minSpent" id="minSpent" class="form-control d-inline-block w-auto" min="0">
            <button type="submit" class="btn btn-success">Apply Filter</button>
        </div>
        
        <a href="ViewTopSpendingUsersServlet" class="btn btn-secondary ml-2">Reset</a>
    </form>

    <!-- Error Message -->
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <!-- User Spending Table -->
    <table class="table table-bordered">
        <thead class="thead-light">
            <tr>
                <th>User ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Total Spent ($)</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Users> usersList = (List<Users>) request.getAttribute("usersList");
                if (usersList != null && !usersList.isEmpty()) {
                    for (Users user : usersList) {
            %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getTotalSpent() %></td>
                </tr>
            <% 
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" class="text-center">No users found.</td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
