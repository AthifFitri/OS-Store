<%-- 
    Document   : addManager
    Created on : 3 Jul 2023, 11:33:46 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
    if (request.getMethod().equals("POST")) {
        // Retrieve form parameters
        String ManagerFirstName = request.getParameter("ManagerFirstName");
        String ManagerLastName = request.getParameter("ManagerLastName");
        String ManagerPassword = request.getParameter("ManagerPassword");
        String ManagerPhoneNumber = request.getParameter("ManagerPhoneNumber");

        // Create a new session or get the existing session
        HttpSession addsession = request.getSession();

        // Store user data in session attributes
        session.setAttribute("ManagerFirstName", ManagerFirstName);
        session.setAttribute("ManagerLastName", ManagerLastName);
        session.setAttribute("ManagerPassword", ManagerPassword);
        session.setAttribute("ManagerPhoneNumber", ManagerPhoneNumber);

        // Database connection parameters
        String dbUrl = "jdbc:mysql://localhost:3306/ossystem";
        String dbUsername = "root";
        String dbPassword = "admin";

        // Insert the manager into the database
        try {
            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Open a connection to the database
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Create the SQL statement
            String sql = "INSERT INTO storemanager (ManagerPassword, ManagerFirstName, ManagerLastName, ManagerPhoneNumber) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, ManagerPassword);
            statement.setString(2, ManagerFirstName);
            statement.setString(3, ManagerLastName);
            statement.setString(4, ManagerPhoneNumber);

            // Execute the statement
            statement.executeUpdate();

            // Close the connection
            conn.close();

            // Redirect to a confirmation page
            response.sendRedirect("staffInfo.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("An error occurred while saving manager data.");
        }
    }
%>

<!DOCTYPE html>
<html>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            background-image: url("image/orderbg.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        form {
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }

        label {
            text-align: left;
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333; /* Adjust label text color */
            font-size: 16px; /* Adjust label font size */
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
            margin-bottom: 10px;
            background-color: gainsboro;

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
    </style>
    <nav>
        <ul>
            <li class="logo">OS Store</li>
        </ul>
    </nav>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <title>Manager Registration</title>
        <link rel="stylesheet" type="text/css" href="css/information.css">

    </head>
    <body>
    <center>

        <form id="newForm" method="post" action="">
            <h1>Manager Registration</h1>
            <br/>
            <label for="ManagerFirstName">First Name:</label>
            <input type="text" id="ManagerFirstName" name="ManagerFirstName" required><br><br>

            <label for="ManagerLastName">Last Name:</label>
            <input type="text" id="ManagerLastName" name="ManagerLastName" required><br><br>

            <label for="ManagerPassword">Password:</label>
            <input type="text" id="ManagerPassword" name="ManagerPassword" required><br><br>

            <label for="ManagerPhoneNumber">Phone Number:</label>
            <input type="text" id="ManagerPhoneNumber" name="ManagerPhoneNumber" min="10" max="11" required><br><br>

            <button type="submit" >Save</button>
            <button type="button" onclick="location.href = 'staffInfo.jsp'">Cancel</button>
        </form>
    </center>
    <script>
        function cancelEdit() {
            // Redirect back to the manager information page
            window.location.href = 'staffInfo.jsp';
        }
    </script>
</body>
</html>

