package mall.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;


public class ReviewDAO {
		//singleton pattern
		private ReviewDAO() {}
		
		private static ReviewDAO reviewDAO = new ReviewDAO();
		
		public static ReviewDAO getInstance() {
			return reviewDAO;
		}
		
		// DB 연결, 질의에 사용할 객체 선언
		private Connection conn = null;
		private PreparedStatement pstmt = null;
		private ResultSet rs = null;
		
		// 리뷰 등록 메소드 (원글)
		public void insertreview(ReviewDTO review) {
			
			// 리뷰 추가
			String sql = "insert into review(member_id, product_id, subject, content) "
					+ "values(?, ?, ?, ?)";
						
			try {
				conn = JDBCUtil.getConnection();
				
				// 리뷰등록처리
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, review.getMember_id());
				pstmt.setInt(2, review.getProduct_id());
				pstmt.setString(3, review.getSubject());
				pstmt.setString(4, review.getContent());
				pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt);
			}
		}
		
		// 게시판 글 보기(전체) 메소드
		// 변경 -> reviewList.jsp 페이지에서 한페이지당 10건의 데이터
		public List<ReviewDTO> getReviewList(int start, int size, int product_id) {
			List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
			ReviewDTO review = null;
			
			String sql = "select * from review where product_id=? order by num desc limit ?, ?";
			
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_id);
				pstmt.setInt(2, start-1);
				pstmt.setInt(3, size);
				rs = pstmt.executeQuery();
				
				// 1단계 : 리뷰번호, 회원아이디, 상품아이디, 리뷰제목, 리뷰내용, 리뷰등록일, 조회수의 5가지 정보를 review에 저장
				// 2단계 : review를 reviewList에 저장
				while(rs.next()) {
					review = new ReviewDTO();
					review.setNum(rs.getInt("num"));
					review.setMember_id(rs.getString("member_id"));
					review.setProduct_id(rs.getInt("product_id"));
					review.setSubject(rs.getString("subject"));
					review.setContent(rs.getString("content"));
					review.setRegDate(rs.getTimestamp("regDate"));
					review.setReadcount(rs.getInt("readcount"));
					reviewList.add(review);
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return reviewList;
		}
		// 게시판 글 보기(1건) 메소드
		public ReviewDTO getReview(int num) {
			ReviewDTO review = new ReviewDTO();
			String sql1 = "update review set readcount=readcount+1 where num=?";
			String sql2 = "select * from review where num=?";
			
			try {
				conn = JDBCUtil.getConnection();
				
				// 조회수 증가
				pstmt = conn.prepareStatement(sql1);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				
				// 글 상세 보기
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				rs.next();
				review.setNum(rs.getInt("num"));
				review.setMember_id(rs.getString("member_id"));
				review.setProduct_id(rs.getInt("product_id"));
				review.setSubject(rs.getString("subject"));
				review.setContent(rs.getString("content"));
				review.setRegDate(rs.getTimestamp("regDate"));
				review.setReadcount(rs.getInt("readcount"));
				
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return review;
		}
		
		// 게시판 글 수정 폼에서 글보기 메소드
		public ReviewDTO getReviewUpdateForm(int num) {
			ReviewDTO review = new ReviewDTO();
			String sql = "select * from review where num=?";
			
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					review.setSubject(rs.getString("subject"));
					review.setContent(rs.getString("content"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return review;
		}
		
		// 리뷰 수정 메소드
		public void updateReview(ReviewDTO review) {
			String sql = "update review set subject=?, content=? where num=?";
			
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, review.getSubject());
				pstmt.setString(2, review.getContent());
				pstmt.setInt(3, review.getNum());
				pstmt.executeUpdate();
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt);
			}
		}
		
		// 리뷰 삭제 메소드
		public void deleteReview(int num) {
			String sql = "delete from review where num = ?";
			
			try {
				conn = JDBCUtil.getConnection();
				// member 테이블에서 id(member_id)에 해당하는 dbPwd를 구함
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt);
			}
		}
		// 전체 리뷰수 획득
		public int getReviewCount(int product_id) {
			String sql = "select count(*) from review where product_id=?;";
			int cnt = 0;
			
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_id);
				rs = pstmt.executeQuery();
				
				rs.next();
				cnt = rs.getInt(1);
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return cnt;
		}
}
