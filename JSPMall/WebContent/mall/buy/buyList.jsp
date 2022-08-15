<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page import="mall.buy.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최종 구매 확인 폼</title>
<style>
.container { width: 1200px; margin: 0 auto;}
.buy_list { width: 100%;}
/* 상단 - d1 */
.d1 { width: 40%; padding: 15px; margin: 15px 45px; float: right; display: inline-block;}
.d1 .s1 { font-size: 1.1em; font-weight: bold; margin-right: 30px;}
.d1 .s2, .d1 .s3 { display: inline-block; width: 120px; text-align: center; font-size: 0.8em; font-weight: bold; padding: 6px 17px; border: 1px solid #333; border-radius: 15px;}
.d1 .s2 { background: #2f9e77; color: #fff; z-index: 10; position: relative;}
.d1 .s3 { background: #fff; color: #333; margin-left: -30px; z-index: -10; position: relative;}
/* 상단 - d2 */
.d2 { width: 40%; padding: 15px; margin: 5px 45px; float: left; display: inline-block; text-align: left;}
.d2 .d2_1 { font-size: 1.1em; font-weight: bold;}
.d_line { clear: both; width: 90%; border: 1px solid lightgray;}
/* 중단 - d3(구매목록)*/
.d3 { width: 100%; text-align: right; padding-right: 20px;}
.d3 .d3_1 { font-size: 1.1em; font-weight: bold; color: #32708d; text-align: right;}
.d3 .d3_2 { }
.d3 .d3_2 a { text-decoration: none; color: #32708d; font-size: 0.95em; font-weight: bold;
display: inline-block; width: 60px; height: 15px; padding: 5px; border-radius: 1px solid #32708d;}
/* 중단 - d4(구매목록)*/
.d4 { margin-bottom: 50px;}
.d4 .t1 { width: 90%; border: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both;}
.d4 .t1 tr { height: 40px;}
.d4 .t1 th, .d3 .t1 td { border: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.d4 .t1 th { background: #f1f3f5; color: #000;}
.left { text-align: left; padding-left: 10px;}
.right { text-align: right; padding-right: 30px;}
.center { text-align: center; padding: 5px;}
.t1 .s1 a { text-decoration: none; color: gray; font-weight: bold;}
.t1 .s2 a { text-decoration: none; color: #32708d; font-weight: bold;}
.t1 .s2 b { color: #f00;}
.t1 .s22 { color: #f00; font-weight: bold;}
.t1 .s3 { color: #99424f; font-weight: bold;}
.t1 .s4 { color: #1e9faa; font-weight: bold;}
.t1 .s5 { color: #1e94be; font-weight: bold;}
.t1 .s6, .t1 .s7 { margin-top: 5px;}
.t1 .s6 input, .t1 .s7 input { width: 70px; height: 25px; border-radius: 3px; border: none; font-weight: bold; font-size: 0.8em;
cursor: pointer;}
.t1 .s6 input { background: #000; color: #fff;}
.t1 .s7 input { background: #f1d3f5; color: #000;}
</style>
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


String period1 = "";
String period2 = "";
BuyDAO buyDAO = BuyDAO.getInstance();
List<BuyDTO> buyList = buyDAO.getBuyList(memberId);

if(request.getParameter("period1") != null) {
	period1 = request.getParameter("period1");
	period2 = request.getParameter("period2");
	
	// 오늘 날짜
	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH) + 1;
	int date = c.get(Calendar.DATE);
	String now = year + "-" + (month<10 ? "0" + month : month) + "-" + date;
	
	String[] sep = {"day", "day","day","month","month","month","month","year","year"};
	int[] p1 = {0, -7, -14, -1, -2, -3, -6, -1, -2};
	String[] days = new String[9];

	for(int i=0; i<p1.length; i++){
		switch(sep[i]){
		case "day": c.add(Calendar.DATE, p1[i]); break;
		case "month": c.add(Calendar.MONTH, p1[i]); break;
		case "year": c.add(Calendar.YEAR, p1[i]); break;
		}
		year = c.get(Calendar.YEAR);
		month = c.get(Calendar.MONTH) + 1;
		date = c.get(Calendar.DATE);
		days[i] = year + "-" + (month<10 ? "0" + month : month) + "-" + (date < 10 ? "0" + date : date);
	}
	
	switch(period1){
	case "one_day": period1 = days[0]; break;
	case "one_week": period1 = days[1]; break;
	case "two_week": period1 = days[2]; break;
	case "one_month": period1 = days[3]; break;
	case "two_month": period1 = days[4]; break;
	case "three_month": period1 = days[5]; break;
	case "six_month": period1 = days[6]; break;
	case "one_year": period1 = days[7]; break;
	case "two_year": period1 = days[8]; break;
	}
	
	if(period2.equals("now")) period2 = now;
	buyList = buyDAO.getBuyListSearch(period1, period2, memberId);
}
SimpleDateFormat sdf = new SimpleDateFormat("YY-MM-dd");
DecimalFormat df = new DecimalFormat("#,###,###");

int tot1 = 0;
int tot2 = 0;
int cnt = 0;
String order_id = "";

%>
<div class="container">
	<jsp:include page="../common/shopTop.jsp"/>
	<div class="buy_list">
		<div class="d1">
		</div>
		<div class="d2">
			<span class="d2_1">구매정보</span>
		</div>
		<hr class="d_line">
		<div class="d3"> <!-- 날짜별 구매정보 검색 -->
			<div class="d3_1">구매 목록 검색</div>
			<div class="d3_2">
				<a href="buyList.jsp?period1=one_day&period2=now">오늘</a>
				<a href="buyList.jsp?period1=one_week&period2=now">1주</a>
				<a href="buyList.jsp?period1=two_week&period2=now">2주</a>
				<a href="buyList.jsp?period1=one_month&period2=now">1개월</a>
				<a href="buyList.jsp?period1=two_month&period2=now">2개월</a>
				<a href="buyList.jsp?period1=three_month&period2=now">3개월</a>
				<a href="buyList.jsp?period1=six_month&period2=now">6개월</a>
				<a href="buyList.jsp?period1=one_year&period2=now">1년</a>
				<a href="buyList.jsp?period1=two_year&period2=now">2년</a>
			</div>
			<div class="d3_3">
				<input type="date" value="period1"> ~ <input type="date" id="period2">
				<input type="button" value="검색" id="btn_search">
			</div>
		</div>
		<hr class="d_line">
		<div class="d4"><!-- 구매 정보 -->	
			<table class="t1">
				<tr>
					<th width="20%">주문일자(주문번호)</th>
					<th colspan=2 width="45%">주문상품</th>
					<th width="10%">구매금액</th>
					<th width="10%">배송비</th>
					<th width="15%">주문상태</th>
				</tr>
				<%if(buyList.size() == 0){%>
				<tr><td colspan="6" class="center">구매 내역이 없습니다.</td></tr>
				<%} else {
				for(BuyDTO buy : buyList){ 
					tot1 = buy.getBuy_price() * buy.getBuy_count();
					tot2 += tot1;
					String buy_id = buy.getBuy_id();
					cnt = buyDAO.getBuyIdCount(buy_id);
					if(!order_id.equals(buy_id)){
						order_id = buy_id;
				%>
				<tr>
					<td class="center">
						<span class="s1"><a href="buyDetail.jsp?buy_id=<%=buy.getBuy_id()%>"><%=sdf.format(buy.getBuy_date()) %><br>(<%=buy.getBuy_id() %>)</a></span>
					</td>
					<td width="8%" class="left">
						<a href="buyDetail.jsp?buy_id=<%=buy.getBuy_id()%>"><img src="/images_jspmall/<%=buy.getProduct_image() %>" width="60" height="60"></a>
					</td>
					<td width="35%" class="left">
						<span class="s2"><a href="buyDetail.jsp?buy_id=<%=buy.getBuy_id()%>"><%=buy.getProduct_name() %> <b>(총 <%=cnt %>종)</b></a></span>
					</td>
					<td width="15%" class="right"><span class="s3"><%=df.format(tot2) %>원</span></td>
					<td class="center"><span class="s4">무료</span></td>
					<td class="center">
						<div class="s5"><%=buy.getDelivery_state() %></div>
						<div class="s6"><input type="button" class="btn_delivery" value="배송조회"></div>
						<div class="s7"><input type="button" class="btn_review" value="리뷰작성"></div>
						
					</td>
				</tr>
				<%
					if(order_id.equals(buy_id)) cnt = 0;
				} } } %>
			</table>
		</div>
	</div>
	<jsp:include page="../common/shopBottom.jsp"/>
</div>
</body>
</html>