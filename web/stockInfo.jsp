<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <style>
            .refresh-button {
                position: fixed;
                top: 10px;
                right: 10px;
                padding: 8px;
                background-color: transparent;
                border: none;
                cursor: pointer;
                font-size: 20px;
                color: #333;
            }
            .edit-button {
                background-color: transparent;
                color: black;
                border: none;
                padding: 5px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                cursor: pointer;
            }
            .edit-button i {
                margin-right: 5px;
            }
            .delete-button:hover{
                background-color: red;
            }
            body {
                background-image: url("image/orderbg.jpg");
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
            }

        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <title>Stock Information</title>
        <link rel="stylesheet" type="text/css" href="css/information.css">

    <nav>
        <ul>
            <li class="logo">OS Store</li>
            <li><a href="managerProfile.jsp">Account Information</a></li>
            <li><a href="managerLogin.jsp">Sign Out</a></li>
        </ul>
    </nav>
</head>

<body>
    <div class="bg-img">
        <div class="container">
            <div class="header">
                <h1>Store Stock Information</h1>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Stock ID</th>
                        <th>Stock Name</th>
                        <th>Stock Quantity</th>
                        <th>Stock Price</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement statement = null;
                        ResultSet resultSet = null;
                        try {
                            // Database connection parameters
                            String dbUrl = "jdbc:mysql://localhost:3306/ossystem";
                            String dbUsername = "root";
                            String dbPassword = "admin";

                            // Create a connection to the database
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                            // Retrieve stock data from the database
                            String sql = "SELECT * FROM stock";
                            statement = conn.prepareStatement(sql);
                            resultSet = statement.executeQuery();

                            // Check if a delete request has been made
                            String deleteProductID = request.getParameter("deleteProductID");
                            if (deleteProductID != null) {
                                // Delete the stock data from the database
                                String deleteSql = "DELETE FROM stock WHERE StockID = ?";
                                statement = conn.prepareStatement(deleteSql);
                                statement.setString(1, deleteProductID);
                                statement.executeUpdate();
                            }

                            // Iterate through the result set and display stock data
                            while (resultSet.next()) {
                                String StockID = resultSet.getString("StockID");
                                String StockName = resultSet.getString("StockName");
                                int StockQuantity = resultSet.getInt("StockQuantity");
                                double StockPrice = resultSet.getDouble("StockPrice");
                    %>
                    <tr>
                        <td><%=StockID%></td>
                        <td><%=StockName%></td>
                        <td><%=StockQuantity%></td>
                        <td>RM<%=String.format("%.2f", StockPrice)%></td>
                        <td><a href="manageStock.jsp?StockID=<%=StockID%>&StockName=<%=StockName%>&StockQuantity=<%=StockQuantity%>&StockPrice=<%=StockPrice%>" class="edit-button"><i class="fas fa-pencil-alt"></i></a></td>
                        <td>
                            <form action="" method="post">
                                <input type="hidden" name="deleteProductID" value="<%=StockID%>">
                                <button type="submit" class="delete-button"><i class="fas fa-trash-alt"></i></button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("An error occurred while retrieving stock data.");
                        } finally {
                            // Close the database resources
                            if (resultSet != null) {
                                try {
                                    resultSet.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
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
                    %>
                </tbody>
            </table>
            <a href="managerProfile.jsp"><button type="button">Back</button></a>
            <a href="addStock.jsp"><button type="button">Add New Stock</button></a>
            <a href="orderStock.jsp"><button type="button">Order Stock</button></a>
            <button class="refresh-button" onclick="window.location.reload();"><i class="fas fa-sync-alt"></i></button>
        </div>
    </div>
</body>
</html>