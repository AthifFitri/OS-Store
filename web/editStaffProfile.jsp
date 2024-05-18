<%-- 
    Document   : editStaffProfile.jsp
    Created on : 26 May 2023, 6:21:56 am
    Author     : ariff
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Profile</title>
        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="catalogue.css">
        <style>
            .container {
                height: 100%;
                display: flex;
                justify-content: center;
            }
            .window {
                height: 400px;
                width: 500px;
                background: #fff;
                box-shadow: 0px 15px 50px 10px rgba(0, 0, 0, 0.2);
                border-radius: 30px;
                z-index: 10;
                display: flex;
                text-align: center;
                justify-content: space-around;
                flex-direction: column;
            }
        </style>
    </head>
    <body>

        <!-- content -->
    <center>
        <h1>Staff Profile</h1>
        <br />

        <div class="container">
            <div class="window">
                <br />
                <div>
                    <div>
                        <div class="profile_pic">
                            <i class="fa-solid fa-user fa-5x"></i>
                        </div>
                    </div>
                </div>

                <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                        String StaffID = (String) session.getAttribute("StaffID");
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM staff WHERE StaffID=?");
                        ps.setString(1, StaffID);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                <form method="post" action="StaffController">
                    <center>
                    <table border="0">
                    <tr>
                        <td>Staff ID:</td>
                        <td><input type="text" id="sID" name="sID" readonly="readonly" value="<%=rs.getString("StaffID")%>"></td>
                    </tr>
                    <tr>
                        <td><label for="sFName">First Name:</label></td>
                        <td><input type="text" id="sFName" name="sFName" value="<%=rs.getString("StaffFirstName")%>" /></td>
                    </tr>
                    <tr>
                        <td><label for="sLName">Last Name:</label></td>
                        <td><input type="text" id="sLName" name="sLName" value="<%=rs.getString("StaffLastName")%>" /></td>
                    </tr>
                    <tr>
                        <td><label for="Phone">Phone Number:</label></td>
                        <td><input type="text" id="Phone" name="Phone" value="<%=rs.getString("StaffPhoneNumber")%>" /></td>
                    </tr>
                    <input type="hidden" name="action" value="edit">
                    </table>
                    <div class="form-actions">
                        <input type="submit" value="Submit">
                    </div>
                    </center>
                </form>
                    
                <%
                        }
                    
                %>
            </div>
        </div>
    </center>
</body>
</html>
