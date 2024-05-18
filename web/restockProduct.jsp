<%-- 
    Document   : restockProduct
    Created on : 2 Jul 2023, 11:25:46 am
    Author     : ariff
--%>

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
    </head>
    <style>
        body {
            background-image: url("https://png.pngtree.com/thumb_back/fh260/background/20200722/pngtree-background-for-school-tools-and-school-supplies-image_357880.jpg");
        }

        table {
            background-color: white;
        }

        .white{
            background-color: white;
            width: 50%;
        }

        fieldset{
            width: 50%;
            background-color: white;
        }
    </style>
    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
            String ProductID = request.getParameter("ProductID");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM `product` WHERE ProductID=?");
            ps.setString(1, ProductID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
        %>

    <center>
        <h1 class="white">Enter Amount to Restock</h1>
        <form action="StaffController" method="post">
            <fieldset>
                <table>
                    <tr>
                        <td>Product ID: </td>
                        <td><input type="text" id="pID" name="pID" readonly="readonly" value="<%=rs.getString("ProductID")%>"></td>
                    </tr>
                    <tr>
                        <td>Restock Amount: </td>
                        <td><input type="number" id="rAmount" name="rAmount" required="required" placeholder="<%=rs.getInt("ProductStock")%>"></td>
                    </tr>
                    <tr>
                        <td><input type="hidden" name="action" value="restock"></td>
                    </tr>
                </table>
                <input type="submit" value="Submit">
            </fieldset>
        </form>
    </center>
    <%
        }
    %>
</body>
</html>