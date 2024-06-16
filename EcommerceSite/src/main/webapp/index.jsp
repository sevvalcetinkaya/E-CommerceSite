<%@page import="com.cds.dao.ProductDao"%>
<%@page import="com.cds.entities.Product"%>
<%@page import="com.cds.helper.DBConnection"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ProductDao productDao = new ProductDao(DBConnection.getConnection());
List<Product> productList = productDao.getAllLatestProducts();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
.cus-card {
	border-radius: 50%;
	border-color: transparent;
	max-height: 200px;
	max-width: 200px;
	max-height: 200px;
}

.real-price {
	font-size: 20px !important;
	font-weight: 600;
}

.product-price {
	font-size: 17px !important;
	text-decoration: line-through;
}


</style>
</head>
<body>
		<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!-- Category list -->
	<div class="container-fluid px-3 py-3"
		style="background-color: #EEF7FF;">
		<div class="row">
			<div class="card-group">
				<%
				for (Category c : categoryList) {
				%>
				<div class="col text-center">
					<a href="products.jsp?category=<%=c.getCategoryId()%>"
						style="text-decoration: none;">
						<div class="card cus-card h-100">
							<div class="container text-center">
								<img src="Images\<%=c.getCategoryImage()%>" class="mt-3 "
									style="max-width: 100%; max-height: 100px; width: auto; height: auto;">
							</div>
							<h6><%=c.getCategoryName()%></h6>
						</div>
					</a>
				</div>

				<%
				}
				%>
			</div>
		</div>
	</div>
	<!-- end of list -->

	

	<!-- latest product listed -->
	<div class="container-fluid py-3 px-3" style="background: #EEF7FF;">
		<div class="row row-cols-1 row-cols-md-4 g-3">
			<div class="col">
				<div class="container text-center px-5 py-5">
					<h1>Latest Products</h1>
				</div>
			</div>
			<%
			for (int i = 0; i < Math.min(3, productList.size()); i++) {
			%>
			<div class="col">
				<a href="viewProduct.jsp?pid=<%=productList.get(i).getProductId()%>"
					style="text-decoration: none;">
					<div class="card h-100">
						<div class="container text-center">
							<img
								src="Images\<%=productList.get(i).getProductImages()%>"
								class="card-img-top m-2"
								style="max-width: 100%; max-height: 200px; width: auto;">
						</div>
						<div class="card-body">
							<h5 class="card-title text-center"><%=productList.get(i).getProductName()%></h5>

							<div class="container text-center">
								<span class="real-price"><%=productList.get(i).getProductPrice()%>&#8378;</span>
								
								
							</div>
						</div>
					</div>
				</a>
			</div>

			<%
			}
			%>
		</div>
	</div>
	<!-- end of list -->
	

	<!-- confirmation message for successful order -->
	<%
	String order = (String) session.getAttribute("order");
	if (order != null) {
	%>
	<script type="text/javascript">
		console.log("testing..4...");
		Swal.fire({
		  icon : 'success',
		  title: 'Order Placed, Thank you!',
		  text: 'Confirmation will be sent to <%=user.getUserEmail()%>',
		  width: 600,
		  padding: '3em',
		  showConfirmButton : false,
		  timer : 3500,
		  backdrop: `
		    rgba(0,0,123,0.4)
		  `
		});
	</script>
	<%
	}
	session.removeAttribute("order");
	%>
	<!-- end of message -->

</body>
</html>