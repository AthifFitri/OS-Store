<%-- 
    Document   : checkout
    Created on : 15 Jun 2023, 10:27:43 pm
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="OSS.CartDAO"%>
<%@page import="OSS.Cart"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/checkout.css">
    </head>
    <body>
        <!-- navigation bar -->
        <nav>
            <ul>
                <li class="logo">OS Store</li>

                <li><a href="catalogue.jsp">Catalogue</a></li>
                <li class="dropdown">
                    <a href="#">My Account</a>
                    <ul class="dropdown-content">
                        <li><a href="customerProfile.jsp">Account Information</a></li>
                    </ul>
                </li>
                <li><a href="customerLogin.jsp">Sign Out</a></li>
            </ul>
        </nav><br>

        <!-- content -->
        <h1 style="text-align: center">Payment</h1><br>

        <div class='container'>
            <div class='window'>
                <div class='order-info'>
                    <div class='order-info-content'>
                        <!--Display order summary-->
                        <h2>Order Summary</h2>
                        <div class='line'></div>

                        <%-- Retrieve and display cart items --%>
                        <%
                            CartDAO cartDAO = new CartDAO();
                            String customerId = (String) session.getAttribute("CustID");
                            List<Cart> cartItems = cartDAO.getCartItems();
                            Map<String, Cart> mergedItems = new HashMap<>();

                            // Merge duplicate products and sum their quantities
                            for (Cart cartItem : cartItems) {
                                if (mergedItems.containsKey(cartItem.getProductId())) {
                                    Cart existingItem = mergedItems.get(cartItem.getProductId());
                                    existingItem.setOrderQuantity(existingItem.getOrderQuantity() + cartItem.getOrderQuantity());
                                    existingItem.setOrderPrice(existingItem.getOrderPrice().add(cartItem.getOrderPrice()));
                                } else {
                                    mergedItems.put(cartItem.getProductId(), cartItem);
                                }
                            }

                            // Display merged items
                            for (Cart cartItem : mergedItems.values()) {
                        %>
                        <table class='order-table'>
                            <tbody>
                                <tr>
                                    <td>
                                        <br> <span class='thin'><%= cartItem.getProductName()%></span>
                                        <br><span class='thin small'>Product ID: <%= cartItem.getProductId()%><br><br></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <p class="qty">Quantity: <%= cartItem.getOrderQuantity()%></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class='price'>RM <%= cartItem.getOrderPrice()%></div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class='line'></div>
                        <%
                            }
                        %>


                        <!--Display total price-->
                        <div class='total'>
                            <span style='float:left;'>TOTAL</span>
                            <span style='float:right; text-align:right;'>RM <%= cartDAO.calculateTotalPrice()%></span>
                        </div>
                    </div>
                </div>
                <div class='payment'>
                    <div class='payment-content'>
                        <div class='half-input-table'>
                            <br>
                            <p>ONLINE TRANSFER</p>
                            <img src="image/onlineTransfer.jpg" alt="onlineTransfer"><br><br>

                            <p>QR CODE</p>
                            <img src="image/QrCode.jpg" alt="QrCode">
                        </div><br>

                        <form action="${pageContext.request.contextPath}/UploadServlet" method="post" enctype="multipart/form-data">
                            Submit Your receipt here:
                            <input type="file" class='input-field' name="paymentReceipt" id="paymentReceipt"><br><br><br><br>

                            <button type="submit" name="checkoutBtn" class='pay-btn'>Place Order</button>
                        </form>
                    </div>
                </div>
            </div>
        </div><br>
    </body>
</html>
