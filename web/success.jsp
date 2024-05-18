<%-- 
    Document   : success
    Created on : 15 Jun 2023, 10:30:11 pm
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="OSS.OrderDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Success</title>
        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/success.css">
    </head>
    <body>
        <!-- navigation bar -->
        <nav>
            <ul>
                <li class="logo">OS Store</li>

                <li class="dropdown">
                    <a href="#">My Account</a>
                    <ul class="dropdown-content">
                        <li><a href="customerProfile.jsp">Account Information</a></li>
                    </ul>
                </li>
                <li><a href="customerLogin.jsp">Sign Out</a></li>
            </ul>
        </nav>
        <br /><br /><br />

        <!-- content -->
        <div class="container">
            <div class="window">
                <%
                    String customerID = (String) session.getAttribute("CustID");
                    java.util.Date utilPaymentDate = new java.util.Date();
                    java.sql.Date paymentDate = new java.sql.Date(utilPaymentDate.getTime());

                    // Get the file name from the request attributes
                    String fileName = (String) request.getAttribute("fileName");

                    OrderDAO orderDAO = new OrderDAO();
                    orderDAO.createOrder(customerID, paymentDate, fileName);
                %>
                <h2>Your order has been received</h2>

                <i class="fa-sharp fa-solid fa-circle-check fa-5x"></i>

                <p>
                    Thank you for your purchase! <br />
                    You will receive an order confirmation via sms with details of your order
                </p>

                <a href="catalogue.jsp?clearCart=true" type="button" class="btn">CONTINUE SHOPPING</a>
            </div>
        </div>
    </body>
</html>
