<%@ page import="java.util.List, dbaccess.Bookings" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
    <title>View Bookings</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f4f4f4; }
    </style>
</head>
<body>
    <h2>Cleaning Service Bookings</h2>
    
<form action="<%=request.getContextPath()%>/ViewBookingsServlet" method="get">
    <label for="filterType">Filter By:</label>
    <select name="filterType" id="filterType" required>
        <option value="date">Date</option>
        <option value="month">Month</option>
        <option value="year">Year</option>  <!-- New option -->
        <option value="period">Period</option>
    </select>

    <div id="dateFilter">
        <label for="date">Select Date:</label>
        <input type="date" name="date">
    </div>

    <div id="monthFilter" style="display: none;">
        <label for="year">Year:</label>
        <input type="number" name="year" min="2020" max="2030">
        <label for="month">Month:</label>
        <input type="number" name="month" min="1" max="12">
    </div>

    <div id="yearFilter" style="display: none;">  <!-- New year filter -->
        <label for="yearOnly">Year:</label>
        <input type="number" name="yearOnly" min="2020" max="2030">
    </div>

    <div id="periodFilter" style="display: none;">
        <label for="period">Select Period:</label>
        <select name="period">
            <option value="morning">Morning (6 AM - 11 AM)</option>
            <option value="afternoon">Afternoon (12 PM - 5 PM)</option>
            <option value="evening">Evening (6 PM - 11 PM)</option>
        </select>
    </div>

    <button type="submit">Search</button>
</form>

<script>
    document.getElementById("filterType").addEventListener("change", function() {
        let filter = this.value;
        document.getElementById("dateFilter").style.display = filter === "date" ? "block" : "none";
        document.getElementById("monthFilter").style.display = filter === "month" ? "block" : "none";
        document.getElementById("yearFilter").style.display = filter === "year" ? "block" : "none";
        document.getElementById("periodFilter").style.display = filter === "period" ? "block" : "none";
    });
</script>


    <%
        List<Bookings> bookings = (List<Bookings>) request.getAttribute("bookings");
        if (bookings != null && !bookings.isEmpty()) {
    %>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>User ID</th>
                <th>Service ID</th>
                <th>Appointment Date</th>
                <th>Special Requests</th>
                <th>Status</th>
                <th>Address</th>
            </tr>
            <%
                for (Bookings booking : bookings) {
            %>
                <tr>
                    <td><%= booking.getBookingId() %></td>
                    <td><%= booking.getUserId() %></td>
                    <td><%= booking.getServiceId() %></td>
                    <td><%= booking.getAppointmentDate() %></td>
                    <td><%= booking.getSpecialRequests() %></td>
                    <td><%= booking.getStatus() %></td>
                    <td><%= booking.getAddress() %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>No bookings found.</p>
    <% } %>
</body>
</html>
