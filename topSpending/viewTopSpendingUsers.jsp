<%@ page import="java.util.List, dbaccess.Users" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
    <title>Top Spending Users</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f4f4f4; }
    </style>
</head>
<body>
    <h2>Top 10 Spending Users</h2>

    <table>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Total Spent</th>
        </tr>

        <% 
            List<Users> topUsers = (List<Users>) request.getAttribute("topUsers");
            if (topUsers != null && !topUsers.isEmpty()) {
                for (Users user : topUsers) {
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
                    <td colspan="4">No top spending users found.</td>
                </tr>
        <% 
            }
        %>
    </table>
</body>
</html>
