<%-- 
    Document   : statusUpdatePage
    Created on : 16 Jun 2023, 10:28:56 am
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
            String OrderID = request.getParameter("OrderID");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM `order` WHERE OrderID=?");
            ps.setString(1, OrderID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
        %>
    <center>
        <h1 class="white">Confirm the order here</h1>
        <form action="StaffController" method="post">
            <fieldset>
                <table>
                    <tr>
                        <td>Order ID: </td>
                        <td><input type="text" id="oID" name="oID" readonly="readonly" value="<%=rs.getString("OrderID")%>"></td>
                    </tr>
                    <tr>
                        <td>Status: </td>
                        <td><select name="Pstatus">
                                <option value="Pending">Pending</option>
                                <option value="Confirmed">Confirmed</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="hidden" name="action" value="status"></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Submit"></td>
                    </tr>
                </table>
            </fieldset>
        </form>
    </center>
    <%
        }
    %>
</body>
</html>
