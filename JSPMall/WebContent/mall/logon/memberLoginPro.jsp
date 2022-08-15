<%@page import="mall.member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.login(id, pwd);
	
	out.print("<script>");
	if(cnt==1){
		session.setAttribute("memberId", id);
		out.print("location='../shopping/shopAll.jsp'");
	} else if(cnt==0){
		out.print("alert('비밀번호가 일치하지 않습니다.');history.back();");
	} else if(cnt==-1){
		out.print("alert('아이디가 존재하지 않습니다.');history.back();");
	}
	out.print("</script>");%>
</body>
</html>