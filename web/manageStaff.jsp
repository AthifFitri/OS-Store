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

        <title>Edit Staff Information</title>
        <link rel="stylesheet" type="text/css" href="css/information.css">
    <nav>
        <ul>
            <li class="logo">OS Store</li>
        </ul>
    </nav>
</head>
<body>
    <form action="updateStaff.jsp" method="POST">

        <div class="container">
            <h1>Edit Staff Information</h1>
            <br/>
            <label for="StaffID">Staff ID:</label>
            <%-- Display the staffID value, not editable --%>
            <input type="text" id="StaffID" name="StaffID" value="<%= request.getParameter("StaffID")%>" readonly>
            </br></br>
            <label for="StaffFirstName">First Name:</label>
            <input type="text" id="StaffFirstName" name="StaffFirstName" placeholder="First Name" value="<%= request.getParameter("StaffFirstName")%>">
            </br></br>
            <label for="StaffLastName">Last Name:</label>
            <input type="text" id="StaffLastName" name="StaffLastName" placeholder="Last Name" value="<%= request.getParameter("StaffLastName")%>">
            </br></br>
            <label for="StaffPhoneNumber">Phone Number:</label>
            <input type="text" id="StaffPhoneNumber" name="StaffPhoneNumber" placeholder="Phone Number" value="<%= request.getParameter("StaffPhoneNumber")%>">
            <br/>
            <br/>
            <button type="submit">Save</button>
            <button type="button" onclick="cancelEdit()">Cancel</button>
        </div>


    </form>

    <%
        if (request.getMethod().equals("POST")) {
            Connection conn = null;
            PreparedStatement statement = null;
            try {
                // Database connection parameters
                String dbUrl = "jdbc:mysql://localhost:3306/ossystem";
                String dbUsername = "root";
                String dbPassword = "admin";

                // Create a connection to the database
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                // Get the form data
                String StaffID = request.getParameter("StaffID");
                String StaffFirstName = request.getParameter("StaffFirstName");
                String StaffLastName = request.getParameter("StaffLastName");
                String StaffPhoneNumber = request.getParameter("StaffPhoneNumber");

                // Update the staff information in the database
                String sql = "SELECT * FROM staff WHERE StaffID=?";
                statement = conn.prepareStatement(sql);
                statement.setString(1, StaffFirstName);
                statement.setString(2, StaffLastName);
                statement.setString(3, StaffPhoneNumber);
                statement.setString(4, StaffID);
                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("Staff information updated successfully!");

                    // Redirect back to the staff information page
                    response.sendRedirect("staffInfo.jsp");
                } else {
                    out.println("Failed to update staff information.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("An error occurred while updating staff information.");
            } finally {
                // Close the database resources
                if (statement != null) {
                    try {
                        statement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>

    <script>
        function cancelEdit() {
            // Redirect back to the staff information page
            window.location.href = 'staffInfo.jsp';
        }

    </script>
</body>
</html>
