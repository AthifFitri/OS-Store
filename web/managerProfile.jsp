<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>

        <title>Store Manager Profile</title>
        <link rel="stylesheet" type="text/css" href="css/profile.css">
    <nav>
        <ul>
            <li class="logo">OS Store</li>
            <li><a href="stockInfo.jsp">Stock Information</a></li>
            <li><a href="salesReport.jsp">Sales Report</a></li>
            <li><a href="managerLogin.jsp">Sign Out</a></li>
        </ul>
    </nav>
</head>
<style>
    body {
        background-image: url("image/orderbg.jpg");
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center;
    }
</style>
<body>
    <div class="bg-img">
        <div class="container">

            <div class="header">
                <h1>Store Manager Profile</h1>
            </div>
            <br/>
            <%
                String ManagerID = (String) session.getAttribute("ManagerID");

                if (ManagerID != null) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM storemanager WHERE ManagerID = ? ");
                        ps.setString(1, ManagerID);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            String ManagerFirstName = rs.getString("ManagerFirstName");
                            String ManagerLastName = rs.getString("ManagerLastName");
                            String ManagerPassword = rs.getString("ManagerPassword");
                            String ManagerPhoneNumber = rs.getString("ManagerPhoneNumber");
                            boolean editMode = false;

                            if (request.getParameter("editMode") != null) {
                                editMode = Boolean.parseBoolean(request.getParameter("editMode"));
                            }

                            if (request.getParameter("saveProfile") != null) {
                                // Retrieve the updated profile values from the request
                                String updatedManagerFirstName = request.getParameter("ManagerFirstName");
                                String updatedManagerPassword = request.getParameter("ManagerPassword");
                                String updatedManagerLastName = request.getParameter("ManagerLastName");
                                String updatedManagerPhoneNumber = request.getParameter("ManagerPhoneNumber");

                                // Update the database with the new profile values
                                PreparedStatement updatePs = con.prepareStatement("UPDATE storemanager SET ManagerPhoneNumber = ?, ManagerPassword = ?, ManagerFirstName = ?, ManagerLastName = ? WHERE ManagerID = ?");
                                updatePs.setString(1, updatedManagerPhoneNumber);
                                updatePs.setString(2, updatedManagerPassword);
                                updatePs.setString(3, updatedManagerFirstName);
                                updatePs.setString(4, updatedManagerLastName);
                                updatePs.setString(5, ManagerID);
                                updatePs.executeUpdate();
                                updatePs.close();

                                // Redirect to the profile page in view mode
                                response.sendRedirect("managerProfile.jsp");
                                return; // Stop further execution of the JSP
                            }
            %>
            <form method="POST" action="managerProfile.jsp">
                <label for="ManagerID">Manager ID:</label>
                <input type="text" id="ManagerID" name="" value="<%=ManagerID%>" readonly>

                <label for="ManagerFirstName">First Name:</label>
                <input type="text" id="ManagerFirstName" name="ManagerFirstName" value="<%=ManagerFirstName%>" required
                       <%-- Add readonly attribute if not in edit mode --%>
                       <% if (!editMode) { %>
                       readonly
                       <% }%>
                       >

                <label for="ManagerLastName">Last Name:</label>
                <input type="text" id="ManagerLastName" name="ManagerLastName" value="<%=ManagerLastName%>" required
                       <%-- Add readonly attribute if not in edit mode --%>
                       <% if (!editMode) { %>
                       readonly
                       <% }%>
                       >

                <label for="ManagerPassword">Password:</label>
                <input type="password" id="ManagerPassword" name="ManagerPassword" value="<%=ManagerPassword%>"  required
                       <%-- Add readonly attribute if not in edit mode --%>
                       <% if (!editMode) { %>
                       readonly
                       <% }%>
                       >

                <label for="ManagerPhoneNumber">Phone Number:</label>
                <input type="text" id="ManagerPhoneNumber" name="ManagerPhoneNumber" value="<%=ManagerPhoneNumber%>"  required
                       <%-- Add readonly attribute if not in edit mode --%>
                       <% if (!editMode) { %>
                       readonly
                       <% } %>
                       >

                <%-- Display Edit/Save button based on the edit mode --%>
                <% if (editMode) { %>
                <button type="submit" name="saveProfile">Save</button><br/>
                <button type="button" onclick="location.href = 'managerProfile.jsp'">Cancel</button>
                <% } else { %>
                <button type="submit" name="editMode" value="true">Edit</button>
                <% } %>
            </form>
            <%
                        } else {
                            out.println("No manager profile found.");
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("Error: " + e);
                    }
                } else {
                    // If the session doesn't exist or managerID is not set, redirect to the login page
                    response.sendRedirect("managerLogin.jsp");
                }
            %>
        </div>
    </div>

</body>
</html>
