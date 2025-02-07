<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@page import="java.util.List"%>
<%@page import="dbaccess.Services"%>
<%@page import="dbaccess.ServiceCategories"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service List</title>

    <!-- Bootstrap CSS (CDN) -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .top-left { position: absolute; top: 10px; left: 10px; }
        .service-card { margin-bottom: 20px; }
        .service-card img { max-height: 200px; object-fit: cover; }
        .main-container {margin-top:70px}
    </style>
</head>
<body>
    <div class="container">
        <!-- Category Filter Form (Top-Left Corner) -->
        <form action="<%= request.getContextPath() %>/GetServicesByCategory" method="GET" class="top-left mb-4">
            <label for="category">Choose a Category:</label>
            <select name="categoryId" id="category" class="form-control w-auto d-inline-block">
                <option value="">All Services</option>
                <%
                    // Declare only once
                    List<ServiceCategories> categories = (List<ServiceCategories>) request.getAttribute("categories");

                    String selectedCategoryId = (String) request.getAttribute("selectedCategoryId");

                    if (categories != null && !categories.isEmpty()) {
                        for (ServiceCategories category : categories) {
                            String selected = (selectedCategoryId != null && selectedCategoryId.equals(String.valueOf(category.getCategoryId()))) ? "selected" : "";
                            out.print("<option value='" + category.getCategoryId() + "' " + selected + ">" + category.getCategoryName() + "</option>");
                        }
                    }
                %>
            </select>
            <input type="submit" value="Filter" class="btn btn-primary ml-2">
            <button type="button" onclick="window.location.href='<%= request.getContextPath() %>/GetServiceCategories'" class="btn btn-secondary ml-2">Reset</button>
        </form>

        <!-- Display the selected category in heading -->
        <%
            // Declare category name and logic to display category name based on selectedCategoryId
            String categoryName = "All Services"; // Default message if no category is selected

            if (selectedCategoryId != null && !selectedCategoryId.isEmpty() && categories != null) {
                for (ServiceCategories category : categories) {
                    if (category.getCategoryId() == Integer.parseInt(selectedCategoryId)) {
                        categoryName = category.getCategoryName();
                        break; // No need to loop further once category is found
                    }
                }
            }
        %>



        <div class="row main-container">
            <h3 class="col-12 mb-4">Available Services</h3>
            <%
                // Show the list of services
                List<Services> services = (List<Services>) request.getAttribute("servicesList");
                if (services != null && !services.isEmpty()) {
                    for (Services service : services) {
            %>
                <div class="col-md-4">
                    <div class="card service-card">
                        <div class="card-body">
                            <h5 class="card-title"><%= service.getServiceName() %></h5>
                            <p class="card-text"><%= service.getDescription() %></p>
                            <p class="card-text"><strong>Price:</strong> $<%= service.getPrice() %></p>
                            <a href="#" class="btn btn-primary">More Info</a>
                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="col-12">
                    <p>No services found.</p>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Bootstrap JS (CDN) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
