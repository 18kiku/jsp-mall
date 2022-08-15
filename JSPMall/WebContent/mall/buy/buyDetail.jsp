<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="mall.buy.BuyDTO"%>
<%@page import="java.util.List"%>
<%@page import="mall.buy.BuyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 아이디별 상세보기</title>
<style>
.container { width: 1200px; margin: 0 auto;}
.buy_detail { width: 100%}
/* d1 - 상품 상세 보기*/
.d1 { margin-bottom: 50px;}
.d1 .t1 { width: 90%; border: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both;}
.d1 .t1 tr { height: 40px;}
.d1 .t1 th, .d1 .t1 td { border: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.d1 .t1 th { background: #1e94be; color: #fff; text-shadow: 1px 1px 1px gray;}
.left { text-align: left; padding-left: 10px;}
.right { text-align: right; padding-right: 30px;}
.center { text-align: center; padding: 5px;}
.t1 .s1 { color: gray;}
.t1 .s3 a { text-decoration: none; color: #32708d; font-weight: bold;}
.t1 .s4, .t1 .s5 { color: #c8s557; font-weight: bold;}
.t1 .s6 { color: #99424f; font-weight: bold; font-size: 1.2em;}
.t1 .s7 { color: #1e9faa; font-weight: bold;}
/* d2 - 총 구매 정보*/
.d2 { margin-bottom: 50px;}
.d2 .t2 { width: 90%; border: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both;}
.d2 .t2 tr { height: 40px;}
.d2 .t2 th, .d2 .t2 td { border: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.d2 .t2 th { background: #1e94be; color: #fff; text-shadow: 1px 1px 1px gray;}
.left { text-align: left; padding-left: 10px;}
.right { text-align: right; padding-right: 30px;}
.center { text-align: center; padding: 5px;}
.t2 tr:nth-of-type(2) { height: 80px;}
.t2 .s1 { font-size: 1.2em; color: #32708d; font-weight: bold;}
.t2 .s2 { font-size: 1.2em; color: #99424f; font-weight: bold;}
.t2 input[type=button] { width: 120px; height: 40px; background: #2f9e77; color: #fff; font-weight: bold; font-size: 1.1em;
border-radius: 5px; border: none; cursor: pointer;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let btn_buy_list = document.getElementById("btn_buy_list");
		btn_buy_list.addEventListener("click", function(){
			location= "buyList.jsp";
		})
	})
	
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}

SimpleDateFormat sdf = new SimpleDateFormat("MM월 dd일");
DecimalFormat df = new DecimalFormat("#,###,###");

String buy_id = request.getParameter("buy_id");
BuyDAO buyDAO = BuyDAO.getInstance();
List<BuyDTO> buyListDetail = buyDAO.getBuyListDetail(buy_id);
/*
for(BuyDTO buy : buyListDetail){
	System.out.println(buy);
}
*/
int tot1 = 0;
int tot2 = 0;
int cnt1 = buyListDetail.size();
int cnt2 = 0;
String order_id = "";
%>
<div class="container">
	<jsp:include page="../common/shopTop.jsp"/>
	<div class="buy_detail">
		<table class="t1">
			<tr>
				<th width="20%">주문일자(주문번호)</th>
				<th colspan=2 width="45%">주문상품</th>
				<th width="10%">구매금액</th>
				<th width="10%">배송비</th>
				<th width="15%">주문상태</th>
			</tr>
			<%for(BuyDTO buy : buyListDetail) {
				tot1 = buy.getBuy_price() * buy.getBuy_count();
				tot2 += tot1;
			%>
			
			<tr>
				<td class="center"><span><%=buy.getBuy_id() %></span></td>
				<td width="8%" class="left">
					<span class="s1"><a href="../shopping/shopContent.jsp?product_id=<%=buy.getProduct_id()%>"><img src="/images_jspmall/<%=buy.getProduct_image()%>" width="60" height="90"><%=buy.getProduct_image() %></a></span>
				</td>
				<td width="29%" class="left">
					<span class="s2"><a href="../shopping/shopContent.jsp?product_id=<%=buy.getProduct_id()%>"><%=buy.getProduct_name() %></a></span>
				</td>
				<td class="right"><span class="s3"><%=buy.getBuy_price() %></span></td>
				<td class="center"><span class="s4"><%=buy.getBuy_count() %></span></td>
				<td class="center"><span class="s5">무료</span></td>
				<td class="center"><span class="s6"><%=buy.getDelivery_state() %></span></td>
			<tr>
			<%} %>
		</table>
	</div>
	<div class="d2">
		<table class="t2">
			<tr>
				<th colspan="">구매 정보 확인</th>
			</tr>
			<tr>
				<td class="center" width="40%">
					<span class="s1">구매 상품 종류 : <%=cnt1 %>건<br>총 구매 수량: <%=cnt2 %>개</span>
				</td>
				<td class="center" width="40%"><span>총 구매 금액 : <%=df.format(tot2) %>원</span></td>
				<td class="center" width="20%">
					<input type="button" id="btn_buy_list" value="구매 목록">
				</td>
			</tr>
		</table>
	
	</div>
	<jsp:include page="../common/shopBottom.jsp"/>
</div>
</body>
</html>