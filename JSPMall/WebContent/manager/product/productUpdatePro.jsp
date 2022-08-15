<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="manager.product.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 처리</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	// 폼의 입력 정보 획득
	// 파일 업로드 폼 -> cos.jar 라이브러리의 MultipartRequest 클래스를 사용
	// request, 업로드 폴더, 파일의 최대 크기, encType, 파일명 중복정책
	String realFolder = "c:/images_jspmall";
	int maxSize = 1024 * 1024 * 5;
	String encType = "utf-8";
	String fileName = "";
	MultipartRequest multi = null;
	
	try {
		multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		List<String> list = new ArrayList<String>();
		Enumeration<?> files = multi.getFileNames();
		while(files.hasMoreElements()){
			String name = files.nextElement().toString();
			fileName = multi.getFilesystemName(name);
		}
		//pageNum 획득
		String pageNum = multi.getParameter("pageNum");
		
		// 폼에서 넘어오는 11개 필드값 획득 - reg_date 제외(수정불가라서)
		int product_id = Integer.parseInt(multi.getParameter("product_id"));
		String product_category = multi.getParameter("product_category");
		String product_name = multi.getParameter("product_name");
		int product_price = Integer.parseInt(multi.getParameter("product_price"));
		int product_stock = Integer.parseInt(multi.getParameter("product_stock"));
		//String product_image1 = multi.getParameter("product_image"); // 이방법으론 얻을수없음
		//String product_detail = multi.getParameter("product_detail");
		String product_brand = multi.getParameter("product_brand");
		String product_size = multi.getParameter("product_size");
		String product_color = multi.getParameter("product_color");
		int discount_rate = Integer.parseInt(multi.getParameter("discount_rate"));
		
		ProductDTO product = new ProductDTO();
		product.setProduct_id(product_id);
		product.setProduct_category(product_category);
		product.setProduct_name(product_name);
		product.setProduct_price(product_price);
		product.setProduct_stock(product_stock);
		product.setProduct_image1(list.get(3));
		product.setProduct_image2(list.get(2));
		product.setProduct_image3(list.get(1));
		product.setProduct_detail(list.get(0));
		product.setProduct_brand(product_brand);
		product.setProduct_size(product_size);
		product.setProduct_color(product_color);
		product.setDiscount_rate(discount_rate);
		System.out.println("product 객체 : " + product);
		
		// DB 연결, product 테이블에 상품 수정 처리
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.updateProduct(product);
		response.sendRedirect("productList.jsp?pageNum=" + pageNum);
	} catch(Exception e) {
		System.out.println("productUpdatePro.jsp : " + e.getMessage());
		e.printStackTrace();
	}
	
		
	%>
</body>
</html>