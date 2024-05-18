/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package OSS;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ariff
 */
@WebServlet(urlPatterns = {"/CustomerSignUpServlet"})
public class CustomerSignUpServlet extends HttpServlet {

    // Database credentials
    static final String DB_URL = "jdbc:mysql://localhost:3306/ossystem";
    static final String USER = "root";
    static final String PASS = "admin";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieve user input
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lname");
        String phone = request.getParameter("phone");

        // Store user input in the database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
            String sql = "INSERT INTO customer (CustUsername, CustPass, CustFName, CustLName, CustPhoneNum) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, firstName);
            statement.setString(4, lastName);
            statement.setString(5, phone);
            statement.executeUpdate();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error: " + e.getMessage());
            return;
        }

        // Display success message with green background
        out.println("<html><head>");
        out.println("<script type=\"text/javascript\">");
        out.println("alert('SignUp Succesful');");
        out.println("window.location.href = 'customerLogin.jsp';");
        out.println("</script>");
        out.println("</head><body>");
        out.println("</body></html>");
    }

}
