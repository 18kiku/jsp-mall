<%@page import="mall.member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdCheck</title>
</head>
<body>
<%
		String id = request.getParameter("id");
		// ID 중복 체크 처리 페이지
		MemberDAO memberDAO = MemberDAO.getInstance();
		boolean chk = memberDAO.memberIdCheck(id);
		
		out.print("<script>");
		if (chk) { // 아이디가 있음
			out.print("alert(`중복된 아이디입니다.\n다른 아이디를 입력해주세요.`);");
		} else { // 아이디가 없음 -> 사용할 수 있는 아이디
			out.print("alert('사용할 수 있는 아이디입니다.');");
		}
	
		out.print("history.back();");
		out.print("</script>");
		
	%>
</body>
</html>