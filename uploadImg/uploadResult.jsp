<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Result</title>
</head>
<body>
    <h2>Upload Status</h2>
    <p><%= request.getAttribute("message") %></p>
    
    <a href="uploadServiceImage.jsp">Upload Another Image</a>
</body>
</html>
