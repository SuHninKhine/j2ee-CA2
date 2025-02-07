<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Services</title>
    <!-- Add Bootstrap for styling and modals -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<%@ include file="navbar.jsp" %>

<%
    if (session == null || session.getAttribute("username") == null || 
        !"admin".equalsIgnoreCase((String) session.getAttribute("user_role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>



<div class="container">
    <h1 class="my-4">Manage Services</h1>
    
        <%
    String message = request.getParameter("message");
		// Display message if available and then clear it
		if (message != null && !message.isEmpty()) {
		%>
		<div
			class="alert alert-success">
			<%=message%>
		</div>
		<%
		}
		%>
    
    <!-- Add Service Button -->
    <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#addServiceModal">Add New Service</button>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Service Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Category</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cleaning_service", "root", "1234");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM Services");
                    while (rs.next()) {
                        int serviceId = rs.getInt("service_id");
                        String serviceName = rs.getString("service_name");
                        String description = rs.getString("description");
                        BigDecimal price = rs.getBigDecimal("price");
                        int categoryId = rs.getInt("category_id");

                        // Fetch category name based on category_id
                        PreparedStatement ps = conn.prepareStatement("SELECT category_name FROM Service_Categories WHERE category_id = ?");
                        ps.setInt(1, categoryId);
                        ResultSet categoryRs = ps.executeQuery();
                        String categoryName = "";
                        if (categoryRs.next()) {
                            categoryName = categoryRs.getString("category_name");
                        }
            %>
            <tr>
                <td><%= serviceName %></td>
                <td><%= description %></td>
                <td><%= price %></td>
                <td><%= categoryName %></td>
                <td>
                    <!-- Edit Button -->
                    <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#editServiceModal" 
                            data-id="<%= serviceId %>" data-name="<%= serviceName %>" 
                            data-description="<%= description %>" data-price="<%= price %>" 
                            data-category="<%= categoryId %>">Edit</button>
                    
                    <!-- Delete Button -->
                    <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteServiceModal" 
                            data-id="<%= serviceId %>">Delete</button>
                </td>
            </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>

<!-- Add Service Modal -->
<div class="modal fade" id="addServiceModal" tabindex="-1" aria-labelledby="addServiceModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="addService.jsp" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addServiceModalLabel">Add Service</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="serviceName">Service Name</label>
                        <input type="text" class="form-control" id="serviceName" name="serviceName" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                    </div>
                    <div class="form-group">
                        <label for="category">Category</label>
                        <select class="form-control" id="category" name="categoryId" required>
                            <option value="">Select Category</option>
                            <% 
                                try {
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cleaning_service", "root", "1234");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM Service_Categories");
                                    while (rs.next()) {
                                        int categoryId = rs.getInt("category_id");
                                        String categoryName = rs.getString("category_name");
                            %>
                            <option value="<%= categoryId %>"><%= categoryName %></option>
                            <% 
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Add Service</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Edit Service Modal -->
<div class="modal fade" id="editServiceModal" tabindex="-1" aria-labelledby="editServiceModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="updateService.jsp" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editServiceModalLabel">Edit Service</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editServiceName">Service Name</label>
                        <input type="text" class="form-control" id="editServiceName" name="serviceName" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Description</label>
                        <textarea class="form-control" id="editDescription" name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="editPrice">Price</label>
                        <input type="number" step="0.01" class="form-control" id="editPrice" name="price" required>
                    </div>
                    <div class="form-group">
                        <label for="editCategory">Category</label>
                        <select class="form-control" id="editCategory" name="categoryId" required>
                            <option value="">Select Category</option>
                            <% 
                                try {
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cleaning_service", "root", "1234");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM Service_Categories");
                                    while (rs.next()) {
                                        int categoryId = rs.getInt("category_id");
                                        String categoryName = rs.getString("category_name");
                            %>
                            <option value="<%= categoryId %>"><%= categoryName %></option>
                            <% 
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                    </div>
                    <input type="hidden" id="editServiceId" name="serviceId" value="">
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Delete Service Modal -->
<div class="modal fade" id="deleteServiceModal" tabindex="-1" aria-labelledby="deleteServiceModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteServiceModalLabel">Delete Service</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this service?</p>
                <form action="deleteService.jsp" method="get">
                    <input type="hidden" id="deleteServiceId" name="serviceId" value="">
                    <button type="submit" class="btn btn-danger">Delete</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript to handle modal data population -->
<script>
    $('#editServiceModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var serviceId = button.data('id');
        var serviceName = button.data('name');
        var description = button.data('description');
        var price = button.data('price');
        var categoryId = button.data('category');

        var modal = $(this);
        modal.find('#editServiceId').val(serviceId);
        modal.find('#editServiceName').val(serviceName);
        modal.find('#editDescription').val(description);
        modal.find('#editPrice').val(price);
        modal.find('#editCategory').val(categoryId);
    });

    $('#deleteServiceModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var serviceId = button.data('id');
        
        var modal = $(this);
        modal.find('#deleteServiceId').val(serviceId);
    });
</script>

<%@ include file="footer.jsp" %>


</body>
</html>
