<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services</title>
</head>
<body>
    <h1>All Services</h1>

    <!-- Filter Form -->
    <form action="FilterServiceServlet" method="GET">
        <label for="category">Category:</label>
        <select name="category" id="category">
            <option value="">Select Category</option>
            <c:forEach var="category" items="${categories}">
                <option value="${category.categoryId}">${category.categoryName}</option>
            </c:forEach>
        </select>
        
        <label for="service">Service:</label>
        <select name="service" id="service">
            <option value="">Select Service</option>
            <c:forEach var="service" items="${services}">
                <option value="${service.serviceId}">${service.serviceName}</option>
            </c:forEach>
        </select>

        <button type="submit">Filter</button>
    </form>

    <h2>Services List</h2>
    
    <!-- Check if services list is empty -->
    <c:if test="${empty services}">
        <p>No services found.</p>
    </c:if>

    <c:if test="${not empty services}">
        <table border="1">
            <thead>
                <tr>
                    <th>Service Name</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="service" items="${services}">
                    <tr>
                        <td>${service.serviceName}</td>
                        <td>${service.categoryName}</td>  <!-- Display category name -->
                        <td>
                            <!-- Add a link to view customers who booked this service -->
                            <a href="ViewCustomerServiceBookingServlet?serviceId=${service.serviceId}">View Customers</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>
