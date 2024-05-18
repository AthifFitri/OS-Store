<%-- 
    Document   : recordSales
    Created on : 2 Jul 2023, 2:05:17 am
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.math.BigDecimal"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Record Sales</title>
    </head>
    <body>
        <%
            String[] productIds = request.getParameterValues("productId");
            String[] salesQuantities = request.getParameterValues("salesQuantity");
            String[] totalSalesValues = request.getParameterValues("totalSales");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");

                String selectQuery = "SELECT * FROM sales WHERE ProductID = ?";
                PreparedStatement selectStmt = conn.prepareStatement(selectQuery);

                String insertQuery = "INSERT INTO sales (ProductID, SalesQuantity, TotalSales) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);

                String updateQuery = "UPDATE sales SET SalesQuantity = SalesQuantity + ?, TotalSales = TotalSales + ? WHERE ProductID = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);

                for (int i = 0; i < productIds.length; i++) {
                    String productId = productIds[i];
                    int salesQuantity = Integer.parseInt(salesQuantities[i]);
                    BigDecimal totalSales = new BigDecimal(totalSalesValues[i]);

                    selectStmt.setString(1, productId);
                    ResultSet resultSet = selectStmt.executeQuery();

                    if (resultSet.next()) {
                        updateStmt.setInt(1, salesQuantity);
                        updateStmt.setBigDecimal(2, totalSales);
                        updateStmt.setString(3, productId);
                        updateStmt.executeUpdate();
                    } else {
                        insertStmt.setString(1, productId);
                        insertStmt.setInt(2, salesQuantity);
                        insertStmt.setBigDecimal(3, totalSales);
                        insertStmt.executeUpdate();
                    }

                    resultSet.close();
                }

                selectStmt.close();
                insertStmt.close();
                updateStmt.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            } finally {
                if (pstmt != null) {
                    try {
                        pstmt.close();
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

            response.sendRedirect("checkout.jsp");
        %>
    </body>
</html>
