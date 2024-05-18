<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>


<%
    if (request.getMethod().equals("POST")) {
        // Retrieve form parameters
        String StockName = request.getParameter("StockName");
        int StockQuantity = Integer.parseInt(request.getParameter("StockQuantity"));
        double StockPrice = Double.parseDouble(request.getParameter("StockPrice"));

        // Create a new session or get the existing session
        HttpSession addSession = request.getSession();

        // Store stock data in session attributes
        session.setAttribute("StockName", StockName);
        session.setAttribute("StockQuantity", StockQuantity);
        session.setAttribute("StockPrice", StockPrice);

        // Database connection parameters
        String dbUrl = "jdbc:mysql://localhost:3306/ossystem";
        String dbUsername = "root";
        String dbPassword = "admin";

        // Insert the stock into the database
        try {
            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Open a connection to the database
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Create the SQL statement
            String sql = "INSERT INTO stock (StockName, StockQuantity, StockPrice) VALUES (?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, StockName);
            statement.setInt(2, StockQuantity);
            statement.setDouble(3, StockPrice);

            // Execute the statement
            statement.executeUpdate();

            // Close the connection
            conn.close();

            // Redirect to a confirmation page
            response.sendRedirect("stockInfo.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("An error occurred while saving stock data.");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <title>New Stock Registration</title>
        <link rel="stylesheet" type="text/css" href="css/information.css">
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
</head>
<body>
<center>

    <form id="newForm" method="post" action="">
        <h1>New Stock Registration</h1>
        <br/>
        <br/>
        <label for="StockName">Product Name:</label>
        <input type="text" id="StockName" name="StockName" required><br><br>

        <label for="StockQuantity">Stock Quantity:</label>
        <input type="number" id="StockQuantity" name="StockQuantity" required><br><br>

        <label for="StockPrice">Stock Price: RM</label>
        <input type="number" id="StockPrice" name="StockPrice" min="0.01" step="0.01" required><br><br>

        <button type="submit" >Save</button>
        <button type="button" onclick="location.href = 'stockInfo.jsp'">Cancel</button>
    </form>
</center>
<script>
    function cancelEdit() {
        // Redirect back to the stock information page
        window.location.href = 'stockInfo.jsp';
    }
</script>
</body>
</html>
