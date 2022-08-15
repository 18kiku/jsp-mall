<%@page import="mall.member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴(삭제)</title>
</head>
<body>
	<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.deleteMember(id, pwd);
	%>
	
	<script>
	<%if(cnt > 0){%>
		alert('회원탈퇴가 완료되었습니다.');
		<%session.removeAttribute("memberId");%>
		location='../shopping/shopAll.jsp';
		se
	<%} else {%>
		alert('회원탈퇴에 실패했습니다.');
		history.back();
	<%} %>
	
	</script>
</body>
</html>