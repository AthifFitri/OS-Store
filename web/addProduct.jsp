<%-- 
    Document   : addProduct
    Created on : 15 Jun 2023, 11:08:36 am
    Author     : ariff
--%>

<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="jdk.jpackage.internal.IOUtils"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
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
            width: 60%;
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
        <h1 class="white"><b>Add Image</b></h1>
        <form action="ImageUpload" method="POST" enctype="multipart/form-data">
            <fieldset>
                <table>
                    <tr>
                        <td>Product ID:</td>
                        <td><input type="text" readonly name="ProductID" value="<%=rs.getString("ProductID")%>"></td>
                    </tr>
                    <tr>
                        <td>Product Image:</td>
                        <td><input type="file" accept="image/jpeg" name="ProductImage"></td>
                    </tr>
                </table>
                <input type="submit" name="SubmitButton" value="Submit">
            </fieldset>
        </form>
    </center>
    <%
        }
    %>
</body>
</html>
