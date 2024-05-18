/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package OSS;

import java.sql.*;

/**
 *
 * @author ariff
 */
public class OrderDAO {

    // Create Order
    public void createOrder(String customerId, Date paymentDate, String paymentReceipt) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
            String query = "INSERT INTO `order` (CustID, PaymentReceipt, PaymentDate, PaymentStatus) "
                    + "VALUES (?, ?, ?, 'Pending')";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, customerId);
            pstmt.setString(2, paymentReceipt);
            pstmt.setDate(3, paymentDate);
            pstmt.executeUpdate();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
