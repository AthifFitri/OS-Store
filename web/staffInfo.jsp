<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
    <style>
        .refresh-button {
            position: fixed;
            top: 10px;
            right: 10px;
            padding: 8px;
            background-color: transparent;
            border: none;
            cursor: pointer;
            font-size: 20px;
            color: #333;
        }
        body {
                background-image: url("image/orderbg.jpg");
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
            }
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
    <title>Store Staff and Manager Information</title>
    <link rel="stylesheet" type="text/css" href="css/information.css">
    <nav>
        <ul>
            <li class="logo">OS Store</li>
            <li><a href="ownerProfile.jsp">Account Information</a></li>
            <li><a href="ownerLogin.jsp">Sign Out</a></li>
        </ul>
    </nav>
</head>

<body>
    <div class="bg-img">
        <div class="container">
            <div class="header">
                <h1>Store Staff and Manager Information</h1>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Role</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Phone Number</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%!
                        // Function to delete a user from the database
                        void deleteUser(Connection conn, String userType, String userID) throws SQLException {
                            String deleteSql = "";
                            if (userType.equals("Staff")) {
                                deleteSql = "DELETE FROM staff WHERE StaffID = ?";
                            } else if (userType.equals("Manager")) {
                                deleteSql = "DELETE FROM storemanager WHERE ManagerID = ?";
                            }
                            PreparedStatement deleteStatement = conn.prepareStatement(deleteSql);
                            deleteStatement.setString(1, userID);
                            deleteStatement.executeUpdate();
                            deleteStatement.close();
                        }
                    %>

                    <%
                        Connection conn = null;
                        PreparedStatement statement = null;
                        ResultSet resultSet = null;
                        try {
                            // Database connection parameters
                            String dbUrl = "jdbc:mysql://localhost:3306/ossystem";
                            String dbUsername = "root";
                            String dbPassword = "admin";

                            // Create a connection to the database
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                            // Check if a delete request has been made
                            String deleteUserType = request.getParameter("deleteUserType");
                            String deleteUserID = request.getParameter("delete" + deleteUserType + "ID");
                            if (deleteUserID != null) {
                                // Delete the user data from the appropriate table
                                deleteUser(conn, deleteUserType, deleteUserID);
                            }

                            // Retrieve staff and manager data from the database
                            String sql = "SELECT 'Staff' AS UserType, StaffID, StaffFirstName, StaffLastName, StaffPhoneNumber, NULL AS ManagerID, NULL AS ManagerFirstName, NULL AS ManagerLastName, NULL AS ManagerPhoneNumber FROM staff "
                                    + "UNION "
                                    + "SELECT 'Manager' AS UserType, NULL AS StaffID, NULL AS StaffFirstName, NULL AS StaffLastName, NULL AS StaffPhoneNumber, ManagerID, ManagerFirstName, ManagerLastName, ManagerPhoneNumber FROM storemanager";

                            statement = conn.prepareStatement(sql);
                            resultSet = statement.executeQuery();

                            // Iterate through the result set and display user data
                            while (resultSet.next()) {
                                String userType = resultSet.getString("UserType");
                                String userID = resultSet.getString(userType + "ID");
                                String userFirstName = resultSet.getString(userType + "FirstName");
                                String userLastName = resultSet.getString(userType + "LastName");
                                String userPhoneNumber = resultSet.getString(userType + "PhoneNumber");
                    %>
                    <tr>
                        <td><%=userType%></td>
                        <td><%=userID%></td>
                        <td><%=userFirstName%> <%=userLastName%></td>
                        <td><%=userPhoneNumber%></td>
                        <td><a href="manage<%=userType%>.jsp?<%=userType%>ID=<%=userID%>&<%=userType%>FirstName=<%=userFirstName%>&<%=userType%>LastName=<%=userLastName%>&<%=userType%>PhoneNumber=<%=userPhoneNumber%>">Edit</a></td>
                        <td>
                            <form action="" method="post">
                                <input type="hidden" name="deleteUserType" value="<%=userType%>">
                                <input type="hidden" name="delete<%=userType%>ID" value="<%=userID%>">
                                <button type="submit" class="delete-button"><i class="fas fa-trash-alt"></i></button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("An error occurred while retrieving user data.");
                        } finally {
                            // Close the database resources
                            if (resultSet != null) {
                                try {
                                    resultSet.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
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
                    %>
                </tbody>
            </table>
            <a href="ownerProfile.jsp"><button type="button">Back</button></a>
            <a href="addStaff.jsp"><button type="button">Add New Staff</button></a>
            <a href="addManager.jsp"><button type="button">Add New Manager</button></a>
            <button class="refresh-button" onclick="window.location.reload();"><i class="fas fa-sync-alt"></i></button>
        </div>
    </div>
</body>

</html>
