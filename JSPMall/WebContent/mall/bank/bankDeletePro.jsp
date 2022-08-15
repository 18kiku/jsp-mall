<%@ page import="mall.bank.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}
String cart_id = null;
String product_id = null;
String buy_count = null;
String card_no = null;
String part = null;

cart_id = request.getParameter("cart_id");
product_id = request.getParameter("product_id");
buy_count = request.getParameter("buy_count");
card_no = request.getParameter("card_no");
part = request.getParameter("part");

BankDAO bankDAO = BankDAO.getInstance();
bankDAO.deleteBank(memberId, card_no);

if(cart_id != null){
	response.sendRedirect("../buy/buyForm.jsp?cart_id=" + cart_id);
} else if(product_id != null){
	response.sendRedirect("../buy/buyForm.jsp?product_id=" + product_id + "&buy_count=" + buy_count + "&part=" + part);
}
%>
</body>
</html>