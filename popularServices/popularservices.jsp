<%@ page import="java.util.List" %>
<%@ page import="dbaccess.Services" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Popular Cleaning Services</title>
</head>
<body>
    <h2>Popular Cleaning Services</h2>
    <table border="1">
        <tr>
            <th>Service Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Image</th>
        </tr>
        <%
            List<Services> services = (List<Services>) request.getAttribute("popularServices");
            if (services != null) {
                for (Services service : services) {
        %>
        <tr>
            <td><%= service.getServiceName() %></td>
            <td><%= service.getDescription() %></td>
            <td>$<%= service.getPrice() %></td>
            <td><img src="/CA2/images/<%= service.getImagePath() %>" width="100"></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr><td colspan="4">No popular services found.</td></tr>
        <%
            }
        %>
    </table>
</body>
</html>
