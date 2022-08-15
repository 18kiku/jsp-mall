<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 쇼핑몰 하단 페이지 : 모든 쇼핑몰의 하단에 포함되는 페이지 --%>
<style>
.b_box1 { font-size: 14px; color: #868e96;}
.b_box2, .b_box3, .b_box4 { font-size: 13px; color: #adb5bd;}
.first_line { border: 1px solid #e9ecef; margin: 20px 0; margin-top: 50px;}
.b_line { border: 1px solid #e9ecef; margin: 20px 0; clear: both;}
/* b_box1 */
.b_box1 { margin-bottom: 20px;}
.bb1 { padding: 5px; margin: 10px;}
.bb1:first-child { margin-left: 0;}
.bb1:nth-child(4) { font-weight: bold;}
/* b_box2 */
.bb1 { padding: 5px; margin: 10px;}
.b2_s1, .b2_s2 { width: 50%;}
.b2_s1 { float: left;}
.b2_s2 { float: right;}
.c_b2 { margin-bottom: 8px;}
.c_b2:nth-child(1), .c_b2:nth-child(5) { font-size: 14px; font-weight:bold; color: #495057;}

.c_b2 span { color: #1e94be; font-weight: bold;}
/* b_box3 */
.bb3 { margin-bottom: 8px;}
/* b_box4 */
.b_box4 { margin-bottom: 30px;}

</style>


<div class="bottom">
	<hr class="first_line">
	<div class="b_box1">
		<span class="b1_s1 bb1">JSPMall 소개</span> |
		<span class="b1_s2 bb1">채용정보</span> |
		<span class="b1_s3 bb1">이용약관</span> |
		<span class="b1_s4 bb1">개인정보처리방침</span> |
		<span class="b1_s5 bb1">청소년보호정책</span> |
		<span class="b1_s6 bb1">전자금융거래약관</span> |
		<span class="b1_s7 bb1">제휴·광고</span>
	</div>
	<hr class="b_line">
	<div class="b_box2">
		<div class="b2_s1">
			<div class="c_b2">제이에스피몰</div>
			<div class="c_b2">서울특별시 강남구 서초구 서초대로77길 54 서초더블유타워 13,14층</div>
			<div class="c_b2">사업자등록번호 : 111-11-11111 | 통신판매업신고 : 강남 1111호<span>사업자정보확인></span></div>
			<div class="c_b2">업무집행자 : KIKU</div>
		</div>
		<div class="b2_s2">
			<div class="c_b2">고객센터 ></div>
			<div class="c_b2">경기도 부천시 부이로 225 2층</div>
			<div class="c_b2">Tel : 0000-0000 (평일 09:00 ~ 18:00) | 스마일클럽 전용 Tel : <span>1111-1111 (365일 09:00 ~ 18:00)</span></div>
			<div class="c_b2">Fax : <span>02-000-0000</span> | Mail : market@corp.market.co.kr</div>
		</div>
	</div>
	<hr class="b_line">
	<div class="b_box3">
		<div class="bb3">전자금융분쟁처리 > Tel : 0000-0000 | Fax : 02-589-8844 | Mail : mk_cs@corp.market.co.kr</div>
		<div class="bb3">오픈마켓 자율준수규약 > &emsp;&emsp;&emsp;윤리경영사이버범죄 신고시스템>&emsp;&emsp;&emsp;VeRO Program>&emsp;&emsp;&emsp;안전거래센터>&emsp;&emsp;&emsp;저작권침해신고></div>
		<div class="bb3"></div>
	</div>
	<hr class="b_line">
	<div class="b_box4">
		<div><img src="../../icons/logo_kolsa.png" height="15">&emsp;한국온라인쇼핑협회&emsp;수상·인증 내역＾</div>
	</div>
</div>