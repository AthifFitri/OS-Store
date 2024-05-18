<%-- 
    Document   : customerEditProfile
    Created on : 15 Jun 2023, 10:37:53 pm
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Profile</title>
        <script src="https://kit.fontawesome.com/98164d6884.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/customerEditProfile.css">
    </head>
    <body>
        <!-- navigation bar -->
        <nav>
            <ul>
                <li class="logo">OS Store</li>

                <li><a href="catalogue.jsp">Catalogue</a></li>
                <li><a href="customerLogin.jsp">Sign Out</a></li>
            </ul>
        </nav>
        <br />

        <!-- content -->
        <%
            String customerID = (String) session.getAttribute("CustID");

            if (customerID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM customer WHERE CustID = ? ");
                    ps.setString(1, customerID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String username = rs.getString("CustUsername");
                        String firstName = rs.getString("CustFName");
                        String lastName = rs.getString("CustLName");
                        String phone = rs.getString("CustPhoneNum");
        %>
        <h1 style="text-align: center">Edit Customer Profile</h1>
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

                <div class="profile-details">
                    <h2><%=username%></h2>
                    <form action="customerUpdateProfile.jsp" method="post">
                        <table border="0">
                            <tbody>
                                <tr>
                                    <td>First Name :</td>
                                    <td><input type="text" name="firstName" value="<%=firstName%>" ></td>
                                </tr>
                                <tr>
                                    <td>Last Name :</td>
                                    <td><input type="text" name="lastName" value="<%=lastName%>"></td>
                                </tr>
                                <tr>
                                    <td>Phone Number :</td>
                                    <td><input type="text" name="phone" value="<%=phone%>"></td>
                                </tr>
                            <input type="hidden" name="CustID" value="<%=customerID%>">
                            <tr>
                                <td class="button" colspan="2" align="center">
                                    <input class="btn" type="submit" value="Update">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>

        <%
                    } else {
                        out.println("Customer not found.");
                    }

                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
            } else {
                // If the session doesn't exist or customerID is not set, redirect to the login page
                response.sendRedirect("customerLogin.jsp");
            }
        %>
    </body>
</html>
