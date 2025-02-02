<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Service Image</title>
</head>
<body>
    <h2>Upload Service Image</h2>
    
    <form action="<%=request.getContextPath()%>/uploadServiceImage" method="post" enctype="multipart/form-data">
        <label for="serviceId">Service ID:</label>
        <input type="number" name="serviceId" required><br><br>

        <label for="serviceImage">Select Image:</label>
        <input type="file" name="serviceImage" accept="image/*" required><br><br>

        <input type="submit" value="Upload">
    </form>
</body>
</html>
