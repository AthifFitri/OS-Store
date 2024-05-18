<%-- 
    Document   : custSignUp
    Created on : 26 May 2023, 8:11:21 am
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Customer Sign Up</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <style>
            body {
                background-image: url("https://png.pngtree.com/thumb_back/fh260/background/20200722/pngtree-background-for-school-tools-and-school-supplies-image_357880.jpg");
            }

            .center {
                position: relative;
                text-align: center;
            }

            .container {
                width: 540px;
                padding: 16px;
                background-color: #f4a896;
                margin-top: 5%;
                border-style: solid;
                border-color: black;
            }

            .bg-img {
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                position: relative;
            }

            .btn {
                background-color: #358597;
                color: white;
                padding: 16px 20px;
                border: none;
                cursor: pointer;
                width: 240px;
                opacity: 0.9;
            }

            .btn:hover {
                opacity: 1;
            }

            /* Full-width input fields */
            input[type=text],
            input[type=password] {
                width: 500px;
                padding: 8px;
                margin: 5px 0 22px 0;
                border: none;
                background: #f1f1f1;
            }

            input[type=text]:focus,
            input[type=password]:focus {
                background-color: #ddd;
                outline: none;
            }
        </style>
    </head>

    <body>
        <div>
            <form action="CustomerSignUpServlet" method="post" class="container">
                <h1 class="center">Customer Sign Up</h1>

                <label for="Username"><b>Username</b></label>
                <input type="text" placeholder="Enter Username" name="username" required>

                <label for="psw"> <b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="password" required
                       oninput="validatePassword(this)">
                <div id="passwordError" style="color: red"></div>

                <label for="fname"> <b>First Name</b></label>
                <input type="text" placeholder="Enter your First Name" name="fname" required>

                <label for="lname"> <b>Last Name</b></label>
                <input type="text" placeholder="Enter your Last Name" name="lname" required>

                <label for="lname"> <b>Phone Number</b></label>
                <input type="text" placeholder="Enter your Phone Number" name="phone" maxlength="11" required>

                <button type="submit" class="btn" id="submit">Submit</button>
                <button type="reset" class="btn" id="btnCancel">Reset</button>
                <div class="center">
                    <a href="customerLogin.jsp">Back to Login Page</a>
                </div>
            </form>
        </div>

        <script>
            function validatePassword(input) {
                var password = input.value;
                var passwordError = document.getElementById("passwordError");

                // Regular expression to match the password requirements
                var regex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()])[A-Za-z\d!@#$%^&*()]{5,}$/;

                if (!regex.test(password)) {
                    passwordError.textContent = "Password must be at least 5 characters long, contain an uppercase letter, a numeric character, and a special character.";
                } else {
                    passwordError.textContent = "";
                    input.setCustomValidity("");
                 }
                        }
        </script>
    </body>
</html>
