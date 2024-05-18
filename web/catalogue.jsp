<%-- 
    Document   : catalogue
    Created on : 15 Jun 2023, 10:23:42 pm
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="OSS.Product"%>
<%@page import="OSS.Cart"%>
<%@page import="OSS.CartDAO"%>
<%@page import="OSS.ProductDAO"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/catalogue.css" />
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
                <li class="search-bar">
                    <form action="catalogue.jsp" method="GET">
                        <input type="text" name="searchKeyword" placeholder="Search Product" />
                        <button type="submit">Search</button>
                    </form>
                </li>
            </ul>
        </nav>

        <!-- content -->
        <div class="main">
            <div class="wrapper">
                <div class="desc">
                    <h1>OS Store Product</h1>
                    <p>Stationery Excellence Delivered to Your Doorstep</p>
                </div>
                <div class="container">
                    <!-- Catalog section -->
                    <div class="catalog">
                        <h2>Product Catalogue</h2>
                        <!-- Product items -->
                        <%
                            String clearCartParam = request.getParameter("clearCart");
                            if (clearCartParam != null && clearCartParam.equalsIgnoreCase("true")) {
                                CartDAO cartDAO = new CartDAO();
                                cartDAO.clearCart();
                            }

                            ProductDAO productDAO = new ProductDAO();

                            String searchKeyword = request.getParameter("searchKeyword");
                            List<Product> products;

                            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                                products = productDAO.searchProducts(searchKeyword);

                                if (products.isEmpty()) {
                                    products = productDAO.getProducts();
                                }
                            } else {
                                products = productDAO.getProducts();
                            }

                            request.setAttribute("products", products);
                        %>
                        <c:forEach var="product" items="${products}">
                            <div class="item">
                                <img src="data:image/png;base64,${product.productImageBase64}" alt="${product.productName}" />
                                <div>
                                    <h3>${product.productName}</h3>
                                    <div class="dropdown">
                                        <button class="dropbtn">Description <i class="fas fa-caret-down"></i></button>
                                        <div class="dropdown-desc">
                                            <p>${product.productDescription}</p>
                                        </div>
                                    </div>
                                    <p class="category">${product.productCategory}</p>
                                    <p class="price">RM${product.productPrice}</p>

                                    <c:set var="customerID" value="${sessionScope.CustID}" />

                                    <a href="addToCart.jsp?productId=${product.productId}&quantity=1&price=${product.productPrice}&customerID=${customerID}">
                                        <button id="addToCartBtn${product.productId}" class="add">
                                            <i class="fa-solid fa-cart-shopping"></i> Add to Cart
                                        </button>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Cart section -->
                    <div class="cart">
                        <h2>Cart Items</h2>
                        <table id="cartTable">
                            <tr>
                                <th>Item</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Action</th>
                            </tr>
                            <%
                                CartDAO cartDAO = new CartDAO();
                                List<Cart> cartItems = cartDAO.getCartItems();
                                request.setAttribute("cart", cartItems);
                            %>
                            <c:forEach var="cart" items="${cart}">
                                <tr>
                                    <td>${cart.productName}</td>
                                    <td>${cart.orderQuantity}</td>
                                    <td>${cart.orderPrice}</td>
                                    <td>
                                        <a href="removeFromCart.jsp?productId=${cart.productId}">
                                            <button class="remove-btn">
                                                <i class="fa-solid fa-trash"></i></button>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <c:if test="${not empty cart}">
                            <form method="POST" action="recordSales.jsp">
                                <c:forEach var="cart" items="${cart}">
                                    <input type="hidden" name="productId" value="${cart.productId}" />
                                    <input type="hidden" name="salesQuantity" value="${cart.orderQuantity}" />
                                    <input type="hidden" name="totalSales" value="${cart.orderPrice}" />
                                </c:forEach>
                                <button class="payButton" type="submit">Pay</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
