<%@page import="java.sql.*" %>
<%
    // Establish a connection to the database
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
        stmt = conn.createStatement();

        String query = "SELECT s.ProductID, p.ProductName, s.SalesQuantity, s.TotalSales "
                + "FROM sales s "
                + "JOIN product p ON s.ProductID = p.ProductID";
        rs = stmt.executeQuery(query);
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sales Report</title>
        <link rel="stylesheet" type="text/css" href="css/information.css">

    <nav>
        <ul>
            <li class="logo">OS Store</li>
            <li><a href="managerProfile.jsp">Account Information</a></li>
            <li><a href="managerLogin.jsp">Sign Out</a></li>
        </ul>
    </nav>
</head>
<style>
    body {
                background-image: url("image/orderbg.jpg");
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
            }
</style>
<body>
    <div class="bg-img">
        <div class="container">
            <div class="header">
                <h1>Sales Report</h1>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Product Name</th>
                        <th>Quantity Sold</th>
                        <th>Total Sales</th>
                    </tr>
                </thead>
                <tbody>

                    <%
                        int count = 1;
                        while (rs.next()) {
                            String productName = rs.getString("ProductName");
                            int salesQuantity = rs.getInt("SalesQuantity");
                            double totalSales = rs.getDouble("TotalSales");
                    %>
                    <tr>
                        <td><%= count++%></td>
                        <td><%= productName%></td>
                        <td><%= salesQuantity%></td>
                        <td>RM <%= totalSales%></td>
                    </tr>
                    <%
                        }
                    %>

                </tbody>
            </table>
            <button type="button" onclick="backPage()">Back</button>
        </div>
    </div>

    <script>
        function backPage() {
            // Redirect back to the stock.html page
            window.location.href = 'managerProfile.jsp';
        }
    </script>
</body>
</html>
<%
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>