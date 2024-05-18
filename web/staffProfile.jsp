<%-- 
    Document   : staffProfile
    Created on : 24 May 2023, 9:51:39 pm
    Author     : ariff
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="OSS.DBConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /* content */
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500&display=swap');
            body {
                background-image: url("https://png.pngtree.com/thumb_back/fh260/background/20200722/pngtree-background-for-school-tools-and-school-supplies-image_357880.jpg");
            }
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }
            .main{
                width: 100%;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                background-position: center;
                background-size: cover;
            }
            .profile-card{
                display: flex;
                flex-direction: column;
                align-items: center;
                max-width: 400px;
                width: 100%;
                border-radius: 25px;
                padding: 30px;
                border: 1px solid #ffffff40;
                background-color: white;
                box-shadow: 0 5px 20px rgba(0,0,0,0.4);
            }
            .data{
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .data h2{
                font-size: 33px;
                font-weight: 600;
            }
            span{
                color: orangered;
                font-size: 18px;
            }
            .row{
                display: flex;
                align-items: center;
                margin-top: 30px;
            }
            .row .info{
                text-align: center;
                padding: 0 20px;
            }
            .buttons{
                display: flex;
                align-items: center;
                margin-top: 30px;
            }
            .buttons .btn{
                color: #fff;
                text-decoration: none;
                margin: 0 20px;
                padding: 8px 25px;
                border-radius: 25px;
                font-size: 18px;
                white-space: nowrap;
                background: linear-gradient(to left, #33ccff 0%, #ff99cc 100%);
            }
            .buttons .btn:hover{
                box-shadow: inset 0 5px 20px rgba(0,0,0,0.4);
            }
        </style>
    </head>
    <body>
        <%
            String myURL = "jdbc:mysql://localhost:3306/ossystem";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(myURL, "root", "admin");
             String StaffID = (String) session.getAttribute("StaffID");
        %>
    <center>


        <%
            if (StaffID != null) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM staff WHERE StaffID=?");
                ps.setString(1, StaffID);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>

    </center>
    <section class="main">
        <div class="profile-card">
            <h1>Staff Information</h1>
            <hr>
            <div class="data">
                <span>Staff Name:</span>
                <h2><%=rs.getString("StaffFirstName") + "\r" + rs.getString("StaffLastName")%></h2>
                <span>Staff ID:</span>
                <h2><%=rs.getString("StaffID")%></h2>
                <span>Contact Number:</span>
                <h2><%=rs.getString("StaffPhoneNumber")%></h2>
            </div>
            <div class="buttons">
                <a href="editStaffProfile.jsp" class="btn">Edit</a>
                <a href="retrieveOrderInfo.jsp" class="btn">Return</a>
            </div>
        </div>
    </section>
    <%
            }

        } else {
            out.println("Customer not found");
        }

    %>
</body>
</html>
