<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hammersmith+One&family=Paytone+One&display=swap');
#container {width: 550px; margin: 0 auto;}
a { text-decoration: none; color: black;}
/* 상단의 메인, 서브 타이틀*/
.m_title { font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title { font-family: 'Do Hyeon', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px}
a { text-decoration: none; color: #59637f; font-size: 0.95em; font-weight: bold;}
.c_logout { text-align: right; margin-bottom: 20px; font-size: 0.9em; font-weight: bold;}
.c_logout a { color: #99424f;}
/* 중단 - 상품 등록 테이블 */
table { width: 100%; border: 1px solid gray; border-collapse: collapse;
border-top: 3px solid #2f9e77; border-bottom: 3px solid #2f9e77; border-left: hidden; border-right: hidden;}
tr { height: 35px;}
td, th { border: 1px solid #2f9e77; }
th { background: #d8f4e6;}
td { padding-left: 5px;}
/* 중단  - 테이블 안의 입력상자 */
input[type="number"] { width: 100px;}
textarea { margin-top: 5px;}
/* 하단 - 버튼 */
select { height: 24px;}
input::file-selector-button { width: 95px; height: 28px; background: #2f9e77; color: #fff; border: none;
border-radius: 3px; font-weight: bold; cursor: pointer;}
.btns { text-align: center; margin-top: 10px;}
.btns input { width: 100px; height: 37px; border: none; background: #495057; color: #fff; 
font-weight: bold; margin: 5px; cursor: pointer;}
.btns input:nth-child(1) { background: #2f9e77;}
.btns input:nth-child(1):hover { border: 2px solid #2f9e77; background: #fff; color: #2f9e77; font-weight: bold;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let form = document.registerForm;
		let btn_register = document.getElementById("btn_register");
		//상품등록페이지로이동
		btn_register.addEventListener("click", function(){
			if(!form.product_name.value){
				alert('상품명을 입력해주세요')
				return;
			}
			if(!form.product_price.value){
				alert('상품 가격을 입력해주세요')
				return;
			}	
			if(!form.product_stock.value){
				alert('상품 수량을 입력해주세요')
				return;
			}		
			if(!form.product_detail.value){
				alert('상품내용을 입력해주세요')
				return;
			}
			if(!form.product_brand.value){
				alert('브랜드를 입력해주세요')
				return;
			}
			if(!form.product_size.value){
				alert('사이즈를 입력해주세요')
				return;
			}
			if(!form.product_color.value){
				alert('색상을 입력해주세요')
				return;
			}
			if(!form.discount_rate.value){
				alert('할인율을 입력해주세요')
				return;
			}
			if(confirm("등록하시겠습니까?")) form.submit();	
			else return;
			
		})
		
		// 상품 목록 페이지로 이동
		let btn_list = document.getElementById("btn_list");
		btn_list.addEventListener("click", function(){
			location = 'productList.jsp';
		})
		
		// 관리자 페이지로 이동
		let btn_main = document.getElementById("btn_main");
		btn_main.addEventListener("click", function(){
			location = '../managerMain.jsp';
		})
	})
</script>
</head>
<%--


 --%>
<body>
	<%
	String managerId = (String)session.getAttribute("managerId");
	if(managerId == null) {
		out.print("<script>");
		out.print("location='../logon/managerLoginForm.jsp';");
		out.print("</script>");
	}
	%>

	<div id="container">
		<div class="m_title"><a href="../managerMain.jsp">JSPMall</a></div>
		<div class="s_title">상품 등록</div>
		
		<form action="productRegisterPro.jsp" method="post" name="registerForm" enctype="multipart/form-data">
			<table>
				<tr>
					<th width="20%">상품분류</th>
					<td>
						<select name="product_category">
							<option value="" disabled selected>---상품을 선택해주세요---</option>
							<option value="" disabled>100 - 전통 한복</option>
							<option value="" disabled>--110 - 여자</option>
							<option value="111">------ 물실크</option>
							<option value="112">------ 본견모시</option>
							<option value="" disabled>--120 - 남자</option>
							<option value="121">------ 물실크</option>
							<option value="122">------ 본견모시</option>
							<option value="" disabled>--130 - 배자/쾌자</option>
							<option value="131">------ 배자/쾌자</option>
							<option value="" disabled>200 - 개량한복</option>
							<option value="" disabled>--210 - 여성 저고리</option>
							<option value="211">------ 민소매 여성 저고리</option>
							<option value="212">------ 반팔 여성 저고리</option>
							<option value="213">------ 긴팔 여성 저고리</option>
							<option value="" disabled>--220 - 여성 치마</option>
							<option value="221">------ 짧은 치마</option>
							<option value="222">------ 긴 치마</option>
							<option value="223">------ 겨울용 치마</option>
							<option value="" disabled>--230 - 여성 원피스</option>
							<option value="231">------ 여성 원피스</option>
							<option value="" disabled>--240 - 남성 생활한복</option>
							<option value="241">------ 반팔 남성 생활한복</option>
							<option value="242">------ 긴팔 남성 생활한복</option>
							<option value="" disabled>300 - 궁중 한복</option>
							<option value="300">------ 300 - 궁중 한복</option>
							<option value="" disabled>400 - 아동 한복</option>
							<option value="" disabled>--410 - 여아 한복</option>
							<option value="" disabled>--420 - 남아 한복</option>
							<option value="411">------ 여아 한복</option>
							<option value="421">------ 남아 한복</option>
							<option value="500" >500 - 장신구</option>
							<option value="600" >600 - 공예품</option>
							<option value="" disabled></option>
							<option value="" disabled></option>
							<option value="" disabled></option>
							<option value="" disabled></option>
							<option value="" disabled></option>
						</select>
					</td>	
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text" name="product_name" size=56></td>
				</tr>
				<tr>
					<th>브랜드</th>
					<td><input type="text" name="product_brand" size=56></td>
				</tr>
				<tr>
					<th>사이즈</th>
					<td><input type="text" name="product_size" size=56></td>
				</tr>
				<tr>
					<th>색상</th>
					<td><input type="text" name="product_color"></td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td><input type="number" name="product_price" min="1000" max="1000000">원</td>
				</tr>
				<tr>
					<th>상품 수량</th>
					<td><input type="number" name="product_stock" min="0" max="100000" size=30></td>
				</tr>
				<tr>
					<th>상품 이미지</th>
					<td><input type="file" name="product_image1"></td>
				</tr>
				<tr>
					<th>상품 이미지</th>
					<td><input type="file" name="product_image2"></td>
				</tr>
				<tr>
					<th>상품 이미지</th>
					<td><input type="file" name="product_image3"></td>
				</tr>
				<tr>
					<th>상품 설명</th>
					<td><input type="file" name="product_detail"></td>
				</tr>
				<!-- <tr>
					<th>상품 내용</th>
					<td><textarea name="product_detail" rows="13" cols="58"></textarea></td>
				</tr> -->
				<tr>
					<th>할인율</th>
					<td><input type="number" name="discount_rate" min="0" max="90" value="10">&ensp;%</td>
				</tr>
			</table>
			<div class="btns">
				<input type="button" value="상품 등록" id="btn_register">
				<input type="reset" value="다시 입력">
				<input type="button" value="상품 목록" id="btn_list">
				<input type="button" value="관리자 페이지" id="btn_main">
			</div>
		</form>
	</div>
</body>
</html>