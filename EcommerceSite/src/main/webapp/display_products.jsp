<%@page import="com.cds.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.cds.dao.UserDao"%>
<%@page import="com.cds.entities.Product"%>
<%@page import="com.cds.dao.ProductDao"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
UserDao userDao = new UserDao(DBConnection.getConnection());
ProductDao productDao = new ProductDao(DBConnection.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Product's</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
		<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!-- update product -->
	<div class="container mt-3">
		<%@include file="Components/alert_message.jsp"%>
		<table class="table table-hover">
			<tr class="table-primary text-center" style="font-size: 20px;">
				<th>Image</th>
				<th>Name</th>
				<th class="text-start">Category</th>
				<th>Price</th>
				<th class="text-start">Quantity</th>
				<th>Action</th>
			</tr>
			<%
			List<Product> productList = productDao.getAllProducts();
			for (Product prod : productList) {
				String category = catDao.getCategoryName(prod.getCategoryId());
			%>
			<tr class="text-center">
				<td><img src="Images\<%=prod.getProductImages()%>"
					style="width: 60px; height: 60px; width: auto;"></td>
				<td class="text-start"><%=prod.getProductName()%></td>
				<td><%=category%></td>
				<td><%=prod.getProductPrice()%>&#8378;</td>
				<td><%=prod.getProductQunatity()%></td>
				
				<td><a href="update_product.jsp?pid=<%=prod.getProductId()%>" role="button" class="btn btn-secondary">Update</a>&emsp;<a
					href="AddOperationServlet?pid=<%=prod.getProductId()%>&operation=deleteProduct"
					class="btn btn-danger" role="button">Delete</a></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>

</body>
</html>