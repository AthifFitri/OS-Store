<%-- 
    Document   : addAProduct
    Created on : 3 Jul 2023, 10:44:45 pm
    Author     : ariff
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        body {
            background-image: url("https://png.pngtree.com/thumb_back/fh260/background/20200722/pngtree-background-for-school-tools-and-school-supplies-image_357880.jpg");
        }

        table {
            background-color: white;
        }

        .white{
            background-color: white;
            width: 50%;
        }

        fieldset{
            width: 60%;
            background-color: white;
        }

    </style>
    <body>
    <center>
        <h1 class="white"><b>Add a New Product</b></h1>
        <form action="StaffController" method="post">
            <fieldset>
                <table>
                    <tr>
                        <td><input type="text" name="ProductID" value="" hidden></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="ProductImage" value="" hidden></td>
                    </tr>
                    <tr>
                        <td>Product Name:</td>
                        <td><input type="text" name="ProductName" value="" size="40" required></td>
                    </tr>
                    <tr>
                        <td>Product Category:</td>
                        <td><input type="text" name="ProductCategory" value="" size="40" required></td>
                    </tr>
                    <tr>
                        <td>Product Quantity:</td>
                        <td><input type="number" name="ProductQuantity" value="" size="10" required></td>
                    </tr>
                    <tr>
                        <td>Product Price:</td>
                        <td><input type="number" name="ProductPrice" value="" size="10" required></td>
                    </tr>
                    <tr>
                        <td>Product Description:</td>
                        <td><input type="text" name="ProductDescription" value="" size="100"\></td>
                    </tr>
                    <tr>
                        <td><input type="hidden" name="action" value="addProduct"></td>
                    </tr>
                </table>
                <input type="submit" name="SubmitButton" value="Submit">
                <input type="reset" name="ResetButton" value="Cancel">
            </fieldset>
        </form>
    </center>
</body>
</html>
