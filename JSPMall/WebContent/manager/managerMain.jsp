<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 관리자 페이지</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hammersmith+One&family=Paytone+One&display=swap');
#container {width: 400px; margin: 0 auto;}
a { text-decoration: none; color: black;}
/* 상단의 메인, 서브 타이틀*/
.m_title { font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title { font-family: 'Do Hyeon', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px}
.c_logout { text-align: right; margin-bottom: 20px; font-size: 0.9em; font-weight: bold;}
.c_logout a { color: #99424f;}
/* 테이블 메뉴*/
table { width: 100%; border-collapse: collapse;
border-top: 3px solid gray; border-bottom: 3px solid gray; border-left: hidden; border-right: hidden;}
tr { height: 50px;}
th { border: 1px solid black;}
.title_row { background: rgba(204, 255, 204, 0.5);}
.a_row { background: #f8f9fa;}
</style>
<script>

</script>
</head>
<%-- 바로접속이되면안됨. 세션이없으면 로그인페이지로 강제이동 --%>
<body>
	<%
	String managerId = (String)session.getAttribute("managerId");
	if(managerId == null){
		out.print("<script>location='logon/managerLoginForm.jsp';</script>");
	}
	%>
	<div id="container">
		<div class="m_title"><a href="#">JSPMall</a></div>
		<div class="s_title">관리자 페이지</div>
		<div class="c_logout"><a href="logon/managerLogout.jsp">로그아웃</a></div>
		<table>
			<tr class="title_row"><th>상품 관리</th></tr>
			<tr class="a_row"><th><a href="product/productRegisterForm.jsp">상품 등록</a></th></tr>
			<tr class="a_row"><th><a href="product/productList.jsp">상품 목록(수정/삭제)</a></th></tr>
			<tr class="title_row"><th>주문 관리</th></tr>
			<tr class="a_row"><th><a href="">주문 목록(수정/삭제)</a></th></tr>
			<tr class="title_row"><th>회원 관리</th></tr>
			<tr class="a_row"><th><a href="">회원 목록(수정/삭제)</a></th></tr>
		</table>
	</div>
</body>
</html>