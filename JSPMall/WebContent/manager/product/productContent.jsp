<%@page import="java.text.SimpleDateFormat"%>
<%@page import="manager.product.ProductDTO"%>
<%@page import="manager.product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
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
table { width: 100%; border: 1px solid #705e7b; border-collapse: collapse;
border-top: 3px solid #705e7b; border-bottom: 3px solid #705e7b; border-left: hidden; border-right: hidden;}
tr { height: 35px;}
td, th { border: 1px solid #705e7b; }
th { background: #e6c9e1;}
td { padding-left: 5px;}
/* 중단  - 테이블 안의 입력상자 */
.c_p_id, .c_p_reg_date { background: #dee2e6;}
.s_p_id, .s_p_reg_date { color: #f00; font-size: 0.9em; font-weight: bold; margin-left: 10px;}
.s_p_image { color: #00f; font-size: 0.9em;}
input[type="number"] { width: 100px;}
textarea { margin-top: 5px;}
/* 하단 - 버튼 */
select { height: 24px;}
input::file-selector-button { width: 95px; height: 28px; background: #705e7b; color: #fff; border: none;
border-radius: 3px; font-weight: bold; cursor: pointer;}
.btns { text-align: center; margin-top: 10px;}
.btns input { width: 100px; height: 37px; border: none; background: #705e7b; color: #fff; 
font-weight: bold; margin: 5px; cursor: pointer;}
.btns input:nth-child(1), .btns input:nth-child(2) { background: #705e7b;}
.btns input:nth-child(1):hover, .btns input:nth-child(2):hover { border: 2px solid #2f9e77; background: #fff; color: #2f9e77; font-weight: bold;}

</style>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let form = document.updateForm;
		let product_id = form.product_id.value;
		let pageNum = form.pageNum.value;
		// 상품 분류
		let product_category = form.product_category; // select 
		let p_category = form.p_category.value;			// ex) 자기계발 : 310이 있는 option
		for(let i=0; i<product_category.length; i++){
			if(p_category == product_category[i].value) {
				  product_category[i].selected = true;
			}
		}
		
		let btn_update = document.getElementById("btn_update"); 
		//상품 수정처리페이지
		btn_update.addEventListener("click", function(){
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
			if(confirm("정말 수정하시겠습니까?")) form.submit();	
			else return;
			
		})
		
		// 상품 삭제 처리 페이지로 이동
		let btn_delete = document.getElementById("btn_delete");
		btn_delete.addEventListener("click", function(){
			if(confirm("정말 삭제하시겠습니까?")) {
				location = 'productDeletePro.jsp?product_id=' + product_id + "&pageNum=" + pageNum; 	
			}
			else return;
		})
		
		// 상품 목록 페이지로 이동
		let btn_list = document.getElementById("btn_list");
		btn_list.addEventListener("click", function(){
			location = 'productList.jsp?&pageNum=' + pageNum;
		})
		
		// 관리자 페이지로 이동
		let btn_main = document.getElementById("btn_main");
		btn_main.addEventListener("click", function(){
			location = '../managerMain.jsp';
		})
	})
</script>
</head>
<body>
	<%
	String managerId = (String)session.getAttribute("managerId");
	if(managerId == null){
		out.print("<script>location='../logon/managerLoginForm.jsp';</script>");
	}
		
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) pageNum = "1";
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	
	ProductDAO productDAO = ProductDAO.getInstance();
	ProductDTO product = productDAO.getProduct(product_id);
	System.out.println(product);
	%>
	<div id="container">
		<div class="m_title"><a href="../managerMain.jsp">JSPMall</a></div>
		<div class="s_title">상품 정보 확인</div>
		
		<form action="productUpdatePro.jsp" method="post" name="updateForm" enctype="multipart/form-data">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<table>
				<tr>
					<th>상품번호</th>
					<td>
						<input type="text" name="product_id" value="<%=product.getProduct_id()%>" size=10 readonly class="c_p_id">
						<span class="s_p_id">상품번호는 변경불가</span>
					</td>
				</tr>
				<tr>
					<th width="20%">상품분류</th>
					<td width="80%">
						<input type="hidden" name="p_category" value="<%=product.getProduct_category()%>">
						<select name="product_category">
							<option value="" disabled>---상품을 선택해주세요---</option>
							<option value="" disabled>100 - 전통 한복</option>
							<option value="" disabled>--110 - 여자</option>
							<option value="111" <%if(product.getProduct_category().equals("111")) {%> selected <%} %>>------ 물실크</option>
							<option value="112" <%if(product.getProduct_category().equals("112")) {%> selected <%} %>>------ 본견모시</option>
							<option value="" disabled>--120 - 남자</option>
							<option value="121" <%if(product.getProduct_category().equals("121")) {%> selected <%} %>>------ 물실크</option>
							<option value="122" <%if(product.getProduct_category().equals("122")) {%> selected <%} %>>------ 본견모시</option>
							<option value="" disabled>--130 - 배자/쾌자</option>
							<option value="131" <%if(product.getProduct_category().equals("131")) {%> selected <%} %>>------ 배자/쾌자</option>
							<option value="" disabled>200 - 개량한복</option>
							<option value="" disabled>--210 - 여성 저고리</option>
							<option value="211" <%if(product.getProduct_category().equals("211")) {%> selected <%} %>>------ 민소매 여성 저고리</option>
							<option value="212" <%if(product.getProduct_category().equals("212")) {%> selected <%} %>>------ 반팔 여성 저고리</option>
							<option value="213" <%if(product.getProduct_category().equals("213")) {%> selected <%} %>>------ 긴팔 여성 저고리</option>
							<option value="" disabled>--220 - 여성 치마</option>
							<option value="221" <%if(product.getProduct_category().equals("221")) {%> selected <%} %>>------ 짧은 치마</option>
							<option value="222" <%if(product.getProduct_category().equals("222")) {%> selected <%} %>>------ 긴 치마</option>
							<option value="223" <%if(product.getProduct_category().equals("223")) {%> selected <%} %>>------ 겨울용 치마</option>
							<option value="" disabled>--230 - 여성 원피스</option>
							<option value="231" <%if(product.getProduct_category().equals("231")) {%> selected <%} %>>------ 여성 원피스</option>
							<option value="" disabled>--240 - 남성 생활한복</option>
							<option value="241" <%if(product.getProduct_category().equals("241")) {%> selected <%} %>>------ 반팔 남성 생활한복</option>
							<option value="242" <%if(product.getProduct_category().equals("242")) {%> selected <%} %>>------ 긴팔 남성 생활한복</option>
							<option value="" disabled>300 - 궁중 한복</option>
							<option value="300" <%if(product.getProduct_category().equals("300")) {%> selected <%} %>>------ 300 - 궁중 한복</option>
							<option value="" disabled>400 - 아동 한복</option>
							<option value="" disabled>--410 - 여아 한복</option>
							<option value="" disabled>--420 - 남아 한복</option>
							<option value="411" <%if(product.getProduct_category().equals("411")) {%> selected <%} %>>------ 여아 한복</option>
							<option value="421" <%if(product.getProduct_category().equals("421")) {%> selected <%} %>>------ 남아 한복</option>
							<option value="" disabled>500 - 장신구</option>
							<option value="" disabled>600 - 공예품</option>
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
					<td><input type="text" name="product_name" size=56 value="<%=product.getProduct_name()%>"></td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td><input type="number" name="product_price" min="1000" max="1000000" value="<%=product.getProduct_price()%>">원</td>
				</tr>
				<tr>
					<th>브랜드</th>
					<td><input type="text" name="product_brand" value="<%=product.getProduct_brand()%>">&ensp;%</td>
				</tr>
				<tr>
					<th>사이즈</th>
					<td><input type="text" name="product_size" value="<%=product.getProduct_size()%>">&ensp;%</td>
				</tr>
				<tr>
					<th>색상</th>
					<td><input type="text" name="product_color" value="<%=product.getProduct_color()%>">&ensp;%</td>
				</tr>
				<tr>
					<th>상품 수량</th>
					<td><input type="number" name="product_stock" min="0" max="100000" size=30 value="<%=product.getProduct_stock()%>">개</td>
				</tr>
				<%-- <tr>
					<th>상품 내용</th>
					<td><textarea name="product_detail" rows="13" cols="58"><%=product.getProduct_detail()%></textarea></td>
				</tr> --%>
				<tr>
					<th>상품 이미지1</th>
					<td>
						<input type="file" name="product_image1" value="<%=product.getProduct_image1()%>"><br>
						<span class="s_p_image">상품 이미지를 다시 선택해주세요</span>
					</td> <%--원래 있던 이미지가 자동으로 들어가면 좋겠음 --%>
				</tr>
				<tr>
					<th>상품 이미지2</th>
					<td>
						<input type="file" name="product_image2" value="<%=product.getProduct_image2()%>"><br>
						<span class="s_p_image">상품 이미지를 다시 선택해주세요</span>
					</td> <%--원래 있던 이미지가 자동으로 들어가면 좋겠음 --%>
				</tr>
				<tr>
					<th>상품 이미지3</th>
					<td>
						<input type="file" name="product_image3" value="<%=product.getProduct_image3()%>"><br>
						<span class="s_p_image">상품 이미지를 다시 선택해주세요</span>
					</td> <%--원래 있던 이미지가 자동으로 들어가면 좋겠음 --%>
				</tr>
				<tr>
					<th>상품 설명</th>
					<td>
						<input type="file" name="product_detail" value="<%=product.getProduct_detail()%>"><br>
						<span class="s_p_image">상품 이미지를 다시 선택해주세요</span>
					</td> <%--원래 있던 이미지가 자동으로 들어가면 좋겠음 --%>
				</tr>
				<tr>
					<th>할인율</th>
					<td><input type="number" name="discount_rate" min="0" max="90" value="<%=product.getDiscount_rate()%>">&ensp;%</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>
						<input type="text" name="reg_date" value="<%=sdf.format(product.getReg_date())%>" size="10" readonly class="c_p_reg_date">
						<span class="s_p_reg_date">등록일은 변경 불가</span>
					</td>
					
				</tr>
			</table>
			<div class="btns">
				<input type="button" value="상품 정보 수정" id="btn_update">
				<input type="button" value="상품 정보 삭제" id="btn_delete">
				<input type="button" value="상품 목록" id="btn_list">
				<input type="button" value="관리자 페이지" id="btn_main">
			</div>
		</form>
	</div>
</body>
</html>