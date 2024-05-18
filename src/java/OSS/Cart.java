/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package OSS;

import java.math.BigDecimal;

/**
 *
 * @author ariff
 */
public class Cart {

    private String ProductId;
    private String productName;
    private int OrderQuantity;
    private BigDecimal OrderPrice;
    private String CustomerId;

    public Cart() {

    }

    public String getProductId() {
        return ProductId;
    }

    public void setProductId(String ProductId) {
        this.ProductId = ProductId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getOrderQuantity() {
        return OrderQuantity;
    }

    public void setOrderQuantity(int OrderQuantity) {
        this.OrderQuantity = OrderQuantity;
    }

    public BigDecimal getOrderPrice() {
        return OrderPrice;
    }

    public void setOrderPrice(BigDecimal OrderPrice) {
        this.OrderPrice = OrderPrice;
    }

    public String getCustomerId() {
        return CustomerId;
    }

    public void setCustomerId(String CustomerId) {
        this.CustomerId = CustomerId;
    }
}
