<%-- 
    Document   : updateManager
    Created on : 3 Jul 2023, 11:25:18 pm
    Author     : User
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Manager Information</title>
</head>
<body>
    <%
        if (request.getMethod().equals("POST")) {
            Connection conn = null;
            PreparedStatement statement = null;
            try {
                // Database connection parameters
                String dbUrl = "jdbc:mysql://localhost:3306/ossystem";
                String dbUsername = "root";
                String dbPassword = "admin";

                // Create a connection to the database
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                // Get the form data
                String ManagerID = request.getParameter("ManagerID");
                String ManagerFirstName = request.getParameter("ManagerFirstName");
                String ManagerLastName = request.getParameter("ManagerLastName");
                String ManagerPhoneNumber = request.getParameter("ManagerPhoneNumber");

                // Update the manager information in the database
                String sql = "UPDATE storemanager SET ManagerFirstName = ?, ManagerLastName = ?, ManagerPhoneNumber = ? WHERE ManagerID = ?";
                statement = conn.prepareStatement(sql);
                statement.setString(1, ManagerFirstName);
                statement.setString(2, ManagerLastName);
                statement.setString(3, ManagerPhoneNumber);
                statement.setString(4, ManagerID);
                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("Manager information updated successfully!");

                    // Redirect back to the manager information page
                    response.sendRedirect("staffInfo.jsp");
                } else {
                    out.println("Failed to update manager information.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("An error occurred while updating manager information.");
            } finally {
                // Close the database resources
                if (statement != null) {
                    try {
                        statement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>
</body>
</html>


