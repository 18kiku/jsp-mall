<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 쇼핑몰 상단 페이지 : 쇼핑몰의 모든 페이지 상단에 포함되는 페이지 --%>

<style>
@import url('https://fonts.googleapis.com/css2?family=Dongle&family=Hi+Melody&family=Jua&family=Zen+Loop&display=swap');
/* 전체 레이아웃 */
a { text-decoration: none; color: black;}
/* .t_box1, .t_box2{ display: inline-block; padding: 2%;} */
.t_box1 { float: left;}
.t_box2 { float: right;}
/* 구역1 (상단좌측): 로그인, 회원가입, 고객센터 */
.t_box1 { }
.t_box1 a { color: gray; font-size: 14px; font-weight: bold;}
/* 구역2 (상단우측): 회원정보, 구매정보, 장바구니정보*/
.t_box2 .t_box2_img1:hover { content: url(../../icons/user-color.png);}
.t_box2 .t_box2_img2:hover { content: url(../../icons/buy-color.png);} 
.t_box2 .t_box2_img3:hover { content: url(../../icons/cart-color.png);}
/* 구역3 (중단): 타이틀, 검색 */
.t_box3 { clear: both; text-align: center; margin-bottom: 20px;}
.t_box3 .m_title { font-family: 'Zen Loop', cursive; font-size: 50px;}
.t_box3 .s_title { font-family: 'Hi Melody', cursive; font-size: 20px;}

/* 구역4 (하단): 메인메뉴(하위메뉴) */
.t_box4 { text-align: center;}
.t_box4 div { text-align: center; display: inline-block; margin: 0 10px;  padding: 5px; 
color: #000; font-size: 20px; font-family: 'Hi Melody', cursive;}
.t_box4 .hover { position: relative; display: inline-block;}
.t_box4 .sub { width: 140px; display: none; position: absolute; z-index: 10; font-size: 0.3em; background: lightgray;}
.t_box4 .hover:hover .sub { display: block; right: -37px;}
.top_end { clear: both;}
.b_line { border: 1px solid #e9ecef; margin: 20px 0; clear: both;}
</style>
<%
String memberId = (String)session.getAttribute("memberId");
%>
<script>

</script>
<div class="top">
	<%-- 상단 --%>
	<div class="t_box1"> <%-- 구역1 (상단좌측): 로그인, 회원가입, 고객센터 --%>
		<%if(memberId == null) {%>
			<a href="../logon/memberLoginForm.jsp"><span>로그인</span></a>&ensp;|&ensp;
			<a href="../member/memberJoinForm.jsp"><span>회원가입</span></a> &ensp;|&ensp;
		<%} else {%>
		<a href="../member/memberInfoForm.jsp"><%=memberId %>님</a>&ensp;|&ensp;<a href="../logon/memberLogout.jsp">로그아웃</a>&ensp;|&ensp;
		<%} %>
		<a href="#"><span>고객센터</span></a>
	</div>
	<div class="t_box2"> <%-- 구역2 (상단우측): 회원정보, 구매정보, 장바구니정보 --%>
		<a href="../member/memberInfoForm.jsp"><img src="../../icons/user-white.png" width="35" title="회원정보" class="t_box2_img1"></a>
		<a href="../buy/buyList.jsp"><img src="../../icons/buy-white.png" width="35" title="구매정보" class="t_box2_img2"></a>
		<a href="../cart/cartList.jsp"><img src="../../icons/cart-white.png" width="35" title="장바구니정보" class="t_box2_img3"></a>
	</div>
	<div class="t_box3"> <%-- 구역3 (중단): 타이틀, 검색 --%>
		<div class="m_title"><a href="../shopping/shopAll.jsp">JSPMALL</a></div>
		<div class="s_title">JSP 쇼핑몰</div>
		<div class="t_search">
			<!-- <form action="" method="post" name="searchForm">
				<input type="search" name="keyword" id="keyword">
				<button type="submit"><img src="../../icons/search.png" width="10" title="검색"></button>
			</form> -->
			
		</div>
	</div>
	<%-- 하단 --%>
	<div class="t_box4"> <%-- 구역4 (하단): 메인메뉴(하위메뉴) --%>
		<div class="hover">
			<div class="m_menu1 main"><a href="#">전통한복</a></div>
			<div class="s_menu1 sub">
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=111">여성한복</a></div>
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=121">남성한복</a></div>
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=131">배자/쾌자</a></div>
			</div>
		</div>
		<div class="hover">
			<div class="m_menu2 main"><a href="#">개량한복</a></div>
			<div class="s_menu2 sub">
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=211">여성 저고리</a></div>
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=221">여성 치마</a></div>
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=231">여성 원피스</a></div>
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=241">남성 생활한복</a></div>
			</div>
		</div>
		<div class="hover">
			<div class="m_menu3 main"><a href="#">궁중한복</a></div>
			<div class="s_menu3 sub">
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=300">궁중한복</a></div>
			</div>
		</div>
		<div class="hover">
			<div class="m_menu4 main"><a href="#">아동한복</a></div>
			<div class="s_menu4 sub">
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=411">여아 한복</a></div>
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=421">남아 한복</a></div>
			</div>
		</div>
		<div class="hover">
			<div class="m_menu5 main"><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=500">장신구</a></div>
			<div class="s_menu5 sub">
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=500">장신구</a></div>
			</div>
		</div>
		<div class="hover">
			<div class="m_menu6 main"><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=600">공예품</a></div>
			<div class="s_menu6 sub">
				<div><a href="/JSPMall/mall/shopping/shopList.jsp?product_category=600">공예품</a></div>
			</div>
		</div>
	</div>
	<div class="top_end"></div>
	
	<hr class="b_line">
	
</div>