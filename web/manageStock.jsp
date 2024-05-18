<%@ page import="java.text.DecimalFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .container {
                max-width: 400px;
                margin: 0 auto;
                text-align: center;
                background-color: #ffffff;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            h1 {
                font-size: 28px;
                color: #333333;
                margin-bottom: 20px;
            }

            label {
                display: block;
                text-align: left;
                margin-bottom: 10px;
                color: #555555;
                font-weight: bold;
            }

            input[type="text"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 12px;
                border: 1px solid #cccccc;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
                background-color: gainsboro;

            }

            input[type="text"]:focus {
                outline: none;
                border-color: #4CAF50;
            }

            input[type="number"]{
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 3px;
                box-sizing: border-box;
                margin-bottom: 10px;
                background-color: gainsboro;

            }

            button[type="submit"],
            button[type="button"] {
                background-color: #4CAF50;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 3px;
                cursor: pointer;
            }

            button[type="button"] {
                background-color: #ccc;
                margin-left: 10px;
            }
            body {
                background-image: url("image/orderbg.jpg");
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
            }
        </style>
        <title>Edit Stock Information</title>
        <link rel="stylesheet" type="text/css" href="css/information.css">
    <nav>
        <ul>
            <li class="logo">OS Store</li>
        </ul>
    </nav>
</head>
<body>
    <form action="updateStock.jsp" method="POST">

        <div class="container">
            <h1>Edit Stock Information</h1>
            <label for="StockID">Stock ID:</label>
            <%-- Display the productID value, not editable --%>
            <input type="text" id="StockID" name="StockID" value="<%= request.getParameter("StockID")%>" readonly>
            </br></br>
            <label for="StockName">Stock Name:</label>
            <input type="text" id="StockName" name="StockName" placeholder="Stock Name" value="<%= request.getParameter("StockName")%>">
            </br></br>
            <label for="StockQuantity">Stock Quantity:</label>
            <input type="number" id="StockQuantity" name="StockQuantity" placeholder="Stock Quantity" value="<%= request.getParameter("StockQuantity")%>">
            </br></br>
            <label for="StockPrice">Stock Price: RM</label>
            <input type="number" id="StockPrice" name="StockPrice" min="0.01" step="0.01" placeholder="Stock Price" value="<%= request.getParameter("StockPrice")%>">
            <br/>
            <br/>
            <button type="submit">Save</button>
            <button type="button" onclick="cancelEdit()">Cancel</button>
        </div>


    </form>

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
                String sql = "SELECT * FROM stock WHERE StockID=?";
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

    <script>
        function cancelEdit() {
            // Redirect back to the stock information page
            window.location.href = 'stockInfo.jsp';
        }
    </script>
</body>
</html>
