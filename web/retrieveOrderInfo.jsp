<%-- 
    Document   : retrieveStaffInfo
    Created on : 24 May 2023, 10:05:57 pm
    Author     : ariff
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/catalogue.css">
        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <style>
            body {
                background-image: url("https://png.pngtree.com/thumb_back/fh260/background/20200722/pngtree-background-for-school-tools-and-school-supplies-image_357880.jpg");
            }

            table {
                background-color: white;
            }

            .white{
                background-color: white;
            }
        </style>
    </head>
    <body>
        <nav>
            <ul>
                <li class="logo">OS Store</li>
                <li><a href="retrieveOrderInfo.jsp">Order Info</a></li>
                <li><a href="productManagement.jsp">Products</a></li>
                <li><a href="staffProfile.jsp">Account Information</a></li>
                <li><a href="staffLogin.jsp">Sign Out</a></li>
            </ul>
        </nav>
    <center>
        <h2 class="white">Here are all the orders made.....</h1>
            <table border="1">
                <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Payment Receipt</th>
                    <th>Payment Date</th>
                    <th>Payment Status</th>
                    <th>Action</th>
                    <th>Delete</th>
                </tr>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                        Statement ps = con.createStatement();
                        String str = "SELECT * FROM `order`";
                        ResultSet rs = ps.executeQuery(str);

                        while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("OrderID")%></td>
                    <td><%=rs.getString("CustID")%></td>
                    <td><%=rs.getString("PaymentReceipt")%></td>
                    <td><%=rs.getString("PaymentDate")%></td>
                    <td><%=rs.getString("PaymentStatus")%></td>
                    <td><a href="StaffController?action=edit&OrderID=<%=rs.getString("OrderID")%>">Update Status</a></td>
                    <td><a href="StaffController?action=delete&OrderID=<%=rs.getString("OrderID")%>">Delete</a></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {

                    }

                %>
            </table>
    </center>
</body>
</html>
