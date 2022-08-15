# JSP 쇼핑몰 프로젝트

## 1. 개요
### 주제
JSP를 활용하여 쇼핑몰을 구현한다.
### 이유
쇼핑몰 프로젝트는 JavaScript부터 JSP, MySQL까지 배운 기술들을 많이 활용할 수 있을 것이라고 생각했다.



## 2. 주요 기능

### (회원)
+ 로그인
+ 회원 가입
+ 회원 정보 수정
+ 회원 탈퇴

### (상품관리)
+ 상품 조회, 등록, 수정, 삭제

### (쇼핑)
+ 상품 조회
+ 상품 카트에 담기
+ 상품 바로 구매

### (카트)
+ 구매를 원하는 상품 담기

### (주문)
+ 쇼핑 영역에서 바로 구매
+ 카드에 담긴 상품 구매
+ 주문 목록 조회

## 3. 개발 환경
```
OS: Windows 10
Java Version: Java 1.8
IDE: eclipse
DB: MySQL
```



## 4. 요구사항

### 공통

#### 1. 상단, 하단 페이지
+ 모든 페이지에 동일한 상단 하단 페이지 -> 액션태그(jsp:include) 사용

#### 2. 페이징 구현
+ 페이지당 n개씩 조회할 수 있도록 쿼리 작성
+ 페이징 블록 이동 버튼 구현(ex. 첫 페이지, 다음 페이지)

### 회원 관리

#### 1. 로그인
+ id와 password가 일치여부 확인
+ 일치 시 세션에 회원 정보 저장 후 쇼핑몰 메인 페이지로 이동
+ 불일치 시 로그인 페이지로 재 이동

#### 2. 회원가입
+ 아이디, 비밀번호, 이름, 이메일 필수 입력
+ 아이디 중복검사, 이메일 유효성 검사
+ 가입 완료 시 로그인 페이지로 이동

### 상품 관리

#### 1. 상품 등록
+ 이미지 파일을 등록 가능
+ 상품 수정, 삭제
+ 카테고리, 상품명에 따라 상품을 검색할 수 있다.

### 쇼핑몰

#### 1. 상품 목록
+ 카테고리별로 상품을 표시. 이미지, 상품명, 가격만 간단하게 표시

#### 2. 상품 상세
+ 상품의 이미지와 상세 정보들을 표시
+ 카트에 담을 수 있고, 바로 주문을 할 수 있다.

### 카트

+ 구매를 원하는 상품을 저장할 수 있다
+ 카드 내의 상품을 삭제하거나 수량을 수정할 수 있다.
+ 원하는 상품을 선택하여 주문할 수 있다.

### 주문
+ 상품 상세페이지나 카트에서 선택한 상품을 주문할 수 있다.
+ 배송지를 직접 입력하거나 회원 정보에서 불러올 수 있다.
+ 주문 상품의 개별 가격과 수량, 총 가격을 확인할 수 있다.
+ 주문한 기록을 확인할 수 있다.



## 5. 테이블 정의

![image](https://user-images.githubusercontent.com/98327681/184676857-66b1579b-a490-4f31-8e3c-7d65198cf3dd.png)

![image](https://user-images.githubusercontent.com/98327681/184676866-74c9f7da-eeb8-468e-ba95-2e4f18753d73.png)

![image](https://user-images.githubusercontent.com/98327681/184676873-9bfb704f-f5cd-4c62-8bcc-71178cc067d8.png)

![image](https://user-images.githubusercontent.com/98327681/184676887-f149de47-1368-4d8c-8c83-9dc4efda814b.png)

![image](https://user-images.githubusercontent.com/98327681/184676892-0a1b4190-ad3e-4a09-a5fb-ed41c37842b4.png)

![image](https://user-images.githubusercontent.com/98327681/184676902-1b7a90ac-b823-4c94-ae1f-d2d8520533de.png)

![image](https://user-images.githubusercontent.com/98327681/184676908-29765606-7fc0-452a-88ae-a74100f4acf3.png)



## 6. 화면 구성

### ■ 고객 영역

#### 1. 메인
![image](https://user-images.githubusercontent.com/98327681/184677015-9f7e5f62-1bae-419d-88c9-ebfaf5bee777.png)


#### 2. 회원가입
![image](https://user-images.githubusercontent.com/98327681/184677032-c8c7b0cf-7b83-4426-a27a-943c6bc12dfc.png)


#### 3. 로그인
![image](https://user-images.githubusercontent.com/98327681/184677043-57a28b49-b3eb-4fed-a696-ca2aacbb5c33.png)


#### 4. 회원정보
![image](https://user-images.githubusercontent.com/98327681/184677059-f9830d34-433a-439f-9f0c-3e24a98c8282.png)


#### 5. 상품 목록
![image](https://user-images.githubusercontent.com/98327681/184677075-4b8a833c-5bfd-462f-afc1-e4fd48f72ff2.png)


#### 6. 상품 디테일
![image](https://user-images.githubusercontent.com/98327681/184677089-1b94a13f-9cbd-4491-93da-995b7c6c14fd.png)


#### 7. 장바구니
![image](https://user-images.githubusercontent.com/98327681/184677103-b64eba77-8dec-4759-9548-7223864d1092.png)


#### 8. 결제
![image](https://user-images.githubusercontent.com/98327681/184677105-abbf9126-cb7c-4445-9008-0b54b53057e0.png)
![image](https://user-images.githubusercontent.com/98327681/184677114-3b267885-4168-4b27-ac3b-c25548168423.png)


#### 9. 주문목록
![image](https://user-images.githubusercontent.com/98327681/184677118-52a499ea-56e6-4feb-b83a-c922d3371a01.png)


■ 관리자 영역

#### 1. 상품 목록
![image](https://user-images.githubusercontent.com/98327681/184677125-2836b3ba-f1e0-479a-b2ae-59012c34719e.png)


#### 2. 상품 상세
![image](https://user-images.githubusercontent.com/98327681/184677136-fc503260-665f-4c12-8a9e-464825b777a5.png)



