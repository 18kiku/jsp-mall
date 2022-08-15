<%@page import="java.util.Dictionary"%>
<%@page import="manager.product.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="mall.member.MemberDTO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="mall.bank.BankDAO"%>
<%@page import="mall.bank.BankDTO"%>
<%@page import="mall.cart.CartDTO"%>
<%@page import="mall.member.MemberDAO"%>
<%@page import="mall.cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 확인 폼</title>
<style>
.container { width: 1200px; margin: 0 auto;}
.buy_form { width: 100%;}
/* 상단 - d1 */
.d1 { width: 40%; padding: 15px; margin: 15px 45px; float: right; display: inline-block;}
.d1 .s1 { font-size: 1.1em; font-weight: bold; margin-right: 30px;}
.d1 .s2, .d1 .s3 { display: inline-block; width: 120px; text-align: center; font-size: 0.8em; font-weight: bold; padding: 6px 17px; border: 1px solid #333; border-radius: 15px;}
.d1 .s2 { background: #443cc3; color: #fff; z-index: 10; position: relative;}
.d1 .s3 { background: #fff; color: #333; margin-left: -30px; z-index: -10; position: relative;}
/* 상단 - d2 */
.d2 { width: 40%; padding: 15px; margin: 5px 45px; float: left; display: inline-block; text-align: left;}
.d2 span:last-child { font-weight: bold;}
.d_line { clear: both; width: 90%; border: 1px solid lightgray;}
/* 중단 - d3, 구매정보확인 (장바구니 또는 상품상세) */
.d3 .t1 { width: 90%; border: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both;}
.d3 .t1 tr { height: 40px;}
.d3 .t1 th, .d3 .t1 td { border: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.d3 .t1 th { background: #f1f3f5; color: #000;}
.d3 .t1 input[type=number] { width: 60px;}
.left { text-align: left; padding-left: 10px;}
.right { text-align: right; padding-right: 10px;}
.center { text-align: center;}
/* number 화살표 보이도록 */
.d3 input[type="number"]::-webkit-inner-spin-button, 
.d3 input[type="number"]::-webkit-outer-spin-button { -webkit-appearance: "Always Show Up/Down Arrows"; opacity: 1;}
.d3 a { text-decoration: none; color: #32708d;}
.d3 .s1 { color: #32708d; font-weight: bold; font-size: 1.1em; margin-bottom: 10px; display: inline-block;}
.d3 .s2 { color: #adb5bd; font-size: 0.95em;}
.d3 .s3 { color: #1e94be; font-weight: bold;}
.d3 .s4 { color: #c84557; font-weight: bold;}
.d3 .s6 { color: #99424f; font-weight: bold;}
/* 중단 - d4, 총 구매정보 */
.d4 { margin-top: 10px;}
.d4 .t2 { width: 90%; border: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both;}
.d4 .t2 tr { height: 60px;}
.d4 .t2 th, .d4 .t2 td { border: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.d4 .t2 th { background: #f1f3f5; font-size: 1.1em; color: #000;}
.d4 .t2 td { text-align: center; background: #fff;}
.d4 .s1 { color: #c84557; font-size: 1.2em; font-weight: bold;}
.d4 .s2 { color: #1e94be; font-size: 1.2em; font-weight: bold;}
.d4 .s3 { color: #99424f; font-size: 1.5em; font-weight: bold;}
.d4 .s4, .d4 .s5 { color: #1e94be; font-size: 1.1em; font-weight: bold;}
/* 중단 - d5 배송 정보 */
.d5 { margin-top: 20px;}
.d5 .t3 { width: 90%; border: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both;}
.d5 .t3 tr { height: 60px;}
.d5 .t3 th, .d5 .t3 td { border: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.d5 .t3 th:nth-of-type(1) { background: #f1f3f5; font-size: 1.1em; color: #000;}
.d5 .t3 td { text-align: left; background: #fff; padding-left: 20px;}
.d5 .t3 input { margin: 5px 0; height: 25px;}
.d5 .t3 .add1, .d5 .t3 .add2 { width: 600px;}
.d5 .t3 span { color: #707fa0; font-weight: bold; margin-right: 20px;}
.d5 .t3 #btn_address { border: lightgray; color: #000; border-radius: 3px; width: 100px; height: 30px;
font-size: 0.95em; font-weight: bold; cursor: pointer;}
/* 중단 - d6, 주문자 정보 */
.d6 { margin-top: 20px;}
.d6 .t4 { width: 90%; border: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both;}
.d6 .t4 tr { height: 60px;}
.d6 .t4 th, .d6 .t4 td { border: 1px solid #f1f3f5; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.d6 .t4 th:nth-of-type(1) { background: #f1f3f5; font-size: 1.1em; color: #000;}
.d6 .t4 td { text-align: left; background: #fff; padding-left: 20px;}
.d6 .t4 input { margin: 5px 0; height: 25px;}
.d6 .t4 .add1, .d6 .t4 .add2 { width: 600px;}
.d6 .t4 span { color: #707fa0; font-weight: bold; margin-right: 20px;}
.d6 .account { width: 200px; height: 25px;}
#btn_delete_bank, #btn_register_bank { width: 80px; height: 30px; border: lightgray; color: #000; border-radius: 3px; cursor: pointer;}
/* #btn_delete_bank { background: #c84557; border: 1px solid #c84557; margin-left: 67px;}
#btn_register_bank { background: #2f9e77; border: 1px solid #2f9e77; margin-left: 5px;} */
/* 중단 - d7, 최종 결제 정보 */
.d7 { margin: 20px 0;}
.d7 .t5 { width: 90%; border: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both;}
.d7 .t5 tr { height: 60px;}
.d7 .t5 th, .d7 .t5 td { border: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.d7 .t5 tr:nth-of-type(1) { background: #f1f3f5; font-size: 1.1em; color: #000;}
.d7 .t5 tr:nth-of-type(2) { background: #fff; font-size: 1.3em; color: #99424f;}
.d7 input[type=button] { width: 170px; height: 50px; background: #000; border: 2px solid #000; color: #fff; border-radius: 3px; 
font-size: 1.1em; font-weight: bold; cursor: pointer;}
.d7 input[type=button]:hover { background: #fff; border: 2px solid #000; color: #000;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let form = document.buyForm;
		let cart_id = form.cart_id.value;
		let part = form.part.value;
		let product_id = form.product_id.value;
		//수량 제한 효과(1~99)
		let buy_counts = document.querySelectorAll(".buy_count");
		
		for(let buy_count of buy_counts){
			buy_count.addEventListener("keyup", function(){
				if(buy_count.value < 1){
					buy_count.value = 1;
				} else if(buy_count.value >= 100){
					buy_count.value = 99;
				}
			})
		}
		
		// 주소찾기 버튼 - 다음 라이브러리 활용
		let btn_address = document.getElementById("btn_address");
		btn_address.addEventListener("click", function(){
			new daum.Postcode({
				oncomplete:function(data){
					form.delivery_address.value = data.address;
				}
			}).open();
		})
		
		// 카드 삭제 버튼
		let btn_delete_bank = document.getElementById("btn_delete_bank");
		btn_delete_bank.addEventListener("click", function(){
			let account = form.account

			if(!account.value){
				alert("삭제할 카드를 선택해주세요.");
				return;
			}
			
			let value = account.options[account.selectedIndex].value;
			let card_no = value.substring(0, 19);
			account.remove(account.selectedIndex);
			location = "../bank/bankDeletePro.jsp?cart_id=" + cart_id + "&card_no=" + card_no + "&product_id=" + product_id + "&part=" + part;
		})
		
		// 카드 등록 버튼
		let btn_register_bank = document.getElementById("btn_register_bank");
		btn_register_bank.addEventListener("click", function(){
			let card_no = document.querySelector(".card_no").value;
			let card_com = document.querySelector(".card_com").value;
			let member_id = document.querySelector(".member_id").value;
			let member_name = document.querySelector(".member_name").value;

			if(!card_no){
				alert("카드번호를 입력해주세요.");
				return;
			}
			if(!card_com){
				alert("카드사를 입력해주세요.");
				return;
			}
			location = "../bank/bankInsertPro.jsp?cart_id=" + cart_id + "&card_no=" + card_no + "&card_com=" + card_com 
					+ "&member_id=" + member_id + "&member_name=" + member_name + "&product_id=" + product_id + "&part=" + part;
		})
		
		// 최종 결제 버튼
		let btn_buy = document.getElementById("btn_buy");
		btn_buy.addEventListener("click", function(){
			if(!form.delivery_name.value){
				alert("수령인을 입력해주세요.");
				return;
			}
			if(!form.delivery_tel.value){
				alert("연락처를 입력해주세요.");
				return;
			}
			if(!form.delivery_address.value){
				alert("기본 주소를 입력해주세요.");
				return;
			}
			if(!form.delivery_address_detail.value){
				alert("상세주소를 입력해주세요.");
				return;
			}
			if(!form.account.value){
				alert("결제방법을 선택해주세요.");
				return;
			}
			form.submit();
		})
	})
</script>
</head>
<body>
<%
// buyForm.jsp -> 구매 정보 확인 폼(구매 여부를 결정하는 폼), buyList.jsp -> 구매 목록 폼(최종 구매 확인 폼)
request.setCharacterEncoding("utf-8");

String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}
SimpleDateFormat sdf = new SimpleDateFormat("MM월 dd일");
DecimalFormat df = new DecimalFormat("#,###,###");

// #########################
// part=1 -> shopMain.jsp에서 product_id를 가지고 넘어오는 경우
// part=2 -> shopContent.jsp에서 product_id와 buy_count를 가지고 넘어오는 경우
// part=3 -> cartList.jsp에서 cart_id를 가지고 넘어오는 경우

int part = Integer.parseInt(request.getParameter("part"));

// part=1, part=3일때 변수선언
int product_id = 0;
int buy_count = 1;
ProductDAO productDAO = null;

// part = 3일때 변수선언
String cart_id_str = null;
String[] cart_id_arr = null;
List<Integer> cart_id_list = null;
CartDAO cartDAO = null;
List<CartDTO> cartList = null;

if(part == 1 || part == 2){
	product_id = Integer.parseInt(request.getParameter("product_id"));
	if(part==2) buy_count = Integer.parseInt(request.getParameter("buy_count"));
	cartList = new ArrayList<CartDTO>();
	
	productDAO = ProductDAO.getInstance();
	ProductDTO product = productDAO.getProduct(product_id);
	int product_price = product.getProduct_price();
	int discount_rate = product.getDiscount_rate();
	int buy_price = product_price - (product_price * discount_rate / 100); 
	
	CartDTO cart = new CartDTO();
	cart.setBuyer(memberId);
	cart.setProduct_id(product_id);
	cart.setProduct_name(product.getProduct_name());
	cart.setProduct_price(product.getProduct_price());
	cart.setDiscount_rate(product.getDiscount_rate());
	cart.setBuy_price(buy_price);
	cart.setBuy_count(buy_count);
	cart.setProduct_image(product.getProduct_image1());
	cartList.add(cart);
} else if(part ==3){
	// - cart_id를 확인, 배열로 저장 -> 리스트로 저장
	cart_id_str = request.getParameter("cart_id");
	cart_id_arr = cart_id_str.split(",");
	cart_id_list = new ArrayList<Integer>();
	for(String c : cart_id_arr){
		cart_id_list.add(Integer.parseInt(c));
	}
	// 카트 확인
	//System.out.println("카트 배열 : " + Arrays.toString(cart_id_arr));
	//System.out.println("카트 리스트" + cart_id_list);

	// Cart DB 연동 -> cartList에서 넘어오는 정보 -> 1개 또는 여러개
	cartDAO = CartDAO.getInstance();
	cartList = cartDAO.getCartList(cart_id_list);

	// CartList 확인
	/* for(CartDTO c : cartList){
		System.out.println(c);
	} */
}
session.setAttribute("cartList", cartList);
 

// #############################
//Bank DB 연동
BankDAO bankDAO = BankDAO.getInstance();
List<BankDTO> bankList = bankDAO.getBankList(memberId);

// Member DB 연동
MemberDAO memberDAO = MemberDAO.getInstance();
MemberDTO member = memberDAO.getMember(memberId);

String address = member.getAddress();
String local = address.substring(0, 2); // 주소에서 지역 2글자만 추출, ex) 서울, 경기, 대구, 제주...


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
String d_day = month + "월 " + date + "일 (" + weekday[week] + ")";
//System.out.println(month + "월" + date + "일" + weekday[week] + "요일");
//System.out.println("요일 " + w);

// 총 상품금액, 총 할인금액, 총 구매금액, 구매 상품 종류, 구매 상품 개수
int tot1 = 0, tot2 = 0, tot3 = 0, cnt1 = 0, cnt2 = 0;;

%>
<div class="container">
	<jsp:include page="../common/shopTop.jsp"/>
	<div class="buy_form">
		<div class="d1">
			
		</div>
		<div class="d2">
			<a href="/JSPMall/index.jsp">홈</a> > <span>장바구니</span> > <span>결제</span>
		</div>
		<hr class="d_line">
		<form action="buyInsertPro.jsp" method="post" name="buyForm">
		<!-- cart_id, buy_count, account, delivery_name, delivery_tel, delivery_address -->
		<input type="hidden" name="cart_id" id="cart_id" value="<%=cart_id_str%>">
		<input type="hidden" name="part" id="part" value="<%=part%>">
		<input type="hidden" name="product_id" id="product_id" value="<%=product_id %>">
		<div class="d3"> <!-- 카트 정보 -->
			<table class="t1">
				<tr>
					<th colspan="2">상품 정보</th>
					<th>정가</th>
					<th>판매가</th>
					<th>구매수량</th>
					<th>합계</th>
					<th>베송일</th>
				</tr>
				<%for(CartDTO cart : cartList){ 
					int p_sum1 = cart.getProduct_price() * cart.getBuy_count(); // 정가 합계 금액
					int p_sum3 = cart.getBuy_price() * cart.getBuy_count(); // 판매가 합계 금액
					int p_sum2 = p_sum1 - p_sum3; // 할인 금액
					tot1 += p_sum1;
					tot2 += p_sum2;
					tot3 += p_sum3;
					++cnt1;
					cnt2 += cart.getBuy_count();
				%>
				<tr>
					<td width="10%" class="center">
						<a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><img src="/images_jspmall/<%=cart.getProduct_image()%>" width="60" height="60"></a>
					</td>
					<td width="40%" class="left">
						<span class="s1"><a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><%=cart.getProduct_name() %></a></span>
					</td>
					<td width="10%" class="right"><span class="s3"><%=df.format(cart.getProduct_price()) %>원</span></td>
					<td width="10%" class="right"><span class="s4"><%=df.format(cart.getBuy_price()) %>원</span></td>
					<td width="10%" class="center"><span class="s5"><input type="number" name="buy_count" class="buy_count" value="<%=cart.getBuy_count()%>" max="100" min="1"></span></td>
					<td width="10%" class="right"><span class="s6"><%=df.format(p_sum3) %>원</span></td>
					<td width="10%" class="center"><span class="s7"><%=d_day %></span></td>
				</tr>
				<%} %>
			</table>
		</div>
		<div class="d4"> <!-- 구매 총 정보 -->
			<table class="t2">
				<tr>
					<th width="33.4%">총 상품금액</th>
					<th width="33.3%">총 할인금액</th>
					<th width="33.3%">총 구매금액</th>
				</tr>
				<tr>
					<td><span class="s1"><%=df.format(tot1) %></span></td>
					<td><span class="s2"><%=df.format(tot2) %></span></td>
					<td><span class="s3"><%=df.format(tot3) %></span></td>
				</tr>
				<tr>
					<td colspan="3">
						구매 상품 종류 : <span class="s4"><%=cnt1 %>종</span> | <span>구매 상품 개수 : <%=cnt2 %>개</span>
					</td>
				</tr>
			</table>
		</div>
		<div class="d5"> <!-- 배송지 정보 : 변경 가능하도록-->
			<table class="t3">
				<tr><th colspan="2">배송 정보</th></tr>
				<tr>
					<th width="20%">수령인</th>
					<td width="80%"><input type="text" name="delivery_name" value="<%=member.getName()%>"></td>
				</tr>
				<tr>
					<th>배송지 연락처</th>
					<td><input type="text" name="delivery_tel" value="<%=member.getTel()%>"></td>
				</tr>
				<tr>
					<th>배송지 주소</th>
					<td>
						<input type="button" value="주소 찾기" id="btn_address"><br><br>
						<span>기본 주소</span> : <input type="text" name="delivery_address" class="add1" value="<%=member.getAddress()%>"><br><br>
						<span>상세 주소</span> : <input type="text" name="delivery_address_detail" class="add2" placeholder="상세 주소">
					</td>
				</tr>
			</table>
		</div>
		<div class="d6"> <!-- 주문자 정보. 결제정보 포함 -->
			<table class="t4">
				<tr><th colspan="3">주문자 정보</th></tr>
				<tr>
					<th width="20%">주문자 이름</th>
					<td width="80%" colspan="2"><%=member.getName() %></td>
				</tr>
				<tr>
					<th>주문자 연락처</th>
					<td colspan="2"><span><%=member.getTel() %></span></td>
				</tr>
				<tr>
					<th>주문자 주소</th>
					<td colspan="2"><span><%=member.getAddress() %></span></td>
				</tr>
				<tr>
					<th>결제 카드</th>
					<td width="28%">
						<select name="account" class="account">
						<%if(bankList.size() == 0) {%>
							<option value="0">등록된 카드가 없습니다.</option>
						<%} else {
							for(BankDTO bank : bankList) {
							String account = bank.getCard_no() + " " + bank.getCard_com();
						%>
							<option value="<%=account %>"><%=account %></option>
						<%} }%>
						</select>
					</td>
					<td>
						<input type="button" value="카드 삭제" id="btn_delete_bank">
					</td>
				</tr>
				<tr>
					<th>카드 등록</th>
					<td colspan="2">
						<input type="hidden" class="member_id" value="<%=member.getId() %>">
						<input type="hidden" class="member_name" value="<%=member.getName() %>">
						<input type="text" class="card_no" placeholder="카드번호 입력">
						<input type="text" class="card_com" placeholder="발행은행 입력">
						<input type="button" value="카드 등록" id="btn_register_bank">
					</td>
					
				</tr>
			</table>
		</div>
		<div class="d7"><!-- 결제 -->
			<table class="t5">
				<tr>
					<th width="30%">상품 도착 예정일</th>
					<th width="30%">총 구매금액</th>
					<th width="40%">결제</th>
				</tr>
				<tr>
					<th><span><%=d_day %></span></th>
					<th><span><%=df.format(tot3) %></span></th>
					<th><input type="button" value="최종결제" id="btn_buy"></th>
				</tr>
			</table>
		</div>
		</form>
		
	
	</div>
	<jsp:include page="../common/shopBottom.jsp"/>
</div>
</body>
</html>