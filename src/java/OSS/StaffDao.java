/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package OSS;

import java.util.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ariff
 */
public class StaffDao {

    private final Connection con;
    
    public StaffDao() throws ClassNotFoundException {
        con= DBConnection.getConnection();
    }
    
    public void deleteOrder (String OrderID){
        try {
            PreparedStatement ps = con.prepareStatement("DELETE FROM `order` WHERE `order`.`OrderID` = ?");
            ps.setString(1, OrderID);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
    }
    
    public void deleteProduct (String ProductID){
        try {
            PreparedStatement ps = con.prepareStatement("DELETE FROM `product` WHERE `product`.`ProductID` = ?");
            ps.setString(1, ProductID);
            System.out.println(ProductID);
            ps.executeUpdate();
            int StockID = Integer.parseInt(ProductID) + 30000;
            System.out.println(StockID);
            PreparedStatement ps1 = con.prepareStatement("DELETE FROM `stock` WHERE `stock`.`StockID` = ?");
            ps1.setInt(1, StockID);
            ps1.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public Staff getStaffById (String StaffID) {
        Staff staff = new Staff();
        try {
            PreparedStatement ps = con.prepareStatement("Select * from staff where StaffID=?");
            ps.setString(1,StaffID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffFirstName(rs.getString("StaffFirstName"));
                staff.setStaffLastName(rs.getString("StaffLastName"));
                staff.setStaffPhoneNumber(rs.getString("StaffPhoneNumber"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staff;
    }
    
    public Order getOrderById (String OrderID) {
        Order o = new Order();
        try {
            PreparedStatement ps = con.prepareStatement("Select * from order where OrderID=?");
            ps.setString(1, OrderID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                o.setOrderID(rs.getInt("OrderID"));
                o.setCustID(rs.getInt("CustID"));
                o.setPaymentReceipt("PaymentReceipt");
                o.setPaymentDate(rs.getDate("PaymentDate"));
                o.setPaymentStatus("PaymentStatus");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return o;
    }
    
    public void updateStaff (Staff staff) {
        try {
            PreparedStatement ps = con.prepareStatement("UPDATE staff set StaffFirstName=?, StaffLastName=?, StaffPhoneNumber=? where StaffID=?");
            ps.setString(1, staff.getStaffFirstName());
            ps.setString(2, staff.getStaffLastName());
            ps.setString(3, staff.getStaffPhoneNumber());
            ps.setString(4, staff.getStaffID());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public void updateOrder (Order order) {
        try {
            PreparedStatement ps = con.prepareStatement("UPDATE `order` set PaymentStatus=? where OrderID=?");
            ps.setString(1, order.getPaymentStatus());
            ps.setInt(2, order.getOrderID());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public List<Product> getAllProduct(){
        List<Product> list = new ArrayList<Product>();

        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM 'product'");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product= new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                Blob productImageBlob = rs.getBlob("ProductImage");
                byte[] productImageBytes = productImageBlob.getBytes(1, (int) productImageBlob.length());
                product.setProductImageBase64(Base64.getEncoder().encodeToString(productImageBytes));
                product.setProductCategory(rs.getString("ProductCategory"));
                product.setProductPrice(rs.getBigDecimal("ProductPrice"));
                product.setProductDescription(rs.getString("ProductDesc"));
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public void restockProduct (Product product) {
        try {
            PreparedStatement ps = con.prepareStatement("UPDATE product set ProductStock = ProductStock + ?  where ProductID=?");
            ps.setInt(1, product.getProductStock());
            ps.setInt(2, product.getProductId());
            ps.executeUpdate();
            int StockID = product.getProductId() + 30000;
            PreparedStatement ps1 = con.prepareStatement("UPDATE stock set StockQuantity = StockQuantity - ?  where StockID=?");
            ps1.setInt(1, product.getProductStock());
            ps1.setInt(2, StockID);
            ps1.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StaffDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void addProduct (Product Product) {
        try {
            PreparedStatement ps = con.prepareStatement("Insert into product (ProductName, ProductCategory, ProductStock, ProductPrice, ProductDesc, ProductImage) values (?,?,?,?,?,?)");
            ps.setString(1, Product.getProductName());
            ps.setString(2, Product.getProductCategory());
            ps.setInt(3, Product.getProductStock());
            ps.setBigDecimal(4, Product.getProductPrice());
            ps.setString(5, Product.getProductDescription());
            ps.setString(6, Product.getProductImageBase64());
            ps.executeUpdate();
            PreparedStatement ps1 = con.prepareStatement("Insert into stock (StockName, StockQuantity, StockPrice) values (?,0,?)");
            ps1.setString(1, Product.getProductName());
            ps1.setBigDecimal(2, Product.getProductPrice());
            ps1.executeUpdate();
        } catch (SQLException ex) {
           ex.printStackTrace();
        }
    } 

    public Product getProductById (String ProductID) {
        Product o = new Product();
        try {
            PreparedStatement ps = con.prepareStatement("Select * from product where ProductID=?");
            ps.setString(1, ProductID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                o.setProductId(rs.getInt("ProductID"));
                o.setProductImageBase64("ProductImage");
                o.setProductName("ProductName");
                o.setProductCategory("ProductCategory");
                o.setProductStock(rs.getInt("ProductStock"));
                o.setProductPrice(rs.getBigDecimal("ProductPrice"));
                o.setProductDescription("ProductCategory");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return o;
    }
}
