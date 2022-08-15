<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그아웃</title>
</head>
<body>
	<%
	session.removeAttribute("managerId");
	out.print("<script>");
	out.print("alert('로그아웃되었습니다.');");
	out.print("location='managerLoginForm.jsp';");
	out.print("</script>");
	%>
</body>
</html>