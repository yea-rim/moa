package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MemberDao {

	// 상세 조회 (이메일로 조회)
	public MemberDto selectOne(String memberEmail) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from member where member_email = ?";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, memberEmail);

		ResultSet rs = ps.executeQuery();

		MemberDto memberDto;

		if (rs.next()) {
			memberDto = new MemberDto();

			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPhone(rs.getString("member_phone"));
			memberDto.setMemberJoinDate(rs.getDate("member_join_date"));
			memberDto.setMemberPost(rs.getString("member_post"));
			memberDto.setMemberBasicAddress(rs.getString("member_basic_address"));
			memberDto.setMemberDetailAddress(rs.getString("member_detail_address"));
			memberDto.setMemberRoute(rs.getString("member_route"));
			memberDto.setMemberAdmin(rs.getInt("member_admin"));
		} else {
			memberDto = null;
		}

		con.close();

		return memberDto;

	}

	// 상세 조회 (회원 번호로 조회)
	public MemberDto selectOne(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from member where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, memberNo);

		ResultSet rs = ps.executeQuery();

		MemberDto memberDto;

		if (rs.next()) {
			memberDto = new MemberDto();

			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPhone(rs.getString("member_phone"));
			memberDto.setMemberJoinDate(rs.getDate("member_join_date"));
			memberDto.setMemberPost(rs.getString("member_post"));
			memberDto.setMemberBasicAddress(rs.getString("member_basic_address"));
			memberDto.setMemberDetailAddress(rs.getString("member_detail_address"));
			memberDto.setMemberRoute(rs.getString("member_route"));
			memberDto.setMemberAdmin(rs.getInt("member_admin"));
		} else {
			memberDto = null;
		}

		con.close();

		return memberDto;

	}

	public MemberDto selectOne(Integer memberNo) throws Exception {

		String sql = "select * from member where member_no = ?";
		MemberDto memberDto;

		if (memberNo == null) {
			memberDto = null;
			return memberDto;
		}

		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);

		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			memberDto = new MemberDto();

			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPhone(rs.getString("member_phone"));
			memberDto.setMemberJoinDate(rs.getDate("member_join_date"));
			memberDto.setMemberPost(rs.getString("member_post"));
			memberDto.setMemberBasicAddress(rs.getString("member_basic_address"));
			memberDto.setMemberDetailAddress(rs.getString("member_detail_address"));
			memberDto.setMemberRoute(rs.getString("member_route"));
			memberDto.setMemberAdmin(rs.getInt("member_admin"));

		} else {
			memberDto = null;
		}

		con.close();

		return memberDto;

	}

	// 등록 (1) 시퀀스 번호 생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select member_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int number = rs.getInt("nextval");

		con.close();

		return number;
	}

	// 등록 (2)
	public void join(MemberDto memberDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into member(" + "member_no, member_nick, member_phone, member_join_date, "
				+ "member_post, member_basic_address, member_detail_address, member_route, "
				+ "member_email, member_pw) values (member_seq.nextval, ?, ?, sysdate, ?, ?, ?, ?, ?, ?)";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberNick());
		ps.setString(2, memberDto.getMemberPhone());
		ps.setString(3, memberDto.getMemberPost());
		ps.setString(4, memberDto.getMemberBasicAddress());
		ps.setString(5, memberDto.getMemberDetailAddress());
		ps.setString(6, memberDto.getMemberRoute());
		ps.setString(7, memberDto.getMemberEmail());
		ps.setString(8, memberDto.getMemberPw());
		ps.execute();

		con.close();

	}

	// 아이디 찾기
	public String findEmail(MemberDto memberDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select member_email from member where member_phone=? and member_nick=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberPhone());
		ps.setString(2, memberDto.getMemberNick());
		ResultSet rs = ps.executeQuery();

		String memberEmail;
		if (rs.next()) {
			memberEmail = rs.getString("member_email");
		} else {
			memberEmail = null;
		}
		con.close();
		return memberEmail;
	}

	// 비밀번호 찾기
	public MemberDto findPw(MemberDto memberDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from member where member_email=? and member_nick=? and member_phone=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberEmail());
		ps.setString(2, memberDto.getMemberNick());
		ps.setString(3, memberDto.getMemberPhone());
		ResultSet rs = ps.executeQuery();

		MemberDto findDto;
		if (rs.next()) {
			findDto = new MemberDto();

			findDto.setMemberNo(rs.getInt("member_no"));
			findDto.setMemberNick(rs.getString("member_nick"));
			findDto.setMemberPhone(rs.getString("member_phone"));
			findDto.setMemberJoinDate(rs.getDate("member_join_date"));
			findDto.setMemberPost(rs.getString("member_post"));
			findDto.setMemberBasicAddress(rs.getString("member_basic_address"));
			findDto.setMemberDetailAddress(rs.getString("member_detail_address"));
			findDto.setMemberRoute(rs.getString("member_route"));
			findDto.setMemberEmail(rs.getString("member_email"));
			findDto.setMemberPw(rs.getString("member_pw"));
		} else {
			findDto = null;
		}

		con.close();
		return findDto;
	}

	// 비밀번호 변경
	public boolean changePassword(String memberEmail, String changePw) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update member set member_pw = ? where member_email = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, changePw);
		ps.setString(2, memberEmail);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

	public boolean changeNick(int memberNo, String memberNick) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update member set member_nick = ? where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberNick);
		ps.setInt(2, memberNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0; 
	}
	
	// 개인정보 변경
	public boolean changeInformation(MemberDto memberDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update member set member_phone = ?, member_post = ?, member_basic_address= ?, member_detail_address = ? where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberPhone());
		ps.setString(2, memberDto.getMemberPost());
		ps.setString(3, memberDto.getMemberBasicAddress());
		ps.setString(4, memberDto.getMemberDetailAddress());
		ps.setInt(5, memberDto.getMemberNo());

		int count = ps.executeUpdate();

		return count > 0;

	}

	// 탈퇴
	public boolean exit(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete member where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);

		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

	public MemberDto findByNickname(String memberNick) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from member where member_nick = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberNick);
		ResultSet rs = ps.executeQuery();

		MemberDto memberDto;
		if (rs.next()) {
			memberDto = new MemberDto();

			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPhone(rs.getString("member_phone"));
			memberDto.setMemberJoinDate(rs.getDate("member_join_date"));
			memberDto.setMemberPost(rs.getString("member_post"));
			memberDto.setMemberBasicAddress(rs.getString("member_basic_address"));
			memberDto.setMemberDetailAddress(rs.getString("member_detail_address"));
			memberDto.setMemberRoute(rs.getString("member_route"));
		} else {
			memberDto = null;
		}

		con.close();

		return memberDto;
	}
	
	public MemberDto findByPhone(String memberPhone) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from member where member_phone = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberPhone);
		ResultSet rs = ps.executeQuery();

		MemberDto memberDto;
		if (rs.next()) {
			memberDto = new MemberDto();

			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPhone(rs.getString("member_phone"));
			memberDto.setMemberJoinDate(rs.getDate("member_join_date"));
			memberDto.setMemberPost(rs.getString("member_post"));
			memberDto.setMemberBasicAddress(rs.getString("member_basic_address"));
			memberDto.setMemberDetailAddress(rs.getString("member_detail_address"));
			memberDto.setMemberRoute(rs.getString("member_route"));
		} else {
			memberDto = null;
		}

		con.close();

		return memberDto;
	}

	// 전체 목록
	public List<MemberDto> allSelectList(int p, int s, String sort) throws Exception {

		String standard;
		if (sort.equals("가입최신순")) {
			standard = "order by member_no desc";
		} else if (sort.equals("판매자신청중")) {
			standard = "where seller_permission = 0";
		} else if (sort.equals("판매자승인")) {
			standard = "where seller_permission = 1 order by seller_regist_date desc";
		} else if (sort.equals("판매자거절")) {
			standard = "where seller_permission = 2 order by seller_regist_date desc";
		} else {
			standard = "order by member_no asc";
		}

		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from "
				+ "(select rownum rn, tmp.* from "
				+ "(select * from member m "
				+ "left outer join seller s "
				+ "on m.member_no = s.seller_no #1)tmp) "
				+ "where rn between ? and ?";
		
		sql = sql.replace("#1", standard);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<MemberDto> list = new ArrayList<>();
		while (rs.next()) {
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPhone(rs.getString("member_phone"));
			memberDto.setMemberJoinDate(rs.getDate("member_join_date"));
			memberDto.setMemberPost(rs.getString("member_post"));
			memberDto.setMemberBasicAddress(rs.getString("member_basic_address"));
			memberDto.setMemberDetailAddress(rs.getString("member_detail_address"));
			memberDto.setMemberRoute(rs.getString("member_route"));

			list.add(memberDto);
		}

		return list;
	}

	// 관리자 회원 목록(전체목록) 페이지 네이션
	public int countByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from member";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}
}
