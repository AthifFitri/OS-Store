<%-- 
    Document   : customerUpdateProfile
    Created on : 15 Jun 2023, 10:40:29 pm
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Customer</title>
    </head>
    <body>
        <h1>Update Customer</h1>

        <%
            String id = request.getParameter("CustID");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                PreparedStatement ps = con.prepareStatement("UPDATE customer SET CustFName = ?, CustLName = ?, CustPhoneNum = ? WHERE CustID = ?");
                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, phone);
                ps.setString(4, id);

                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("Customer updated successfully.");
                } else {
                    out.println("Customer not found or couldn't be updated.");
                }

                ps.close();
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
        %>

        <%-- Forward to profile.jsp --%>
        <%
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/customerProfile.jsp");
        %>
    </body>
</html>
