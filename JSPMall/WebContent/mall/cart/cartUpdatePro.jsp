<%@page import="manager.product.ProductDTO"%>
<%@page import="manager.product.ProductDAO"%>
<%@page import="javax.websocket.SendResult"%>
<%@page import="mall.cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 업데이트</title>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>alert('로그인을 해주세요');location='../logon/memberLoginForm.jsp';</script>");
}

int cart_id = Integer.parseInt(request.getParameter("cart_id"));
int buy_count = Integer.parseInt(request.getParameter("buy_count"));
int product_id = Integer.parseInt(request.getParameter("product_id"));

// Product DB 연동
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);
int product_stock = product.getProduct_stock();
// Cart DB 연동
out.print("<script>");
if(buy_count > product_stock){
	out.print("alert('상품의 재고수량을 초과했습니다. 현재 재고 : " + product_stock + "개\\n수량을 다시 입력해주세요.');");
} else {
	CartDAO cartDAO = CartDAO.getInstance();
	cartDAO.updateCart(cart_id, buy_count);	
}
out.print("location='cartList.jsp';");
out.print("</script>");
%>
</body>
</html>