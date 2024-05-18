<%-- 
    Document   : manageManager
    Created on : 3 Jul 2023, 11:24:59 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .container {
                max-width: 500px;
                margin: 0 auto;
                text-align: center;
                background-color: #ffffff;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            h1 {
                font-size: 28px;
                color: #333333;
                margin-bottom: 20px;
            }

            label {
                display: block;
                text-align: left;
                margin-bottom: 10px;
                color: #555555;
                font-weight: bold;
            }

            input[type="text"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 12px;
                border: 1px solid #cccccc;
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
                background-color: gainsboro;

            }

            input[type="text"]:focus {
                outline: none;
                border-color: #4CAF50;
            }

            button[type="submit"],
            button[type="button"] {
                background-color: #4CAF50;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 3px;
                cursor: pointer;
            }

            button[type="button"] {
                background-color: #ccc;
                margin-left: 10px;
            }
            body {
                background-image: url("image/orderbg.jpg");
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
            }
        </style>
        <title>Edit Manager Information</title>
        <link rel="stylesheet" type="text/css" href="css/information.css">
    <nav>
        <ul>
            <li class="logo">OS Store</li>
        </ul>
    </nav>
</head>
<body>
    <form action="updateManager.jsp" method="POST">

        <div class="container">
            <h1>Edit Manager Information</h1>
            <br/>
            <label for="ManagerID">Manager ID:</label>
            <%-- Display the ManagerID value, not editable --%>
            <input type="text" id="ManagerID" name="ManagerID" value="<%= request.getParameter("ManagerID")%>" readonly>
            </br></br>
            <label for="ManagerFirstName">First Name:</label>
            <input type="text" id="ManagerFirstName" name="ManagerFirstName" placeholder="First Name" value="<%= request.getParameter("ManagerFirstName")%>">
            </br></br>
            <label for="ManagerLastName">Last Name:</label>
            <input type="text" id="ManagerLastName" name="ManagerLastName" placeholder="Last Name" value="<%= request.getParameter("ManagerLastName")%>">
            </br></br>
            <label for="ManagerPhoneNumber">Phone Number:</label>
            <input type="text" id="ManagerPhoneNumber" name="ManagerPhoneNumber" placeholder="Phone Number" value="<%= request.getParameter("ManagerPhoneNumber")%>">
            <br/>
            <br/>
            <button type="submit">Save</button>
            <button type="button" onclick="cancelEdit()">Cancel</button>
        </div>

    </form>

    <script>
        function cancelEdit() {
            // Redirect back to the manager information page
            window.location.href = 'staffInfo.jsp';
        }

    </script>
</body>
</html>
