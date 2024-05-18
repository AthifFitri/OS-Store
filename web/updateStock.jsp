<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Stock</title>
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
                    String StockID = request.getParameter("StockID");
                    String StockName = request.getParameter("StockName");
                    int StockQuantity = Integer.parseInt(request.getParameter("StockQuantity"));
                    double StockPrice = Double.parseDouble(request.getParameter("StockPrice"));

                    // Update the stock information in the database
                    String sql = "UPDATE stock SET StockName=?, StockQuantity=?, StockPrice=? WHERE StockID=?";
                    statement = conn.prepareStatement(sql);
                    statement.setString(1, StockName);
                    statement.setInt(2, StockQuantity);
                    statement.setDouble(3, StockPrice);
                    statement.setString(4, StockID);
                    int rowsAffected = statement.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("Stock information updated successfully!");

                        // Redirect back to the stock information page
                        response.sendRedirect("stockInfo.jsp");
                    } else {
                        out.println("Failed to update stock information.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("An error occurred while updating stock information.");
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
