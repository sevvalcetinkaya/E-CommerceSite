<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Page not found</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
		<div class="container p-5 text-center">
		<img src="Images\error.png" class="img-fluid" style="max-width: 400px;">
		<h1>Sorry! Page not found</h1>
		<a href="index.jsp" class="btn btn-outline-primary btn-lg mt-3">Home
			Page</a>
	</div>

</body>
</html>