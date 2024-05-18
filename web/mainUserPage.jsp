<%-- 
    Document   : mainUserPage.jsp
    Created on : 26 May 2023, 1:03:34 am
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" 
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <style>
            body{
                background-image: url("https://png.pngtree.com/thumb_back/fh260/background/20200722/pngtree-background-for-school-tools-and-school-supplies-image_357880.jpg");
            }

            .center{
                position: relative;
                text-align: center;
            }

            .col-sm-4{
                text-align: center;
                background-color: #ffffff;
                width:50%;
                float:left;
                position: relative;
                min-height: 1px;
                padding-right: 15px;
                padding-left: 15px;
                border: 3px solid #000000;
            }
        </style>
    </head>
    <body>
        <title>Main Homepage</title>
        <h2 class="center">WELCOME TO ONLINE STATIONARY STORE</h2>

        <div class="col-sm-4">
            <a href="customerLogin.jsp">
                <img src="https://img.freepik.com/premium-vector/customer-concept-line-icon-simple-element-illustration-customer-concept-outline-symbol-design-can-be-used-web-mobile-ui-ux_159242-1819.jpg" alt="Customer" width="400" height="300">
                <br>Customer
            </a>
        </div>

        <div class="col-sm-4">
            <a href="staffLogin.jsp">
                <img src="https://cdn-icons-png.flaticon.com/512/2332/2332039.png" alt="Staff" width="400" height="300">
                <br>Staff
            </a>
        </div>

        <div class="col-sm-4">
            <a href="managerLogin.jsp">
                <img src="https://cdn.xxl.thumbs.canstockphoto.com/waving-manager-in-the-eps-file-each-element-is-grouped-separately-isolated-on-white-background-vector-clipart_csp19250702.jpg" alt="Manager" width="400" height="300">
                <br>Manager
            </a>
        </div>

        <div class="col-sm-4">
            <a href="ownerLogin.jsp">
                <img src="https://en.pimg.jp/096/220/799/1/96220799.jpg" alt="Owner" width="400" height="300">
                <br>Owner
            </a>
        </div>
    </body>
</html>
