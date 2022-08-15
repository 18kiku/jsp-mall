package manager.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

public class ProductDAO {
	private ProductDAO() {}
	
	private static ProductDAO instance = new ProductDAO();
	
	public static ProductDAO getInstance() {
		return instance;
	}
	
	// DB 연결, 질의를 위한 객체 변수
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// ##########################
	// manager의 product에서 사용한 메서드
	
	// 상품 등록 메소드
	public void insertProduct(ProductDTO product) {
		String sql = "insert into product(product_category, product_name, "
				+ "product_price, product_stock,"
				+ "product_detail, product_image1, product_image2, product_image3, "
				+ "product_brand, product_size, product_color, discount_rate) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ? ,?, ?, ?)";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_category());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, product.getProduct_stock());
			pstmt.setString(5, product.getProduct_detail());
			pstmt.setString(6, product.getProduct_image1());
			pstmt.setString(7, product.getProduct_image2());
			pstmt.setString(8, product.getProduct_image3());
			pstmt.setString(9, product.getProduct_brand());
			pstmt.setString(10, product.getProduct_size());
			pstmt.setString(11, product.getProduct_color());
			pstmt.setInt(12, product.getDiscount_rate());
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("insertProduct Method : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 전체 상품수 조회 메소드 - 검색하지 않았을때
	public int getProductCount() {
		String sql = "select count(*) from product";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch(Exception e) {
			System.out.println("getProductCount Method(검색x) : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	// 전체 상품수 조회 메소드 - 분류별 상품
		public int getProductCount(String product_category) {
			String sql = "select count(*) from product where product_category = ?";
			int cnt = 0;
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_category);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					cnt = rs.getInt(1);
				}
			} catch(Exception e) {
				System.out.println("getProductCount Method(String product_category) : " + e.getMessage());
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return cnt;
		}
	// 전체 상품수 조회 메소드 - 검색했을때
		public int getProductCount(String s_search, String i_search) {

			String sql = "select count(*) from product where ";
			if(s_search.equals("상품명")) {
				sql += "product_name";
			} else if (s_search.equals("카테고리")) {
				sql += "product_category";
			} else if (s_search.equals("브랜드")) {
				sql += "product_brand";
			}
			sql += " like ?";
			
			int cnt = 0;
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + i_search + "%");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					cnt = rs.getInt(1);
				}
			} catch(Exception e) {
				System.out.println("getProductCount Method(검색) : " + e.getMessage());
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return cnt;
		}
	// 전체 상품 조회 메소드 - 페이징 처리는 하고, 검색 처리는 안함
		public List<ProductDTO> getProductList(int startRow, int pageSize){
			List<ProductDTO> productList = new ArrayList<ProductDTO>();
			ProductDTO product = null;
			String sql = "select * from product order by product_id desc limit ?, ?";
			
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					product = new ProductDTO();
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_category(rs.getString("product_category"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					//product.setProduct_detail(rs.getString("product_detail"));
					product.setProduct_image1(rs.getString("product_image1"));
					product.setProduct_image2(rs.getString("product_image2"));
					product.setProduct_image3(rs.getString("product_image3"));
					product.setProduct_brand(rs.getString("product_brand"));
					product.setProduct_size(rs.getString("product_size"));
					product.setProduct_color(rs.getString("product_color"));
					product.setDiscount_rate(rs.getInt("discount_rate"));
					product.setReg_date(rs.getTimestamp("reg_date"));
					
					productList.add(product);
				}
			} catch(Exception e) {
				System.out.println("getProductList Method : " + e.getMessage());
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return productList;
		}
		// 검색한 상품 조회 메소드 - 페이징 처리는 하고, 검색 처리도 함
		public List<ProductDTO> getProductList(int startRow, int pageSize, String s_search, String i_search){
			System.out.println("s_search : " + s_search + " i_search : " + i_search);
			List<ProductDTO> productList = new ArrayList<ProductDTO>();
			ProductDTO product = null;
			String sql = "select * from product where ";
			if(s_search.equals("상품명")) {
				sql += "product_name";
			} else if (s_search.equals("카테고리")) {
				sql += "product_category";
			} else if (s_search.equals("브랜드")) {
				sql += "product_brand";
			}
			
			sql += " like ? order by product_id desc limit ?, ?";
			
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,"%" + i_search + "%");
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					product = new ProductDTO();
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_category(rs.getString("product_category"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					//product.setProduct_detail(rs.getString("product_detail"));
					product.setProduct_image1(rs.getString("product_image1"));
					product.setProduct_image2(rs.getString("product_image2"));
					product.setProduct_image3(rs.getString("product_image3"));
					product.setProduct_brand(rs.getString("product_brand"));
					product.setProduct_size(rs.getString("product_size"));
					product.setProduct_color(rs.getString("product_color"));
					product.setDiscount_rate(rs.getInt("discount_rate"));
					product.setReg_date(rs.getTimestamp("reg_date"));
					
					productList.add(product);
				}
			} catch(Exception e) {
				System.out.println("getProductList Method : " + e.getMessage());
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return productList;
		}
	// 상품 1개 조회
	public ProductDTO getProduct(int product_id) {
		ProductDTO product = new ProductDTO();
		String sql = "select * from product where product_id = ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			rs.next();
			product.setProduct_id(rs.getInt("product_id"));
			product.setProduct_category(rs.getString("product_category"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getInt("product_price"));
			product.setProduct_stock(rs.getInt("product_stock"));
			product.setProduct_detail(rs.getString("product_detail"));
			product.setProduct_image1(rs.getString("product_image1"));
			product.setProduct_image2(rs.getString("product_image2"));
			product.setProduct_image3(rs.getString("product_image3"));
			product.setProduct_brand(rs.getString("product_brand"));
			product.setProduct_size(rs.getString("product_size"));
			product.setProduct_color(rs.getString("product_color"));
			product.setDiscount_rate(rs.getInt("discount_rate"));
			product.setReg_date(rs.getTimestamp("reg_date"));
			
			
		} catch(Exception e) {
			System.out.println("getProduct Method : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return product;
	}
	// 상품 수정 메서드
	public void updateProduct(ProductDTO product) {
		String sql1 = "update product set product_category=?, product_name=?, product_price=?, "
				+ "product_stock=?, product_detail=?, "
				+ "product_brand=?, product_size=?, product_color=?, discount_rate=? "
				+ "where product_id=?";
		String sql2 = "update product set product_category=?, product_name=?, product_price=?, "
				+ "product_stock=?, product_detail=?, product_image1=?, product_image2=?, product_image3=?, "
				+ "product_brand=?, product_size=?, product_color=?, discount_rate=? "
				+ "where product_id=?";
		
		try {
			conn = JDBCUtil.getConnection();
			if(product.getProduct_image1() == null) {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, product.getProduct_category());
				pstmt.setString(2, product.getProduct_name());
				pstmt.setInt(3, product.getProduct_price());
				pstmt.setInt(4, product.getProduct_stock());
				pstmt.setString(5, product.getProduct_detail());
				pstmt.setString(9, product.getProduct_brand());
				pstmt.setString(10, product.getProduct_size());
				pstmt.setString(11, product.getProduct_color());
				pstmt.setInt(12, product.getDiscount_rate());
				pstmt.setInt(13, product.getProduct_id());
				pstmt.executeUpdate();
			} else {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, product.getProduct_category());
				pstmt.setString(2, product.getProduct_name());
				pstmt.setInt(3, product.getProduct_price());
				pstmt.setInt(4, product.getProduct_stock());
				pstmt.setString(5, product.getProduct_detail());
				pstmt.setString(6, product.getProduct_image1());
				pstmt.setString(7, product.getProduct_image2());
				pstmt.setString(8, product.getProduct_image3());
				pstmt.setString(9, product.getProduct_brand());
				pstmt.setString(10, product.getProduct_size());
				pstmt.setString(11, product.getProduct_color());
				pstmt.setInt(12, product.getDiscount_rate());
				pstmt.setInt(13, product.getProduct_id());
				pstmt.executeUpdate();
			}
			
			
		} catch(Exception e) {
			System.out.println("updateProduct Method : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	// 상품 삭제 메서드
	public void deleteProduct(int product_id) {
		String sql = "delete from product where product_id=?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("deleteProduct Method : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		
	}
	// #########################################
	// mall에서 사용하는 메서드
	public List<String> getCategory(){
		List<String> categories = new ArrayList<String>();
		String sql = "select product_category from product group by product_category";
		
		try {
			conn = JDBCUtil.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				categories.add(rs.getString("product_category"));
			}
		} catch(Exception e) {
			System.out.println("getCategory Method : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		
		return categories;
	}
	
	
	// 1. (chk == 1) shop에서 100번대, 200번대 신상품 3개씩을 리스트에 담아서 리턴하는 메서드
	// 2. (chk == 2) 상품 종류별로 신상품 1개씩 리스트에 담아서 리턴하는 메서드
	// 신상품의 기준 : reg_date
	public List<ProductDTO> getProductList(String[] nProducts, int chk){
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql1 = "select * from product where product_category = ? order by reg_date desc limit 3";
		String sql2 = "select * from product where product_category = ? order by reg_date desc limit 3";
		
		
		
		try {
			conn = JDBCUtil.getConnection();
			
			for(String s : nProducts) {
				if(chk == 1) pstmt = conn.prepareStatement(sql1); 
				else if(chk == 2) pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, s);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					product = new ProductDTO();
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_image1(rs.getString("product_image1"));
					productList.add(product);
				}
			}
		} catch(Exception e) {
			System.out.println("getProductList(String[]) Method : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 상품 종류별 보기 - shopMain.jsp
	public List<ProductDTO> getProductList(String product_category){
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product where product_category = ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_category);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_category(rs.getString("product_category"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_stock(rs.getInt("product_stock"));
				product.setProduct_detail(rs.getString("product_detail"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_size(rs.getString("product_size"));
				product.setProduct_color(rs.getString("product_color"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
		} catch(Exception e) {
			System.out.println("getProductList(String product_category) Method : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		
		return productList;
	}
	
	// 상품 종류별 보기 - 페이징 처리, shopMain.jsp
		public List<ProductDTO> getProductList(int startRow, int pageSize, String product_category){
			List<ProductDTO> productList = new ArrayList<ProductDTO>();
			ProductDTO product = null;
			String sql = "select * from product where product_category = ? order by product_id desc limit ?,?";
			
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_category);
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					product = new ProductDTO();
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_category(rs.getString("product_category"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					product.setProduct_detail(rs.getString("product_detail"));
					product.setProduct_image1(rs.getString("product_image1"));
					product.setProduct_image2(rs.getString("product_image2"));
					product.setProduct_image3(rs.getString("product_image3"));
					product.setProduct_brand(rs.getString("product_brand"));
					product.setProduct_size(rs.getString("product_size"));
					product.setProduct_color(rs.getString("product_color"));
					product.setDiscount_rate(rs.getInt("discount_rate"));
					product.setReg_date(rs.getTimestamp("reg_date"));
					productList.add(product);
				}
			} catch(Exception e) {
				System.out.println("getProductList(paging) Method : " + e.getMessage());
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			
			return productList;
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
