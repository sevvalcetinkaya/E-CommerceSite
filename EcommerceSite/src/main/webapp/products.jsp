
<%@page import="com.cds.entities.User"%>
<%@page import="com.cds.dao.CategoryDao"%>
<%@page import="com.cds.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.cds.helper.DBConnection"%>
<%@page import="com.cds.dao.ProductDao"%>
<%
User u = (User) session.getAttribute("activeUser");


String searchKey = request.getParameter("search");
String catId = request.getParameter("category");
CategoryDao categoryDao = new CategoryDao(DBConnection.getConnection());
String message = "";

ProductDao productDao = new ProductDao(DBConnection.getConnection());
List<Product> prodList = null;
if (searchKey != null) {
	if (!searchKey.isEmpty()) {
		message = "Showing results for \"" + searchKey + "\"";
	}else{
		message = "No product found!";
	}
	prodList = productDao.getAllProductsBySearchKey(searchKey);

} else if (catId != null && !(catId.trim().equals("0"))) {
	prodList = productDao.getAllProductsByCategoryId(Integer.parseInt(catId.trim()));
	message = "Showing results for \"" + categoryDao.getCategoryName(Integer.parseInt(catId.trim())) + "\"";
} else {
	prodList = productDao.getAllProducts();
	message = "All Products";
}

if (prodList != null && prodList.size() == 0) {
    String categoryName = "";
    if (searchKey != null) {
        categoryName = searchKey;
    } else if (catId != null && !catId.trim().isEmpty()) {
        try {
            categoryName = categoryDao.getCategoryName(Integer.parseInt(catId.trim()));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.println("Invalid category ID.");
        }
    }

    message = "No items are available for \"" + categoryName + "\"";
    prodList = productDao.getAllProducts();
}

/*if (prodList != null && prodList.size() == 0) {

	message = "No items are available for \""
	+ (searchKey != null ? searchKey : categoryDao.getCategoryName(Integer.parseInt(catId.trim()))) + "\"";

	prodList = productDao.getAllProducts();
}*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
.real-price {
	font-size: 22px !important;
	font-weight: 600;
}

.product-price {
	font-size: 17px !important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 15px !important;
	color: #027a3e;
}

.wishlist-icon {
	cursor: pointer;
	position: absolute;
	right: 10px;
	top: 10px;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	border: 1px solid #f0f0f0;
	box-shadow: 0 1px 4px 0 rgba(0, 0, 0, .1);
	padding-right: 40px;
	background: #fff;
}
</style>
</head>
<body  style="background-color: #f0f0f0;">
		<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!--show products-->
	<h4 class="text-center mt-2"><%=message%></h4>
	<div class="container-fluid my-3 px-5">

		<div class="row row-cols-1 row-cols-md-4 g-3">
			<%
			for (Product p : prodList) {
			%>
			<div class="col">

				<div class="card h-100 px-2 py-2">
					<div class="container text-center">
						<img src="Images\<%=p.getProductImages()%>"
							class="card-img-top m-2"
							style="max-width: 100%; max-height: 200px; width: auto;">
						
						<h5 class="card-title text-center"><%=p.getProductName()%></h5>

						<div class="container text-center">
							<span class="real-price"><%=p.getProductPrice()%>&#8378;</span>&ensp;
							
							
						</div>
						<div class="container text-center mb-2 mt-2">
							<button type="button"
								onclick="window.open('viewProduct.jsp?pid=<%=p.getProductId()%>', '_self')"
								class="btn btn-primary text-white">View Details</button>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>

</body>
</html>