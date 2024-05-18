<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Staff</title>
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
                    String StaffID = request.getParameter("StaffID");
                    String StaffFirstName = request.getParameter("StaffFirstName");
                    String StaffLastName = request.getParameter("StaffLastName");
                    String StaffPhoneNumber = request.getParameter("StaffPhoneNumber");

                    // Update the staff information in the database
                    String sql = "UPDATE staff SET StaffFirstName=?, StaffLastName=?, StaffPhoneNumber=? WHERE StaffID=?";
                    statement = conn.prepareStatement(sql);
                    statement.setString(1, StaffFirstName);
                    statement.setString(2, StaffLastName);
                    statement.setString(3, StaffPhoneNumber);
                    statement.setString(4, StaffID);
                    int rowsAffected = statement.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("Staff information updated successfully!");

                        // Redirect back to the staff information page
                        response.sendRedirect("staffInfo.jsp");
                    } else {
                        out.println("Failed to update staff information.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("An error occurred while updating staff information.");
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
