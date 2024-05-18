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

        <title>Store Owner Profile</title>
        <link rel="stylesheet" type="text/css" href="css/profile.css">
    <nav>
        <ul>
            <li class="logo">OS Store</li>
            <li><a href="staffInfo.jsp">Staff Information</a></li>
            <li><a href="ownerLogin.jsp">Sign Out</a></li>
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
    <%
        String OwnerID = (String) session.getAttribute("OwnerID");
        
        if (OwnerID != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM storeowner WHERE OwnerID = ? ");
                ps.setString(1, OwnerID);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String OwnerFirstName = rs.getString("OwnerFirstName");
                    String OwnerLastName = rs.getString("OwnerLastName");
                    String OwnerPassword = rs.getString("OwnerPassword");
                    String OwnerPhoneNumber = rs.getString("OwnerPhoneNumber");
                    boolean editMode = false;

                    if (request.getParameter("editMode") != null) {
                        editMode = Boolean.parseBoolean(request.getParameter("editMode"));
                    }

                    if (request.getParameter("saveProfile") != null) {
                        // Retrieve the updated profile values from the request
                        String updatedOwnerFirstName = request.getParameter("OwnerFirstName");
                        String updatedOwnerPassword = request.getParameter("OwnerPassword");
                        String updatedOwnerLastName = request.getParameter("OwnerLastName");
                        String updatedOwnerPhoneNumber = request.getParameter("OwnerPhoneNumber");

                        // Update the database with the new profile values
                        PreparedStatement updatePs = con.prepareStatement("UPDATE storeowner SET OwnerPhoneNumber = ?, OwnerPassword = ?, OwnerFirstName = ?, OwnerLastName = ? WHERE OwnerID = ?");
                        updatePs.setString(1, updatedOwnerPhoneNumber);
                        updatePs.setString(2, updatedOwnerPassword);
                        updatePs.setString(3, updatedOwnerFirstName);
                        updatePs.setString(4, updatedOwnerLastName);
                        updatePs.setString(5, OwnerID);
                        updatePs.executeUpdate();
                        updatePs.close();

                        // Redirect to the profile page in view mode
                        response.sendRedirect("ownerProfile.jsp");
                        return; // Stop further execution of the JSP
                    }
    %>
    
        <div class="container">
            <div class="header">
                <h1>Store Owner Profile</h1>
            </div>
            <br/>
            <form method="POST" action="ownerProfile.jsp">
                <label for="ownerID">Owner ID:</label>
                <input type="text" id="ownerID" name="managerID" value="<%=OwnerID%>" readonly>

                <label for="OwnerFirstName">First Name:</label>
                <input type="text" id="OwnerFirstName" name="OwnerFirstName" value="<%=OwnerFirstName%>"required
                       <%-- Add readonly attribute if not in edit mode --%>
                       <% if (!editMode) { %>
                       readonly
                       <% }%>
                       >

                <label for="OwnerLastName">Last Name:</label>
                <input type="text" id="OwnerLastName" name="OwnerLastName" value="<%=OwnerLastName%>"required
                       <%-- Add readonly attribute if not in edit mode --%>
                       <% if (!editMode) { %>
                       readonly
                       <% }%>
                       >

                <label for="OwnerPassword">Password:</label>
                <input type="password" id="OwnerPassword" name="OwnerPassword" value="<%=OwnerPassword%>"required
                       <%-- Add readonly attribute if not in edit mode --%>
                       <% if (!editMode) { %>
                       readonly
                       <% } %>
                       >

                <label for="OwnerPhoneNumber">Phone Number:</label>
                <input type="text" id="OwnerPhoneNumber" name="OwnerPhoneNumber" value="<%=OwnerPhoneNumber%>"required
                       <%-- Add readonly attribute if not in edit mode --%>
                       <% if (!editMode) { %>
                       readonly
                       <% }%>
                       >
                
                <%-- Display Edit/Save button based on the edit mode --%>
                <% if (editMode) { %>
                <button type="submit" name="saveProfile">Save</button><br/>
                <button type="button" onclick="location.href = 'ownerProfile.jsp'">Cancel</button>
                <% } else { %>
                <button type="submit" name="editMode" value="true">Edit</button>
                <% } %>
            </form>
        </div>
    
    <%
                } else {
                    out.println("No owner profile found.");
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e);
            }
        } else {
            // If the session doesn't exist or ownerID is not set, redirect to the login page
            response.sendRedirect("ownerLogin.jsp");
        }
    %>
</body>

</html>
