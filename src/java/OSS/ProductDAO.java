/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package OSS;

import java.sql.*;
import java.util.*;

/**
 *
 * @author ariff
 */
public class ProductDAO {

    // List all product
    public List<Product> getProducts() {

        List<Product> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ossystem", "root", "admin");
            String query = "SELECT * FROM product";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                Blob productImageBlob = rs.getBlob("ProductImage");
                byte[] productImageBytes = productImageBlob.getBytes(1, (int) productImageBlob.length());
                product.setProductImageBase64(Base64.getEncoder().encodeToString(productImageBytes));
                product.setProductCategory(rs.getString("ProductCategory"));
                product.setProductPrice(rs.getBigDecimal("ProductPrice"));
                product.setProductDescription(rs.getString("ProductDesc"));
                products.add(product);
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

        return products;
    }

    // List search product
    public List<Product> searchProducts(String searchKeyword) {

        List<Product> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/os_store", "root", "admin");
            String query = "SELECT * FROM product WHERE ProductName LIKE ? OR ProductCategory LIKE ?";
            stmt = conn.prepareStatement(query);

            stmt.setString(1, "%" + searchKeyword + "%");
            stmt.setString(2, "%" + searchKeyword + "%");

            rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                Blob productImageBlob = rs.getBlob("ProductImage");
                byte[] productImageBytes = productImageBlob.getBytes(1, (int) productImageBlob.length());
                product.setProductImageBase64(Base64.getEncoder().encodeToString(productImageBytes));
                product.setProductCategory(rs.getString("ProductCategory"));
                product.setProductPrice(rs.getBigDecimal("ProductPrice"));
                product.setProductDescription(rs.getString("ProductDesc"));
                products.add(product);
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

        return products;
    }
}
