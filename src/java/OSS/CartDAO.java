/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package OSS;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 *
 * @author ariff
 */
public class CartDAO {

    public List<Cart> getCartItems() {

        // Display list add to cart product
        List<Cart> cartItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
            String query = "SELECT cart.ProductID, product.ProductName, cart.OrderQty, cart.OrderPrice "
                    + "FROM cart "
                    + "JOIN product ON cart.ProductID = product.ProductID";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Cart cartItem = new Cart();
                cartItem.setProductId(rs.getString("ProductID"));
                cartItem.setProductName(rs.getString("ProductName"));
                cartItem.setOrderQuantity(rs.getInt("OrderQty"));
                cartItem.setOrderPrice(rs.getBigDecimal("OrderPrice"));
                cartItems.add(cartItem);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
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

        return cartItems;
    }

    // Remove product from cart
    public void removeFromCart(String productId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
            String query = "DELETE FROM cart WHERE ProductID = ? LIMIT 1";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, productId);
            pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
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
    }

    // Add product to cart
    public void addToCart(String productId, int quantity, BigDecimal price, String customerId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
            String query = "INSERT INTO cart (ProductID, OrderQty, OrderPrice, CustID) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, productId);
            pstmt.setInt(2, quantity);
            pstmt.setBigDecimal(3, price);
            pstmt.setString(4, customerId);
            pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
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
    }

    // Calculate total product price in cart 
    public String calculateTotalPrice() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        BigDecimal totalPrice = BigDecimal.ZERO;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
            String query = "SELECT SUM(OrderPrice) AS TotalPrice FROM cart";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            if (rs.next()) {
                totalPrice = rs.getBigDecimal("TotalPrice");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
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

        // Format the total price to 2 decimal places
        DecimalFormat df = new DecimalFormat("0.00");
        return df.format(totalPrice);
    }

    // Clear cart
    public void clearCart() {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
            String query = "DELETE FROM cart";
            pstmt = conn.prepareStatement(query);
            pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
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
    }
}
