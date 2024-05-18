<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>


<%
    if (request.getMethod().equals("POST")) {
        // Retrieve form parameters

        String StaffFirstName = request.getParameter("StaffFirstName");
        String StaffLastName = request.getParameter("StaffLastName");
        String StaffPassword = request.getParameter("StaffPassword");
        String StaffPhoneNumber = request.getParameter("StaffPhoneNumber");
        // Create a new session or get the existing session
        HttpSession addSession = request.getSession();

        // Store user data in session attributes
        session.setAttribute("StaffFirstName", StaffFirstName);
        session.setAttribute("StaffLastName", StaffLastName);
        session.setAttribute("StaffPassword", StaffPassword);
        session.setAttribute("StaffPhoneNumber", StaffPhoneNumber);
        // Database connection parameters
        String dbUrl = "jdbc:mysql://localhost:3306/ossystem";
        String dbUsername = "root";
        String dbPassword = "admin";

        // Insert the user into the database
        try {
            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Open a connection to the database
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Create the SQL statement
            String sql = "INSERT INTO staff (StaffPassword, StaffFirstName, StaffLastName, StaffPhoneNumber) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, StaffPassword);
            statement.setString(2, StaffFirstName);
            statement.setString(3, StaffLastName);
            statement.setString(4, StaffPhoneNumber);

            // Execute the statement
            statement.executeUpdate();

            // Close the connection
            conn.close();

            // Redirect to a confirmation page
            response.sendRedirect("staffInfo.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("An error occurred while saving user data.");
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
        <title>Staff Registration</title>
        <link rel="stylesheet" type="text/css" href="css/information.css">
    </head>
    <body>
    <center>

        <form id="newForm" method="post" action="">
            <h1>Staff Registration</h1>
            <br/>
            <label for="StaffFirstName">First Name:</label>
            <input type="text" id="StaffFirstName" name="StaffFirstName" required><br><br>

            <label for="StaffLastName">Last Name:</label>
            <input type="text" id="StaffLastName" name="StaffLastName" required><br><br>

            <label for="StaffPassword">Password:</label>
            <input type="text" id="StaffPassword" name="StaffPassword" required><br><br>

            <label for="StaffPhoneNumber">Phone Number:</label>
            <input type="text" id="StaffPhoneNumber" name="StaffPhoneNumber" min="10" max="11" required><br><br>

            <button type="submit" >Save</button>
            <button type="button" onclick="location.href = 'staffInfo.jsp'">Cancel</button>


        </form>
    </center>
    <script>
        function cancelEdit() {
            // Redirect back to the staff information page
            window.location.href = 'staffInfo.jsp';
        }

    </script>
</body>
</html>



