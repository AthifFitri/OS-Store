/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package OSS;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author User
 */

@MultipartConfig
@WebServlet(name = "ImageUpload", urlPatterns = {"/ImageUpload"})
public class ImageUpload extends HttpServlet {
 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (ServletFileUpload.isMultipartContent(request)) {
            if (request.getPart("ProductImage").equals(0)) {
                System.out.println("Error");
            }
            String productId = request.getParameter("ProductID");
            Part productImagePart = request.getPart("ProductImage");
            System.out.println(productImagePart);
            // Your code to process the file and store it in the database
            // For example, converting to byte[] and saving in the database.
            byte[] productImageBytes = null;
            try ( InputStream inputStream = productImagePart.getInputStream()) {

                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                int nRead;
                byte[] data = new byte[1024];
                while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                productImageBytes = buffer.toByteArray();
            } catch (IOException e) {
                e.printStackTrace();
            }

            // Your database connection and insertion logic here
            // For example:
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
                String insertQuery = "UPDATE product SET ProductImage = ? WHERE ProductID = ?";
                PreparedStatement ps = con.prepareStatement(insertQuery);
                ps.setBytes(1, productImageBytes);
                ps.setString(2, productId);
                ps.executeUpdate();

                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Redirect back to the form page after the form is submitted and processed
            response.sendRedirect("productManagement.jsp");
        } else {
            response.sendRedirect("Error.jsp");
        }
    }
}