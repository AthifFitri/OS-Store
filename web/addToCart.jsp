<%-- 
    Document   : addToCart
    Created on : 15 Jun 2023, 10:31:56 pm
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.math.BigDecimal" %>
<%@page import="OSS.CartDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add to Cart</title>
    </head>
    <body>
        <%
            CartDAO cartDAO = new CartDAO();
            String productId = request.getParameter("productId");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String customerId = request.getParameter("customerID");

            cartDAO.addToCart(productId, quantity, price, customerId);

            // Redirect back to the product catalog page or any other desired page
            response.sendRedirect("catalogue.jsp");
        %>
    </body>
</html>
