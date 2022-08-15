<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="mall.review.*"%>
<%@page import="mall.member.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Dongle:wght@700&family=Hammersmith+One&family=Koulen&family=Nanum+Gothic+Coding&family=Paytone+One&display=swap');
.container { width: 1200px; margin: 0 auto;}
.d_category { margin: 20px 0;}
.d_category a { text-decoration: none; color: black; font-size: 13px;}
.d_category a:hover { text-shadow: 1px 1px 1px lightgray;}
<%-- 구역 1: 왼쪽 상단 - 상품이미지 --%>
.s1 { width: 50%; float: left; text-align: center;}
.big_imgs { width: 450px; height: 600px; line-height: 300px; padding-left: 100px;}
.big_img { height: auto; overflow: hidden; vertical-align: middle; transition: 0.5s;}
.big_img:hover { transform: scale(1.01);}
.small_imgs { margin: 20px;}
.small_imgs .thumb { width: 60px; height: 100%; overflow: hidden; vertical-align: middle; margin: 0 10px; cursor: pointer;}
.small_imgs .thumb:hover { transform: scale(1.05);}
<%-- 구역 2: 오른쪽 상단 - 상품 기본 정보 --%>
.s2 { width: 44%; float: left; background: none; padding: 30px 30px 0 30px;}
.s2 > div { padding-bottom: 5px; margin-bottom: 30px; border-bottom: 1px solid lightgray;}
.s2 > div:last-child { border: none;}
.s2_d1 { font-size: 1.1em; font-weight: bold; color: #black;}
.s2_d2 { font-size: 0.9em; color: gray;}
.s2 .ss { display: inline-block; width: 100px; font-size: 0.9em; color: gray;}
.s2_d3 span:nth-child(2) { color: gray;}
.s2_d4 span:nth-child(2), .s2_d5 span:nth-child(2) { color: #000;}
.s2_d4 b { font-weight: bold; }
.s2_d7 span:not(.ss){ font-size: 0.9em; color: gray;}
.s2_d7 b { font-size: 1.05em; color: #000;}
.s2_d8 span:nth-child(2) { font-size: 0.9em; color: gray;}
.s2_d9 span:nth-child(2) { font-size: 0.9em; color: gray;}
.btns { margin-top: 50px; text-align: center;}
.btns input { width: 240px; height: 60px; border: 0; font-size: 1.1em; cursor: pointer;}
.btns #btn_cart { background: #fff; color: #000; border: 2px solid #000; margin-right: 10px;}
.btns #btn_cart:hover { background: #fff; color: #000; border: 2px solid #000; font-weight: bold;}
.btns #btn_buy { background: #000; color: #fff; margin-left: 10px;}
.btns #btn_buy:hover { background: #fff; color: #000; border: 2px solid #000; font-weight: bold;}
<%-- 구역 3: 하단 - 상품 내용, 리뷰 --%>
.t_line { border: 1px solid #e9ecef; margin: 30px 0; clear: both;}
.s3_c1 { background: none; padding: 10px; border-radius: 5px; margin-bottom: 30px; border-bottom: 1px solid lightgray;}
.s3_c1 span { display: inline-block; width: 120px; height: 30px; padding: 10px; margin: 0 20px; border: 2px solid #000;
text-align: center; line-height: 30px; border-radius: 5px; color: #000; font-size: 1.1em; cursor: pointer;}
.s3_c1 span:hover { border: 2px solid #000; font-weight: bold;}
.s3_c1 a { color: #000;}
.s3_c2 { line-height: 40px; text-align: center; padding: 20px;}

.s3_c3 .s3_review { padding: 20px; line-height: 27px; text-align: justify; width: 100%; height: 200px; margin-bottom: 20px;}
.s3_review .s3_r1 { width: 75%; float: left; border: 1px solid none; padding: 20px; background: rgba(0,0,0,0.1); margin-right: 20px;}
.s3_r1 .s3_subject { font-size: 1.1em; font-weight: bold; margin-bottom: 10px;}
.s3_r1 .s3_content { width: 100%; height: 110px; white-space: pre-line; overflow: hidden;}
.s3_r1 .s3_content_toggle { font-size: 0.9em; color: #1e94be; cursor: pointer;}
.s3_review .s3_r2 { width: 16%; float: right; border: 1px solid #f1f3f5; padding: 20px; background: #f8f9fa;}

.s3_r2 { font-size: 0.9em; color: gray; height: 80px;}

/* 하단 - 페이징 영역*/
#paging { clear: both; text-align: center; margin-top: 20px;}
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
		// 이미지 변화 효과
		let big_img = document.querySelector(".big_img");
		let thumb_imgs = document.querySelectorAll(".thumb");
		for(let thumb of thumb_imgs){
			thumb.addEventListener("mouseover", function(){
				big_img.src = thumb.src;
			})	
		}
		// 상품 수량을 100 미만으로 제한하는 효과
		let buy_count = document.getElementById("buy_count");
		buy_count.addEventListener("keyup", function(event){
			if(buy_count.value < 1) buy_count.value = 1;
			else if(buy_count.value > 99){
				buy_count.value = 99;
			}
		})
		
		// 장바구니 주문하기 버튼
		let form = document.contentForm;
		let btn_cart = document.getElementById("btn_cart");
		let btn_buy = document.getElementById("btn_buy");
		btn_cart.addEventListener("click", function(){
			if(!confirm('상품을 장바구니에 담았습니다.\n이동하시겠습니까?')) {
				return;
			} else {
				form.submit();
			}
		})
		btn_buy.addEventListener("click", function(){
			if(!confirm('주문하시겠습니까?')) {
				return;
			} else {
				form.action = "../buy/buyForm.jsp?product_id=" + form.product_id.value + "&buy_count=" + form.buy_count.value + "&part=2";
				form.submit();
			}
		})
		
		// 하단 상세 설명
		let s3_c2 = document.querySelector(".s3_c2");
		let s3_c3 = document.querySelector(".s3_c3");
		let ss1 = document.querySelector(".ss1");
		let ss2 = document.querySelector(".ss2");
		ss1.addEventListener("click", function(){
			s3_c2.style.display = "block";
			s3_c3.style.display = "none";
		})
		ss2.addEventListener("click", function(){
			s3_c2.style.display = "none";
			s3_c3.style.display = "block";
		})
		
		
		// 내용 전체 보기 효과
		let content = document.querySelectorAll(".s3_content");
		let content_toggle = document.querySelectorAll(".s3_content_toggle");
		let flag = false;
		for(let i in content_toggle){
			content_toggle[i].addEventListener("click", function(){
				if(!flag){
					content[i].style.overflow = "visible";
					content[i].style.height = "200px";
					content_toggle[i].innerHTML = "접기";
					flag = true;
				} else {
					content[i].style.overflow = "hidden";
					content[i].style.height = "110px";
					content_toggle[i].innerHTML = "내용 전체 보기  ∨";
					flag = false;
				}
				
			})	
		}
		
	})
</script>
<%
String memberId = (String)session.getAttribute("memberId");
int product_id = Integer.parseInt(request.getParameter("product_id"));

DecimalFormat df = new DecimalFormat("#,###,###");

// 상품 DB 연결, 질의
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);

// 회원 DB 연결, 질의 - 세션의 여부 확인
MemberDAO memberDAO = null;
MemberDTO member = null;
String name = null;
String address = null;
String local = null;
String d_day = null;
if(memberId != null){
	memberDAO = MemberDAO.getInstance();
	member = memberDAO.getMember(memberId);
	name = member.getName();
	address = member.getAddress();
	local = address.substring(0, 2); // 주소에서 지역 2글자만 추출, ex) 서울, 경기, 대구, 제주...
	// 배송 날짜 계산과 포맷
	// 
	// 토요일, 일요일 제외
	// 규칙 1. 서울 : 다음날 배송, 경기 : 2일 이내 배송, 지방 : 3일 이내 배송, 제주도 및 도서지역 : 10일 이내 배송
	// 규칙 2. 토요일 일요일은 제외
	// 현재날짜와 시간, 요일판단, 주소 판단
	// 월 : 
	int n = 0; // 추가되는 날짜
	Calendar c = Calendar.getInstance();
	int w = c.get(Calendar.DAY_OF_WEEK); // 요일 1~7, 1:일, 2:월, ... , 7:토

	switch(local){
	case "서울":
		if(w>=2 && w<=5) n++;
		else if(w == 6 || w == 7) n += 3;
		else if(w == 1) n += 2;
		break;
	case "경기":
		if(w >= 2 && w <=4) n += 2;
		else if(w == 5 && w == 7) n += 4;
		else if(w == 1) n += 3;
		break;
	case "제주":
		n += 7;
		break;
	default: // 지방
		if(w == 2 || w == 3) n += 3;
		else if(w >= 4 && w <= 6) n += 5;
		else if(w == 1) n += 4;
		break;
	}

	// 추가된 일수를 더한 날짜
	c.add(Calendar.DATE, n);
	int month = c.get(Calendar.MONTH) + 1; // 0~11로 표현이라 1을 더해서 보정
	int date = c.get(Calendar.DATE);
	int week = c.get(Calendar.DAY_OF_WEEK); // 1~7로 표현
	String[] weekday = {"", "일", "월", "화", "수", "목", "금", "토"};

	// 배송일 확인
	d_day = month + "월 " + date + "일 " + weekday[week] + "요일";
	System.out.println(month + "월" + date + "일" + weekday[week] + "요일");
	System.out.println("요일 " + w);
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");

//###############페이징 처리
int pageSize = 5; // 페이지당 5건
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1"; // 페이지번호가 없다면 1

int currentPage = Integer.parseInt(pageNum); // 현재 페이지
int startRow = (currentPage - 1) * pageSize + 1; // 첫번째 행
int endRow = currentPage * pageSize; // 마지막 행
//##################	

// 리뷰 DB 연결, 질의

ReviewDAO reviewDAO = ReviewDAO.getInstance();
List<ReviewDTO> reviewList = reviewDAO.getReviewList(1, 10, product_id);
int cnt = reviewDAO.getReviewCount(product_id);



// 상품 분류별 상품명 설정
String product_categoryName = "";
String product_category = product.getProduct_category();
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
// 출판일 출력 설정
//String p_date = product.getPublishing_date();
//String publishing_date = p_date.substring(0, 4) + "년" + p_date.substring(5, 7) + "월" + p_date.substring(8, 9) + "일";

// 판매가 계산
int price = product.getProduct_price();
int d_rate = product.getDiscount_rate();
int sale_price = price - (price*d_rate/100);

// 개인 쇼핑몰에서 이미지가 5장이고, 1번만 not null이고, 나머지는 nothing.jpg가 저장되어있다고 가정할때
/*
String product_image1 = product.getProduct_image1();
if(product.getProduct_image2().equals("nothing.jpg")) product.setProduct_image2(product.getProduct_image1())
*/
%>

</head>
<body>
<div class="container">
	<jsp:include page="../common/shopTop.jsp"/>
		<div class="d_category"><a href="shopAll.jsp#t_category">홈</a>&ensp;>&ensp;<a href="shopAll.jsp?product_category=<%=product_category%>#t_category"><%=product_categoryName %></a></div>
		<div class="c_detail">
			<%-- 구역 1: 왼쪽 상단 - 상품이미지 --%>
			<div class="s1">
				<div class="big_imgs"><img src="/images_jspmall/<%=product.getProduct_image1() %>" width="450" height="600" class="big_img"></div>
				<div class="small_imgs">
					<img src="/images_jspmall/<%=product.getProduct_image1() %>" width="60" height="80" class="thumb">
					<img src="/images_jspmall/<%=product.getProduct_image2() %>" width="60" height="80" class="thumb">
					<img src="/images_jspmall/<%=product.getProduct_image3() %>" width="60" height="80" class="thumb">
				</div>
			</div>
			<%-- 구역 2: 오른쪽 상단 - 상품 기본 정보 --%>
			<form action="../cart/cartInsertPro.jsp" method="post" name="contentForm">
				<%-- cart_id, buy_count를 제외한 5가지 필드 정보--%>
				<input type="hidden" name="buyer" value="<%=memberId%>">
				<input type="hidden" name="product_id" value="<%=product_id%>">
				<input type="hidden" name="product_name" value="<%=product.getProduct_name()%>">
				<input type="hidden" name="product_price" value="<%=product.getProduct_price() %>">
				<input type="hidden" name="discount_rate" value="<%=product.getDiscount_rate() %>">
				<input type="hidden" name="buy_price" value="<%=sale_price%>">
				<input type="hidden" name="product_image" value="<%=product.getProduct_image1()%>">
				<div class="s2">
					<div class="s2_d1"><%=product.getProduct_name() %></div>
					<div class="s2_d2"><span class="ss">브랜드</span><span><%=product.getProduct_brand() %></span></div>
					<div class="s2_d8"><span class="ss">사이즈</span><span><%=product.getProduct_size() %></span></div>
					<div class="s2_d9"><span class="ss">색상</span><span><%=product.getProduct_color() %></span></div>
					<div class="s2_d3"><span class="ss">정가</span><span><%=df.format(product.getProduct_price()) %>원</span></div>
					<div class="s2_d4"><span class="ss">판매가</span><span><b><%=df.format(sale_price) %>원</b></span></div>
					<div class="s2_d5"><span class="ss">할인율</span><span><b><%=product.getDiscount_rate() %>%</b></span></div>
					<div class="s2_d6"><span class="ss">구매수량</span><input type="number" name="buy_count" id="buy_count" value="1" min="1" max="99"></div>
					<div class="s2_d7"><span class="ss">배송안내</span><br><br>
						<%if(memberId != null){ %>
						<span><b><%=name %></b>님의 주소로 <b><%=d_day %></b>까지 배송됩니다.</span><br><br>
						<span>주소 : <b><%=address %></b></span>
						<%} else {%>
						<span>
							배송일은 서울은 익일, 경기는 2일, 지방은 3일, 제주 및 도서지역은 평균 5일이 소요됩니다.<br><br>
							단, 토요일, 일요일은 쉽니다.
						</span>
						<%} %>
					</div>
					<div class="s2_d8"><span class="ss">배송비</span><span>무료</span></div>
					<div class="btns">
						<input type="button" value="장바구니" id="btn_cart">
						<input type="button" value="주문하기" id="btn_buy">
					</div>	
				</div>
				
			</form>
			<hr class="t_line">
			<%-- 구역 3: 하단 - 상품 내용, 리뷰 --%>
			<div class="s3">
				<div class="s3_c1">
					<span class="ss1"><a href="#s2">상세설명</a></span>
					<span class="ss2"><a href="#s3">리뷰</a></span>
					<span class="ss3">상품문의</span>
					<span class="ss4">교환/반품</span>
				</div>
				<h3>상세정보</h3>
				<hr>
				<div class="s3_c2" id="s2"><img src=<%="/images_jspmall/" + product.getProduct_detail() %>></div>
				<h3>리뷰</h3>
				<hr>
				<div class="s3_c3" id="s3">
					<%for(ReviewDTO review : reviewList) {%>
					<div class="s3_review">
						<div class="s3_r1">
							<div class="s3_subject"><%=review.getSubject() %></div>
							<div class="s3_content"><%=review.getContent() %></div>
							<div class="s3_content_toggle">내용 전체 보기 ∨</div>
						</div>
						<div class="s3_r2">
							<div>작성자 : <%=review.getMember_id() %></div>
							<div>등록일자 : <%=sdf.format(review.getRegDate()) %></div>
							<div>조회수 : <%=review.getReadcount() %></div>
						</div>
					</div>
					<%} %>
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
								out.print("<a href='shopContent.jsp?pageNum=1&product_category=" + product_category + "&product_id=" + product_id + "#s3' ><div id='pBox' class='pBox_b' title='첫페이지'>" + "<<" + "</div></a>");
							}
							// 이전 페이지 이동 처리
							if(startPage > pageBlock){
								out.print("<a href='shopContent.jsp?pageNum="+(currentPage-pageBlock) + "&product_category=" + product_category + "&product_id=" + product_id + "#s3' title='이전페이지'><div id='pBox' class='pBox_b'>" + "<" + "</div></a>");
							}
							// 페이징 블럭 출력 처리
							for(int i = startPage; i<endPage+1; i++){
								if(currentPage == i){ // 선택된 페이지가 현재 페이지일때
									out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");	
								} else{ // 다른 페이지일때 이동링크설정
									out.print("<a href='shopContent.jsp?pageNum=" + i + "&product_category=" + product_category + "&product_id=" + product_id + "#s3' ><div id='pBox'>" + i + "</div></a>");
								}
								
							}
							// 다음 페이지 이동 처리
							if(endPage < pageCount){
								if(currentPage + pageBlock > pageCount){
									out.print("<a href='shopContent.jsp?pageNum=" + (pageCount) + "&product_category=" + product_category + "&product_id=" + product_id + "#s3' title='다음페이지'><div id='pBox' class='pBox_b'>" + ">" + "</div></a>");
								} else{
									out.print("<a href='shopContent.jsp?pageNum=" + (currentPage + pageBlock) + "&product_category=" + product_category + "&product_id=" + product_id + "#s3' title='다음페이지'><div id='pBox' class='pBox_b'>" + ">" + "</div></a>");
								}
								
							}
							
							// 맨 끝페이지로 이동 처리
							if(endPage < pageCount){
								out.print("<a href='shopContent.jsp?pageNum=" + (pageCount) + "&product_category=" + product_category + "&product_id=" + product_id + "#s3' title='마지막페이지'><div id='pBox' class='pBox_b'>" + ">>" + "</div></a>");
								
							}
						}
						%>
					</div>
				</div>
				
			</div>
		</div>
		<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp"/>
</div>
</body>
</html>
