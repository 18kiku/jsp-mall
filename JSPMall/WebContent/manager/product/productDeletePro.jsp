<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="manager.product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제 처리</title>
</head>
<body>
	<%
	String pageNum = request.getParameter("pageNum");
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	ProductDAO productDAO = ProductDAO.getInstance();
	productDAO.deleteProduct(product_id);
	response.sendRedirect("productList.jsp?pageNum=" + pageNum);
	%>
</body>
</html>