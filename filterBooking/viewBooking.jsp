<%@ page import="java.util.List, dbaccess.Bookings" %> 
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            padding-top: 20px;
        }
        .form-container {
            margin-top: 20px;
        }
        .table-container {
            margin-top: 30px;
        }
        .filter-section {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mb-4 text-center">Cleaning Service Bookings</h2>
        
        <!-- Filter Form -->
        <form action="<%=request.getContextPath()%>/ViewBookingsServlet" method="get" class="form-container">
            <div class="row">
                <div class="col-md-4">
                    <label for="filterType">Filter By:</label>
                    <select name="filterType" id="filterType" class="form-select" required>
                        <option value="date">Date</option>
                        <option value="month">Month</option>
                        <option value="year">Year</option>
                        <option value="period">Period</option>
                    </select>
                </div>
            </div>

            <!-- Date Filter -->
            <div id="dateFilter" class="filter-section">
                <label for="date">Select Date:</label>
                <input type="date" name="date" class="form-control">
            </div>

            <!-- Month Filter -->
            <div id="monthFilter" class="filter-section" style="display: none;">
                <label for="year">Year:</label>
                <input type="number" name="year" min="2020" max="2030" class="form-control">
                <label for="month">Month:</label>
                <input type="number" name="month" min="1" max="12" class="form-control">
            </div>

            <!-- Year Filter -->
            <div id="yearFilter" class="filter-section" style="display: none;">
                <label for="yearOnly">Year:</label>
                <input type="number" name="yearOnly" min="2020" max="2030" class="form-control">
            </div>

            <!-- Period Filter -->
            <div id="periodFilter" class="filter-section" style="display: none;">
                <label for="period">Select Period:</label>
                <select name="period" class="form-select">
                    <option value="morning">Morning (6 AM - 11 AM)</option>
                    <option value="afternoon">Afternoon (12 PM - 5 PM)</option>
                    <option value="evening">Evening (6 PM - 11 PM)</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary mt-3">Search</button>
        </form>

        <!-- Display Bookings Table -->
        <%
            List<Bookings> bookings = (List<Bookings>) request.getAttribute("bookings");
            if (bookings != null && !bookings.isEmpty()) {
        %>
        <div class="table-container">
            <table class="table table-bordered table-striped">
                <thead class="table-light">
                   <tr>
                    <th>Booking ID</th>
                    <th>Customer Name</th>
                    <th>Service Name</th>
                    <th>Appointment Date</th>
                    <th>Special Requests</th>
                    <th>Status</th>
                    <th>Address</th>
                </tr>
                </thead>
                <tbody>
                    <%
                        for (Bookings booking : bookings) {
                    %>
                     <tr>
                        <td><%= booking.getBookingId() %></td>
                        <td><%= booking.getUsername() %></td> <!-- Display username -->
                        <td><%= booking.getServiceName() %></td> <!-- Display service name -->
                        <td><%= booking.getAppointmentDate() %></td>
                        <td><%= booking.getSpecialRequests() %></td>
                        <td><%= booking.getStatus() %></td>
                        <td><%= booking.getAddress() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p class="alert alert-warning">No bookings found.</p>
        <% } %>
    </div>

    <!-- Bootstrap JS and Popper.js (for dropdowns, modals, etc.) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

    <script>
        // Toggle filter visibility based on selected filter type
        document.getElementById("filterType").addEventListener("change", function() {
            let filter = this.value;
            document.getElementById("dateFilter").style.display = filter === "date" ? "block" : "none";
            document.getElementById("monthFilter").style.display = filter === "month" ? "block" : "none";
            document.getElementById("yearFilter").style.display = filter === "year" ? "block" : "none";
            document.getElementById("periodFilter").style.display = filter === "period" ? "block" : "none";
        });
    </script>
</body>
</html>
