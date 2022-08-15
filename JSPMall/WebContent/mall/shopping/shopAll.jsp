<%@page import="java.util.*"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- bx-slider --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<meta charset="UTF-8">
<title>JSPMALL-Main</title>
<style>
#container { width: 1200px; margin: 0 auto;}
.slider {}
.slider img { vertical-align: middle; }
.main_img { margin-bottom: 100px;}

</style>
<script>
    $(document).ready(function(){
    	$('.slider').bxSlider({
      	  autoControls: true,
      	  stopAutoOnclick: true,
      	  auto: true,
      	  autoHover: true,
      	  speed: 2000,
      	  pause: 3000,
      	  slideWidth: 1200,
      	  slideHeight: 1000,
      	  maxSlides: 1,
      	  minSlides: 1,
      	  moveSlides: 1,
      	  slideMargin: 20,
      	  touchEnabled: false
        });
    });
</script>
</head>
<body>
	<%--쇼핑몰 전체 : 상단 + 메인 + 하단 --%>
	<div id="container">
		
		<div> <%-- 상단 --%>
			<header><jsp:include page="../common/shopTop.jsp"/></header>
		</div>
		<div> <%-- 메인(본문) --%>
			<main>
				<article class="main_img">
					<div class="slider">
						<img src="/images_jspmall/main1.jpg">
						<img src="/images_jspmall/main2.jpg">
						<img src="/images_jspmall/main3.jpg">
					</div>
				</article>
				<article class="category_items"> <%-- 메인4 : 상품 종류별로 볼 수 있도록 --%>
					<jsp:include page="shopMain.jsp"/>
				</article>
			</main>
		</div>
		<div> <%-- 하단 --%>
			<footer><jsp:include page="../common/shopBottom.jsp"/></footer>
		</div>
	
	
	</div>
</body>
</html>