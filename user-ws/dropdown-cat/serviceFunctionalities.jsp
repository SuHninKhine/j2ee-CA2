<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@page import="java.util.List"%>
<%@page import="dbaccess.Services"%>
<%@page import="dbaccess.ServiceCategories"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service List</title>
</head>
<body>
    <h2>All Services</h2>

    <!-- Category Filter Form -->
    <form action="<%= request.getContextPath() %>/GetServicesByCategory" method="GET">
        <label for="category">Choose a Category:</label>
      <select name="categoryId" id="category">
    <%
        String selectedCategoryId = (String) request.getAttribute("selectedCategoryId");
        List<ServiceCategories> categories = (List<ServiceCategories>) request.getAttribute("categories");

        if (categories != null && !categories.isEmpty()) {
            for (ServiceCategories category : categories) {
                String selected = (selectedCategoryId != null && selectedCategoryId.equals(String.valueOf(category.getCategoryId()))) ? "selected" : "";
                out.print("<option value='" + category.getCategoryId() + "' " + selected + ">" + category.getCategoryName() + "</option>");
            }
        } else {
            out.print("<option value=''>No categories available</option>");
        }
    %>
</select>

        <input type="submit" value="Filter Services">
    </form>

    <h3>Available Services</h3>
    <%
        List<Services> services = (List<Services>) request.getAttribute("servicesList");
        if (services != null && !services.isEmpty()) {
            for (Services service : services) {
                out.print("<p><strong>Service Name:</strong> " + service.getServiceName() + "</p>");
                out.print("<p><strong>Description:</strong> " + service.getDescription() + "</p>");
                out.print("<p><strong>Price:</strong> $" + service.getPrice() + "</p>");
                out.print("<hr>");
            }
        } else {
            out.print("<p>No services found.</p>");
        }
    %>
</body>
</html>
