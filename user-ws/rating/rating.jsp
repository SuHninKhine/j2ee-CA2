<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dbaccess.Services" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Service Ratings</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .rating-stars {
            color: #FFD700; /* Gold color for stars */
        }
    </style>
</head>
<body>

    <div class="container mt-5">
        <h2 class="text-center mb-4">Service Ratings</h2>

        <!-- Filter Form -->
        <form action="<%=request.getContextPath()%>/ViewAllServiceRatingsServlet" method="GET" class="mb-4">
            <div class="row g-3">
                <div class="col-md-4">
                    <label for="filterType" class="form-label">Filter By:</label>
                    <select name="filterType" id="filterType" class="form-select" onchange="toggleMinRating()">
                        <option value="all">All Services</option>
                        <option value="highest">Highest Rated</option>
                        <option value="lowest">Lowest Rated</option>
                        <option value="rating">Rating X and Above</option>
                    </select>
                </div>

                <div class="col-md-4">
                    <label for="minRating" class="form-label">Minimum Rating:</label>
                    <select name="minRating" id="minRating" class="form-select" disabled>
                        <option value="1">1 ⭐ and Above</option>
                        <option value="2">2 ⭐ and Above</option>
                        <option value="3">3 ⭐ and Above</option>
                        <option value="4">4 ⭐ and Above</option>
                        <option value="5">5 ⭐ Only</option>
                    </select>
                </div>

                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Apply Filter</button>
                </div>
            </div>
        </form>

        <hr>

        <!-- Display Services -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Service Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Average Rating</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Services> servicesList = (List<Services>) request.getAttribute("servicesList");
                        if (servicesList != null && !servicesList.isEmpty()) {
                            for (Services service : servicesList) {
                    %>
                    <tr>
                        <td><%= service.getServiceName() %></td>
                        <td><%= service.getDescription() %></td>
                        <td>$<%= service.getPrice() %></td>
                        <td>
                            <span class="rating-stars">
                                <%= "⭐".repeat((int) service.getAvgRating()) %>
                            </span>
                            (<%= service.getAvgRating() %>)
                        </td>
                    </tr>
                    <%  
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-danger">No services found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS (for responsiveness) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function toggleMinRating() {
            var filterType = document.getElementById("filterType").value;
            var minRating = document.getElementById("minRating");

            // Enable minRating only if "Rating X and Above" is selected
            if (filterType === "rating") {
                minRating.removeAttribute("disabled");
            } else {
                minRating.setAttribute("disabled", "true");
            }
        }
    </script>

</body>
</html>
