<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <title>Order Stock</title>
        <link rel="stylesheet" type="text/css" href="css/order.css">
    <nav>
        <ul>
            <li class="logo">OS Store</li>
            <li><a href="managerProfile.jsp">Account Information</a></li>
            <li><a href="Login.jsp">Sign Out</a></li>
        </ul>
    </nav>
</head>
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

    .delivered-button i {
        margin: 2px;
    }

    .delivered-button:hover {
        background-color: #12E7B9;
    }

    body {
        background-image: url("image/orderbg.jpg");
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center;
        height: 822px;
    }

</style>
<body>
        <div class="container">
            <div class="header">
                <h1>Order Stock</h1>
            </div>
            <form action="placeOrder.jsp" method="POST">
                <label for="StockID">Stock Name:</label>
                <select id="StockID" name="StockID">
                    <%-- Retrieve product options from the "stock" table --%>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                            stmt = conn.createStatement();
                            String sql = "SELECT StockID, StockName FROM stock";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                String StockID = rs.getString("StockID");
                                String StockName = rs.getString("StockName");
                    %>
                    <option value="<%=StockID%>"><%=StockName%></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (stmt != null) {
                                    stmt.close();
                                }
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </select>
                <br>
                <label for="OrderQuantity">Order Quantity:</label>
                <input type="number" id="OrderQuantity" name="OrderQuantity" placeholder="Order Quantity" min="1" required>
                <br>

                <button type="submit">Order</button>
                <button type="reset">Cancel</button>
            </form>
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Stock Order ID</th>
                        <th>Stock ID</th>
                        <th>Stock Order Quantity</th>
                        <th>Arrival</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Retrieve ordered products from the "orderstock" table --%>
                    <%
                        PreparedStatement statement = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM stockorder";
                            rs = stmt.executeQuery(sql);

                            String deletestockorderID = request.getParameter("deletestockorderID");
                            if (deletestockorderID != null) {
                                // Delete the stock data from the database
                                String deleteSql = "DELETE FROM stockorder WHERE StockOrderID = ?";
                                statement = conn.prepareStatement(deleteSql);
                                statement.setString(1, deletestockorderID);
                                statement.executeUpdate();
                            }

                            int count = 1;
                            while (rs.next()) {
                                String StockOrderID = rs.getString("StockOrderID");
                                String StockID = rs.getString("StockID");
                                int OrderQuantity = rs.getInt("OrderQuantity");
                    %>
                    <tr>
                        <td><%=count++%></td>
                        <td><%=StockOrderID%></td>
                        <td><%=StockID%></td>
                        <td><%=OrderQuantity%></td>
                        <td>
                            <form action="" method="post">
                                <input type="hidden" name="deletestockorderID" value="<%=StockOrderID%>">
                                <button type="submit" class="delivered-button"><i class="fas fa-check"></i></button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (stmt != null) {
                                    stmt.close();
                                }
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
            <a href="stockInfo.jsp"><button type="button">Back</button></a>
            <button class="refresh-button" onclick="window.location.reload();"><i class="fas fa-sync-alt"></i></button>
        </div>
</body>
</html>
