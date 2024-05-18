<%-- 
    Document   : productManagement
    Created on : 13 Jun 2023, 6:38:10 pm
    Author     : ariff
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="OSS.Product"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/catalogue.css">
        <script src="catalogue.js"></script>
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
        <h2 class="white">PRODUCTS</h1>
        <table border="1">
            <tr>
                <th>Product ID</th>
                <th>Product Image</th>
                <th>Product Name</th>
                <th>Product Category</th>
                <th>Product Quantity</th>
                <th>Product Price</th>
                <th>Product Description</th>
                <th>Image Insertion</th>
                <th>Restock</th>
                <th>Delete</th>
            </tr>
            <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                    Statement ps = con.createStatement();
                    String str = "SELECT * FROM `product`";
                    ResultSet rs = ps.executeQuery(str);

                     while (rs.next()) {
                        // Set the productImageBase64 attribute with the base64 encoded image data from the result set
                        Product product = new Product();
                        Blob productImageBlob = rs.getBlob("ProductImage");
                        byte[] productImageBytes = productImageBlob.getBytes(1, (int) productImageBlob.length());
                        product.setProductImageBase64(Base64.getEncoder().encodeToString(productImageBytes));
                %>
                <tr>
                    <td><%=rs.getString("ProductID")%></td>
                    <td><img src="data:image/png;base64, <%= product.getProductImageBase64()%>" /></td>
                    <td><%=rs.getString("ProductName")%></td>
                    <td><%=rs.getString("ProductCategory")%></td>
                    <td><%=rs.getInt("ProductStock")%></td>
                    <td><%=rs.getBigDecimal("ProductPrice")%></td>
                    <td><%=rs.getString("ProductDesc")%></td>
                    <td><a href="StaffController?action=addImage&ProductID=<%=rs.getString("ProductID")%>">Click to add Image</a></td>
                    <td><a href="StaffController?action=restock&ProductID=<%=rs.getString("ProductID")%>">Restock</a></td>
                    <td><a href="StaffController?action=deleteProduct&ProductID=<%=rs.getString("ProductID")%>">Delete</a></td>
                </tr>
                <%
                    }
                %>

            </table>
            <button><a href="addAProduct.jsp">Add New Product</a></button>
    </center>
</body>
</html>

