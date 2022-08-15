package mall.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;
// DAO, Data Access Object, DBBean
public class MemberDAO {
	// singleton pattern
	private MemberDAO() {}
	
	private static MemberDAO memberDAO = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return memberDAO;
	}
	// DB 연결, 질의에 사용할 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	// 멤버 추가
	public int insertMember(MemberDTO member) {
		String sql = "insert into member values(?, ?, ?, ?, ?, ?, now())";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddress());
			cnt = pstmt.executeUpdate();
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	// ID 중복 체크
	public boolean memberIdCheck(String id) {
		String sql = "select * from member where id = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return false;
	}
	// 로그인
	public int login(String id, String pwd) {
		String sql = "select * from member where id = ? and pwd = ?";
		int cnt = 0; 
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 
				String dbPwd = rs.getString("pwd");
				if(dbPwd.equals(pwd)) { // 1 : 아이디, 비밀번호 일치
					cnt = 1;
				} else { // 0 : 아이디는 있지만 비밀번호가 다름
					cnt = 0;
				}
			} else { // -1 :아이디가 없음
				cnt = -1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	// 회원 조회(1명)
	public MemberDTO getMember(String id) {
		String sql = "select * from member where id = ?";
		MemberDTO member = null;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddress(rs.getString("address"));
				member.setRegDate(rs.getTimestamp("regDate"));
			} else {
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return member;
	}
	
	
	// 회원정보 업데이트
	public int updateMember(MemberDTO member) {
		String sql = "update member set pwd=?, name=?, email=?, tel=?, address=? where id=?";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(6, member.getId());
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getAddress());
			cnt = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	public int updateMember2(MemberDTO member) {
		String sql = "update member set pwd=?, name=?, email=?, tel=? where id=?";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(5, member.getId());
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			
			cnt = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	
	// 회원 삭제(탈퇴) 메소드 -> 해당 회원이 남긴 게시판의 글도 모두 삭제되도록 변경
	// 트랜잭션 처리
	public int deleteMember(String id, String pwd) throws Exception {
		String sql1 = "delete from member where id=? and pwd=?";
		String sql2 = "delete from board where writer=?";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			
			// DML 작업을 두개이상 함께 처리해야함
			// 트랜잭션 처리 1. 자동 커밋 해제
			conn.setAutoCommit(false);
			
			
			// DML 1작업 : 회원삭제(탈퇴)
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			cnt = pstmt.executeUpdate();
			
			// DML 2작업 : 해당 회원이 남긴 게시판 글 모두 삭제
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			// 트랜잭션 처리 2 - 모든 작업이 완료되면 커밋
			conn.commit();
			// 트랜잭션 처리 3 - 자동 커밋 활성화
			conn.setAutoCommit(true);
			
			
		} catch(Exception e) {
			conn.rollback();
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	
}
