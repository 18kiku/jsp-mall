<%@page import="mall.member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%request.setCharacterEncoding("utf-8"); %>
	
	<%-- 1단계 : 수정정보를 액션태그로 받음 --%>
	<jsp:useBean id="member" class="mall.member.MemberDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="member"/>
	
	<%
	// 주소 처리 : 도로명 주소 + 상세 주소
	String address2 = request.getParameter("address2");
	String address = member.getAddress() + " " + address2;
	member.setAddress(address);
	int cnt = 0;
	// DB 테이블처리
	if(address2 == null){ // 주소를 변경하지 않을 경우
		MemberDAO memberDAO = MemberDAO.getInstance();
		cnt = memberDAO.updateMember2(member);
	} else { // 주소를 변경할 경우
		MemberDAO memberDAO = MemberDAO.getInstance();
		cnt = memberDAO.updateMember(member);
	}
	%>
	<script>
	<% if(cnt > 0){ %> <%-- 수정 성공 --%>
			alert('회원 정보 수정에 성공하였습니다.');
	<%} else {%> <%-- 수정 실패 --%>
			alert('회원 정보 수정에 실패하였습니다.');
	<%} %>
	history.back();
	</script>
</body>
</html>