<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 쇼핑몰 메인 페이지 : 상품이 나열되는 페이지 --%>
<%-- 상품의 분류별 전체 보기 --%>
<style>
/* 상품 분류*/
.t_category { margin-top: 30px;}
.t_category h3 { text-align: center;}
.d_category1 { clear: both; text-align: right; padding-bottom: 10px; margin-left: 20px;}
.d_category1 .s_category1 { display: inline-block; float: left;}
.d_category1 .s_category11 { font-size: 1.1em; color: navy;}
.d_category2 { margin-left: 20px; margin-bottom: 10px; clear: both;}
.d_category1 .s_category2 select { margin-right: 20px; width: 200px; height: 25px;}
/* 상품 분류별 노출*/
.d_category3 { position: relative;  text-align: center; float: left; font-size: 0.9em; margin-bottom: 0;}
.d_category3 a { text-decoration: none; color: #000;}
.c_product { display: inline-block; width: 250px; height: 350px; margin: 25px;}
.d_category2 .s_category21 { color: #f1617d;}
.c_product .c_p1 { height: 280px; line-height: 280px; overflow: hidden;}
.c_product .c_p1 img { width: 100%; vertical-align: middle;}
.c_product .c_p2, .c_product .c_p4 { font-weight: bold;}
.c_product .c_p3 { font-size: 0.95em; color: #868e96;}
.c_product .c_p2, .c_product .c_p3 { white-space: nowrap; overflow: hidden; text-overflow: ellipsis;}
.c_product .c_p2:hover, .c_product .c_p3:hover { white-space: nowrap; overflow: visible;}
.c_product .s_p_discount { clolor: #f00;}
/* hover 효과*/
.c_product2 { display: none;}
.c_product2 .c_p5, .c_product2 .c_p6 { display: none;}
.d_category3:hover .c_product2 { position: absolute; top: 0; left: 0; background: rgba(0,0,0,0.3); text-align: center; line-height: 350px;
display: inline-block; width: 250px; height: 350px; padding: 10px; margin: 10px;}
.d_category3:hover .c_p5, .d_category3:hover .c_p6 { display: inline-block; width: 70px; height: 70px; border: 2px solid #fff; background-color: rgba(255, 255,255,0.3);
border-radius: 50%; margin: 145px 5px 0 5px; text-align: center; line-height: 70px; font-size: 0.9em; font-weight: bold; color: #fff;}
.d_category3:hover .c_p5 a, .d_category3:hover .c_p6 a { color: white;}
/* 하단 - 페이징 영역*/
#paging { clear: both; text-align: center; margin-top: 20px;}
#paging a { color: #000;}
#pBox { display: inline-block; width: 22px; height: 22px; padding: 5px; margin: 5px;}
#pBox:hover { background: #868e96; color: white; font-weight: bold; border-radius: 10px;}
.pBox_c { background: #f1617d; color: white; font-weight: 900; border-radius: 10px;}
.pBox_b { font-weight: 900;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function(){
	let product_category = document.getElementById("product_category");
		
		// 상품 분류 선택에 대한 change 이벤트 처리
		product_category.addEventListener("change", function(event){
			// 상품 분류 선택시에 select의 option의 변경
			for(let i=0; i<product_category.length; i++){
				if(product_category[i] == event.currentTarget.options[event.currentTarget.options.selectedIndex].value){
					product_category[i].selected = true;
					break;
				}
			}
			location = 'shopAll.jsp?product_category=' + product_category.value + "#t_category";
		})
	})
</script>
	<%
	request.setCharacterEncoding("utf-8");
	
	String product_category = request.getParameter("product_category");
	if(product_category == null) product_category = "111";
	
	// 상품 분류별 상품명 설정
	String product_categoryName = "";
	switch(product_category){
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
	// ###############페이징 처리
	int pageSize = 12; // 페이지당 12건
	String pageNum = request.getParameter("pageNum"); // 페이지 번호
	if(pageNum == null) pageNum = "1"; // 페이지번호가 없다면 1
	
	int currentPage = Integer.parseInt(pageNum); // 현재 페이지
	int startRow = (currentPage - 1) * pageSize + 1; // 첫번째 행
	int endRow = currentPage * pageSize; // 마지막 행
	// ##################	
	DecimalFormat df = new DecimalFormat("#,###,###");
	
	ProductDAO productDAO = ProductDAO.getInstance(); 
	
	// 분류별 상품에 대한 페이징 처리
	List<ProductDTO> productList = productDAO.getProductList(startRow, pageSize, product_category);
	int cnt = productDAO.getProductCount(product_category);
	
	%>
	<%-- 분류별 상품을 4개씩 3단으로 처리 --%>
	<div class="t_category" id="t_category">
		<%for(ProductDTO product : productList) {%>
		<div class="d_category3">
				<div class="c_product">
					<div class="c_p1"><img src="/images_jspmall/<%=product.getProduct_image1()%>"><br></div>
					<div class="c_p2"><span title="<%=product.getProduct_name()%>"><%=product.getProduct_name() %></span><br></div>
					<div class="c_p3"><span title="<%=product.getProduct_brand()%>"><%=product.getProduct_brand() %></span> | <span title="<%=product.getProduct_brand()%>"><%=product.getProduct_brand() %></span></div>
					<div class="c_p4"><span><%=df.format(product.getProduct_price()) %></span>원 | <span class="s_p_discount"><%=product.getDiscount_rate() %>%</span></div>
				</div>
				<div class="c_product2">
	                <div class="c_p5"><a href="../buy/buyForm.jsp?product_id=<%=product.getProduct_id()%>&part=1">구매</a></div>
	                <div class="c_p6"><a href="shopContent.jsp?product_id=<%=product.getProduct_id()%>">상세</a></div>
	            </div>
			<%-- </a>--%>
		</div>
		<%} %>
		
		<%-- 페이징처리 --%>
		<div id="paging">
			<%
			if(cnt>0){
				int pageCount = cnt / pageSize + (cnt%pageSize==0 ? 0 : 1); // 전체 페이지 수
				int startPage = 1;
				int pageBlock = 3;
				
				// 시작페이지 설정
				if(currentPage % pageBlock != 0) startPage = (currentPage/pageBlock) * pageBlock + 1;
				else startPage = (currentPage/pageBlock-1) * pageBlock + 1;
				// 끝페이지 설정
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) endPage = pageCount;
				
				// 첫 페이지로 이동 처리
				if(startPage > pageBlock){
					out.print("<a href='shopAll.jsp?pageNum=1&product_category=" + product_category + "' ><div id='pBox' class='pBox_b' title='첫페이지'>" + "<<" + "</div></a>");
				}
				// 이전 페이지 이동 처리
				if(startPage > pageBlock){
					out.print("<a href='shopAll.jsp?pageNum="+(currentPage-pageBlock) + "&product_category=" + product_category + "' title='이전페이지'><div id='pBox' class='pBox_b'>" + "<" + "</div></a>");
				}
				// 페이징 블럭 출력 처리
				for(int i = startPage; i<endPage+1; i++){
					if(currentPage == i){ // 선택된 페이지가 현재 페이지일때
						out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");	
					} else{ // 다른 페이지일때 이동링크설정
						out.print("<a href='shopAll.jsp?pageNum=" + i + "&product_category=" + product_category + "' ><div id='pBox'>" + i + "</div></a>");
					}
					
				}
				// 다음 페이지 이동 처리
				if(endPage < pageCount){
					if(currentPage + pageBlock > pageCount){
						out.print("<a href='shopAll.jsp?pageNum=" + (pageCount) + "&product_category=" + product_category + "' title='다음페이지'><div id='pBox' class='pBox_b'>" + ">" + "</div></a>");
					} else{
						out.print("<a href='shopAll.jsp?pageNum=" + (currentPage + pageBlock) + "&product_category=" + product_category + "' title='다음페이지'><div id='pBox' class='pBox_b'>" + ">" + "</div></a>");
					}
					
				}
				
				// 맨 끝페이지로 이동 처리
				if(endPage < pageCount){
					out.print("<a href='shopAll.jsp?pageNum=" + (pageCount) + "&product_category=" + product_category + "' title='마지막페이지'><div id='pBox' class='pBox_b'>" + ">>" + "</div></a>");
					
				}
			}
			%>
		</div>
		<%-- 분류 및 이동 --%>
		<div class="d_category1">
			<span class="s_category1"><b class="s_category21"><%=product_categoryName%></b></span>분야 상품 목록
			<span class="s_category2">
				<select id="product_category">
					<option value="" disabled>100 - 전통 한복</option>
					<option value="" disabled>--110 - 여자</option>
					<option value="111" <%if(product_category.equals("111")) {%> selected <%} %>>------ 물실크</option>
					<option value="112" <%if(product_category.equals("112")) {%> selected <%} %>>------ 본견모시</option>
					<option value="" disabled>--120 - 남자</option>
					<option value="121" <%if(product_category.equals("121")) {%> selected <%} %>>------ 물실크</option>
					<option value="122" <%if(product_category.equals("122")) {%> selected <%} %>>------ 본견모시</option>
					<option value="" disabled>--130 - 배자/쾌자</option>
					<option value="131" <%if(product_category.equals("131")) {%> selected <%} %>>------ 배자/쾌자</option>
					<option value="" disabled>200 - 개량한복</option>
					<option value="" disabled>--210 - 여성 저고리</option>
					<option value="211" <%if(product_category.equals("211")) {%> selected <%} %>>------ 민소매 여성 저고리</option>
					<option value="212" <%if(product_category.equals("212")) {%> selected <%} %>>------ 반팔 여성 저고리</option>
					<option value="213" <%if(product_category.equals("213")) {%> selected <%} %>>------ 긴팔 여성 저고리</option>
					<option value="" disabled>--220 - 여성 치마</option>
					<option value="221" <%if(product_category.equals("221")) {%> selected <%} %>>------ 짧은 치마</option>
					<option value="222" <%if(product_category.equals("222")) {%> selected <%} %>>------ 긴 치마</option>
					<option value="223" <%if(product_category.equals("223")) {%> selected <%} %>>------ 겨울용 치마</option>
					<option value="" disabled>--230 - 여성 원피스</option>
					<option value="231" <%if(product_category.equals("231")) {%> selected <%} %>>------ 여성 원피스</option>
					<option value="" disabled>--240 - 남성 생활한복</option>
					<option value="241" <%if(product_category.equals("241")) {%> selected <%} %>>------ 반팔 남성 생활한복</option>
					<option value="242" <%if(product_category.equals("242")) {%> selected <%} %>>------ 긴팔 남성 생활한복</option>
					<option value="" disabled>300 - 궁중 한복</option>
					<option value="300" <%if(product_category.equals("300")) {%> selected <%} %>>------ 궁중 한복</option>
					<option value="" disabled>400 - 아동 한복</option>
					<option value="" disabled>--410 - 여아 한복</option>
					<option value="" disabled>--420 - 남아 한복</option>
					<option value="411" <%if(product_category.equals("411")) {%> selected <%} %>>------ 여아 한복</option>
					<option value="421" <%if(product_category.equals("421")) {%> selected <%} %>>------ 남아 한복</option>
					<option value="500" <%if(product_category.equals("500")) {%> selected <%} %>>------ 장신구</option>
					<option value="600" <%if(product_category.equals("600")) {%> selected <%} %>>------ 공예품</option>
				</select>
			</span>
		</div>
		<div class="d_category2">총 <%=cnt/pageSize+1 %> 페이지  - <b class="s_category2"><%=pageNum %></b>/<%=cnt/pageSize+1 %></div>
		
	</div>