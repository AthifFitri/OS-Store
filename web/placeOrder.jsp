<%@ page import="java.sql.*" %>
<%
try {
    if (request.getMethod().equals("POST")) {
        // Retrieve form parameters
        String StockID = request.getParameter("StockID");
        int OrderQuantity = Integer.parseInt(request.getParameter("OrderQuantity"));

        // Create a new session or get the existing session
        HttpSession addSession = request.getSession();

        // Store stock data in session attributes
        addSession.setAttribute("StockID", StockID);
        addSession.setAttribute("OrderQuantity", OrderQuantity);

        // Database connection parameters
        String dbUrl = "jdbc:mysql://localhost:3306/ossystem";
        String dbUsername = "root";
        String dbPassword = "admin";

        // Register JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Open a connection to the database
        Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        // Create the SQL statement
        String sql = "INSERT INTO stockorder (StockID, OrderQuantity) VALUES (?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, StockID);
        statement.setInt(2, OrderQuantity);

        // Execute the statement
        statement.executeUpdate();

        // Close the statement and connection
        statement.close();
        conn.close();

        // Redirect to a confirmation page
        response.sendRedirect("orderStock.jsp");
    }
} catch (SQLException e) {
    e.printStackTrace(); // or log the error
    // Handle the error appropriately (e.g., display an error message)
}
%>
