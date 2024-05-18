/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package OSS;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.math.BigDecimal;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ariff
 */
@WebServlet(name = "StaffController", urlPatterns = {"/StaffController"})
public class StaffController extends HttpServlet {

    private static final String ORDERLIST = "/retrieveOrderInfo.jsp";
    private static final String STAFFPROFILE = "/staffProfile.jsp";
    private static final String ERROR = "/Error.jsp";
    private static final String ALLPRODUCT = "/productManagement.jsp";
    private static final String UPDATESTATUS = "/statusUpdatePage.jsp";
    private static final String RESTOCK = "/restockProduct.jsp";
    private static final String ADDIMAGE = "/addProduct.jsp";
    private final StaffDao dao;

    public StaffController() throws ClassNotFoundException {
        super();
        dao = new StaffDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String forward;
        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("listOrder")) {
            forward = ORDERLIST;
        } else if (action.equalsIgnoreCase("edit")) {
            forward = UPDATESTATUS;
            dao.getOrderById("OrderID");
        } else if (action.equalsIgnoreCase("delete")) {
            dao.deleteOrder(request.getParameter("OrderID"));
            forward = ORDERLIST;
        }else if (action.equalsIgnoreCase("deleteProduct")) {
            dao.deleteProduct(request.getParameter("ProductID"));
            forward = ALLPRODUCT;
        } else if (action.equalsIgnoreCase("restock")) {
            forward = RESTOCK;
            dao.getProductById("ProductID");
        } else if (action.equalsIgnoreCase("addImage")) {
            forward = ADDIMAGE;
            dao.getProductById("ProductID");
        }
        else {
            forward = ERROR;
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String forward;
        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("addProduct")) {
            Product product= new Product();
            product.setProductName(request.getParameter("ProductName"));
            product.setProductImageBase64(request.getParameter("ProductImage"));
            product.setProductCategory(request.getParameter("ProductCategory"));
            product.setProductStock(Integer.parseInt(request.getParameter("ProductQuantity")));
            BigDecimal bigDecimal = new BigDecimal(request.getParameter("ProductPrice"));
            product.setProductPrice(bigDecimal);
            product.setProductDescription(request.getParameter("ProductDescription"));
            dao.addProduct(product);
            forward = ALLPRODUCT;
        } else if (action.equalsIgnoreCase("status")) {
            Order order = new Order();
            order.setOrderID(Integer.parseInt(request.getParameter("oID")));
            order.setPaymentStatus(request.getParameter("Pstatus"));
            dao.updateOrder(order);
            forward = ORDERLIST;
        } else if (action.equalsIgnoreCase("restock")) {
            Product product= new Product();
            product.setProductId(Integer.parseInt(request.getParameter("pID")));
            product.setProductStock(Integer.parseInt(request.getParameter("rAmount")));
            dao.restockProduct(product);
            forward = ALLPRODUCT;
        } else if (action.equalsIgnoreCase("edit")) {
            Staff staff = new Staff();
            staff.setStaffID(request.getParameter("sID"));
            staff.setStaffFirstName(request.getParameter("sFName"));
            staff.setStaffLastName(request.getParameter("sLName"));
            staff.setStaffPhoneNumber(request.getParameter("Phone"));
            dao.updateStaff(staff);
            forward = STAFFPROFILE;
        } else {
            forward = ERROR;
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
