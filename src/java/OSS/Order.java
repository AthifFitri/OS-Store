/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package OSS;

import java.sql.Date;

/**
 *
 * @author ariff
 */
public class Order {

    int OrderID, CustID;
    String PaymentReceipt, PaymentStatus;
    Date PaymentDate;

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public int getCustID() {
        return CustID;
    }

    public void setCustID(int CustID) {
        this.CustID = CustID;
    }

    public String getPaymentReceipt() {
        return PaymentReceipt;
    }

    public void setPaymentReceipt(String PaymentReceipt) {
        this.PaymentReceipt = PaymentReceipt;
    }

    public String getPaymentStatus() {
        return PaymentStatus;
    }

    public void setPaymentStatus(String PaymentStatus) {
        this.PaymentStatus = PaymentStatus;
    }

    public Date getPaymentDate() {
        return PaymentDate;
    }

    public void setPaymentDate(Date PaymentDate) {
        this.PaymentDate = PaymentDate;
    }
    

}
