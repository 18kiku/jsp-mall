<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="manager.product.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hammersmith+One&family=Paytone+One&display=swap');
#container {width: 1200px; margin: 0 auto;}
a { text-decoration: none; color: black;}
/* 상단의 메인, 서브 타이틀*/
.m_title { font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title { font-family: 'Do Hyeon', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px}
a { text-decoration: none; color: #59637f; font-size: 0.95em; font-weight: bold;}
/* 상단 - 전체 상품 수, 아이디, 로그아웃, 상품등록 */
.top_info { margin-bottom: 10px; text-align: right;}
.c_cnt { float: left;}
.c_cnt, .c_managerId { color: #59637f; font-size: 0.95em; font-weight: bold;}
.c_managerId { clear: both;}
.c_logout a { color: #99424f;}
/* 상단 - 검색 */
.top_search { margin-bottom: 10px;}
.c_select { width: 153px; height: 25px;}
.c_input { width: 280px; height: 19px;}
.c_submit { width: 82px; height: 27px; border: none; background: #000; color: #fff;
font-size: 0.8em; font-weight: bold; border-radius: 5px; cursor: pointer;}

/* 중단 - 상품 정보 테이블*/
table { width: 100%; border: 1px solid black; border-collapse: collapse; font-size: 0.9em;}
tr { height: 30px;}
tr:nth-child(2n+1) { background: #f8f9fa}
th, td { border: 1px solid black;}
th { background: #dee2e6;}
.center { text-align: center;}
.left { text-align: left; padding-left: 3px}
.right { text-align: right; padding-right: 5px;}
.p_img { width: 30px; object-fit: cover; }
.icon img { display: inline-block; width: 25px; object-fit: cover;}
.img_update:hover { content: url('../../icons/update-blue.png'); width: 25px; cursor: pointer;}
.img_delete:hover { content: url('../../icons/delete-button-red.png'); width: 25px; cursor: pointer;}
.f_row { text-align: center; font-weight: bold; color: #c84557;}
/* 하단 - 페이징 영영*/
#paging { text-align: center; margin-top: 20px;}
#pBox { display: inline-block; width: 22px; height: 22px; padding: 5px; margin: 5px;}
#pBox:hover { background: #868e96; color: white; font-weight: bold; border-radius: 10px;}
.pBox_c { background: #868e96; color: white; font-weight: bold; border-radius: 10px;}
.pBox_b { font-weight: bold;}
</style>
<script>
</script>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String managerId = (String)session.getAttribute("managerId");
	if(managerId == null){
		out.print("<script>location='../logon/managerLoginForm.jsp';</script>");
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###,###");
	String product_categoryName = "";
	
	// ###############페이징 처리
	int pageSize = 10; //
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) pageNum = "1";
	
	int currentPage = Integer.parseInt(pageNum); // 현재 페이지
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	// 검색 처리 - 검색일때는 search가 1이고, 검색이 아닐때는 search가 0
	
	
	String search = request.getParameter("search");
	String s_search = "";
	String i_search = "";
	if(search == null) {
		search = "0";
	} else {
		s_search = request.getParameter("s_search");
		i_search = request.getParameter("i_search");
	}
	
	// DB 연결, 질의 처리
	ProductDAO productDAO = ProductDAO.getInstance();
	// 전체 상품 수 조회
	int cnt = 0;
	// 전체 상품 조회 - paging 처리, 검색 처리(search가 1이면 검색, search가 0이면 검색이아님)
	List<ProductDTO> productList = null;
	if(search.equals("1")){
		productList = productDAO.getProductList(startRow, pageSize, s_search, i_search);
		cnt = productDAO.getProductCount(s_search, i_search);
	} else if(search.equals("0")){
		productList = productDAO.getProductList(startRow, pageSize);
		cnt = productDAO.getProductCount();
	}
	//System.out.println(productList);
	
	// 매 페이지마다 전체 상품수에 대한 역순
	int number = cnt - (currentPage-1) * pageSize;
	%>
	<div id="container">
		<%-- 상단 : 타이틀 --%>
		<div class="m_title"><a href="../managerMain.jsp">JSPMall</a></div>
		<div class="s_title"><a href="productList.jsp">상품 목록</a></div>
		
		<div class="top_info">
			<span class="c_cnt">전체 상품 수 : <%=cnt %>개</span>
			<span class="c_managerId">관리자</span>&emsp;|&emsp;
			<span class="c_logout"><a href="../logon/managerLogout.jsp">로그아웃</a></span>&emsp;|&emsp;
			<span class="c_register_product"><a href="productRegisterForm.jsp">상품등록</a></span>
		</div>
		<%-- 상단 :  검색 --%>
		<div class="top_search">
			<form action="productList.jsp" method="post" name="searchForm">
				<input type="hidden" name="search" value="1">
				<span class="c_s1">
					<select name="s_search" class="c_select">
						<option selected>상품명</option>
						<option>카테고리</option>
						<option>브랜드</option>
					</select>
				</span>
				<span class="c_s2"><input type="text" name="i_search" class="c_input"></span>
				<span class="c_s3"><input type="submit" value="검색" class="c_submit"></span>
			</form>			
		</div>
		<%-- 중단 : 상품 테이블 --%>
		<table>
			<tr>
				<th width="4%">NO</th>
				<th width="13%">상품분류</th>
				<th width="7%">이미지</th>
				<th width="30%">제목</th>
				<th width="7%">상품가격</th>
				<th width="5%">재고</th>
				<th width="5%">브랜드</th>
				<th width="5%">사이즈</th>
				<th width="5%">색상</th>
				<th width="4%">할인율</th>
				<th width="8%">등록일</th>
				<th width="8%">수정|삭제</th>
			</tr>
			<%if(cnt == 0) { // 등록된 글이 없을때
				out.print("<tr class='f_row'><td colspan='13'>등록된 상품이 없습니다.</td></tr>");
			} else {		// 등록된 글이 있을때
				for(ProductDTO product : productList){
				switch(product.getProduct_category()){
				case "111": product_categoryName = "여자 물실크"; break;
				case "112": product_categoryName = "여자 본견모시"; break;
				case "121": product_categoryName = "남자 물실크"; break;
				case "122": product_categoryName = "남자 본견모시"; break;
				case "131": product_categoryName = "배자/쾌자"; break;
				case "211": product_categoryName = "민소매 여성 저고리"; break;
				case "212": product_categoryName = "반팔 여성 저고리"; break;
				case "213": product_categoryName = "긴팔 여성 저고리"; break;
				case "221": product_categoryName = "짧은 치마"; break;
				case "222": product_categoryName = "긴 치마"; break;
				case "223": product_categoryName = "겨울용 치마"; break;
				case "231": product_categoryName = "여성 원피스"; break;
				case "241": product_categoryName = "반팔 남성 생활한복"; break;
				case "242": product_categoryName = "긴팔 남성 생활한복"; break;
				case "300": product_categoryName = "궁중 한복"; break;
				case "411": product_categoryName = "여아 한복"; break;
				case "421": product_categoryName = "남아 한복"; break;
				case "500": product_categoryName = "장신구"; break;
				case "600": product_categoryName = "공예품"; break;
				}
				%>
				<tr>
					<td class="center"><%=number-- %></td>
					<td class="center"><%=product_categoryName %></td>
					<td class="center">
						<a href="productContent.jsp?product_id=<%=product.getProduct_id()%>&pageNum=<%=pageNum%>">
						<img src=<%="/images_jspmall/" + product.getProduct_image1() %> class="p_img"></a>
					</td>
					<td class="left">
						<a href="productContent.jsp?product_id=<%=product.getProduct_id()%>&pageNum=<%=pageNum%>"><%=product.getProduct_name() %></a>
					</td>
					<td class="right"><%=df.format(product.getProduct_price()) %>원</td>
					<td class="right"><%=df.format(product.getProduct_stock()) %>개</td>
					<td class="center"><%=product.getProduct_brand() %></td>
					<td class="center"><%=product.getProduct_size() %></td>
					<td class="center"><%=product.getProduct_color() %></td>
					<td class="center"><%=product.getDiscount_rate() %>%</td>
					<td class="center"><%=sdf.format(product.getReg_date()) %></td>
					<td class="center icon">
						<a href="productContent.jsp?product_id=<%=product.getProduct_id()%>&pageNum=<%=pageNum%>" title="상품 수정"><img src="../../icons/update-white.png" class="img_update"></a>|
						<a href="productDeletePro.jsp?product_id=<%=product.getProduct_id()%>&pageNum=<%=pageNum%>" id="a_delete" title="상품 삭제"><img src="../../icons/delete-button-white.png" class="img_delete"></a>
					</td>
				</tr>
					
				<%} 
			}%>
			
		</table>
		<%-- 페이징처리 --%>
		<div id="paging">
			<%
			if(cnt>0){
				int pageCount = cnt / pageSize + (cnt%pageSize==0 ? 0 : 1); // 전체 페이지 수
				int startPage = 1;
				int pageBlock = 5;
				
				// 시작페이지 설정
				if(currentPage % pageBlock != 0) startPage = (currentPage/pageBlock) * pageBlock + 1;
				else startPage = (currentPage/pageBlock-1) * pageBlock + 1;
				// 끝페이지 설정
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) endPage = pageCount;
				
				// 첫 페이지로 이동 처리
				if(startPage > pageBlock){
					out.print("<a href='productList.jsp?pageNum=1&search="+search+"&s_search="+s_search+"&i_search="+i_search+"' ><div id='pBox' class='pBox_b' title='첫페이지'>" + "<<" + "</div></a>");
				}
				// 이전 페이지 이동 처리
				if(startPage > pageBlock){
					out.print("<a href='productList.jsp?pageNum="+(currentPage-pageBlock)+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"' title='이전페이지'><div id='pBox' class='pBox_b'>" + "<" + "</div></a>");
				}
				// 페이징 블럭 출력 처리
				for(int i = startPage; i<endPage+1; i++){
					if(currentPage == i){ // 선택된 페이지가 현재 페이지일때
						out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");	
					} else{ // 다른 페이지일때 이동링크설정
						out.print("<a href='productList.jsp?pageNum="+i+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"' alt='그'><div id='pBox'>" + i + "</div></a>");
					}
					
				}
				// 다음 페이지 이동 처리
				if(endPage < pageCount){
					if(currentPage+pageBlock > pageCount){
						out.print("<a href='productList.jsp?pageNum="+(pageCount)+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"' title='다음페이지'><div id='pBox' class='pBox_b'>" + ">" + "</div></a>");
					} else{
						out.print("<a href='productList.jsp?pageNum="+(currentPage+pageBlock)+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"' title='다음페이지'><div id='pBox' class='pBox_b'>" + ">" + "</div></a>");
					}
					
				}
				
				// 맨 끝페이지로 이동 처리
				if(endPage < pageCount){
					out.print("<a href='productList.jsp?pageNum=" + (pageCount) + "&search=" + search + "' title='마지막페이지'><div id='pBox' class='pBox_b'>" + ">>" + "</div></a>");
					
				}
			}
			%>
		</div>
	</div>
</body>
</html>