<%@page import="mall.buy.BuyDTO"%>
<%@page import="java.util.List"%>
<%@page import="mall.buy.BuyDAO"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매목록검색(기간)</title>
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
	
	
	String period1 = request.getParameter("period1");
	String period2 = request.getParameter("period2");
	
	// 오늘 날짜
	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH) + 1;
	int date = c.get(Calendar.DATE);
	String now = year + "-" + (month<10 ? "0" + month : month) + "-" + date;
	
	String[] sep = {"day","day","day","month","month","month","month","year","year"};
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
	
	BuyDAO buyDAO = BuyDAO.getInstance();
	List<BuyDTO> buyListSearch = buyDAO.getBuyListSearch(period1, period2, memberId);
	
	session.setAttribute("buyListSearch", buyListSearch);

%>
</body>
</html>