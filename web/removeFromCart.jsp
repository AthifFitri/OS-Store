<%-- 
    Document   : removeFromCart
    Created on : 15 Jun 2023, 10:33:39 pm
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="OSS.CartDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove from Cart</title>
    </head>
    <body>
        <%
            CartDAO cartDAO = new CartDAO();
            String productId = request.getParameter("productId");

            cartDAO.removeFromCart(productId);

            // Redirect back to the cart page (catalogue.jsp) or any other desired page
            response.sendRedirect("catalogue.jsp");
        %>
    </body>
</html>
