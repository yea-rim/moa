package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MoaQuestionDao {
	
	// moa 1:1문의 시퀀스 생성
	public int getQuestionNo() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select moa_question_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int communityNo = rs.getInt("nextval");
		
		con.close();
		
		return communityNo;
	}
	
	
	// moa 1:1문의 등록
	public void insert(MoaQuestionDto moaQuestionDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into moa_question(question_no,question_writer,question_title,question_content,question_type) values(?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);		
		ps.setInt(1, moaQuestionDto.getQuestionNo());
		ps.setInt(2, moaQuestionDto.getQuestionWriter());
		ps.setString(3, moaQuestionDto.getQuestionTitle());
		ps.setString(4, moaQuestionDto.getQuestionContent());
		ps.setString(5, moaQuestionDto.getQuestionType());
		ps.execute();
		
		con.close();
	}

	
	// 전체목록 조회
	public List<MoaQuestionDto> selectList(int p, int s) throws Exception {
		int end = p * s;
		int begin = end - (s - 1);

		Connection con = JdbcUtils.getConnection();

		String sql = "select*from(" 
				+ "select rownum rn, TMP.* from (" 
				+ "select * from moa_question order by question_no desc"
				+ ") TMP" 
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<MoaQuestionDto> list = new ArrayList<>();
		while (rs.next()) {
			MoaQuestionDto moaQuestionDto = new MoaQuestionDto();
			moaQuestionDto.setQuestionNo(rs.getInt("question_no"));
			moaQuestionDto.setQuestionType(rs.getString("question_type"));
			moaQuestionDto.setQuestionTitle(rs.getString("question_title"));
			moaQuestionDto.setQuestionWriter(rs.getInt("question_writer"));
			moaQuestionDto.setQuestionContent(rs.getString("question_content"));
			moaQuestionDto.setQuestionTime(rs.getDate("question_time"));
			moaQuestionDto.setAnswerStatus(rs.getInt("answer_status"));
			
			list.add(moaQuestionDto);
		}

		con.close();

		return list;
	}
	
	// 관리자 목록 페이지 네이션
	public int adminCountByPaging() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from moa_question";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt("count(*)");

		con.close();

		return count;
	}
	
	//답변 완료
	public boolean finishAnswer(int questionNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update moa_question set ANSWER_STATUS = 1 where question_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, questionNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}
	
	//답변 취소
	public boolean cencleAnswer(int questionNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update moa_question set ANSWER_STATUS = 0 where question_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, questionNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}
	
	//마이페이지에서 본인 문의글 조회
	// 전체목록 조회
	public List<MoaQuestionDto> selecMyQuestion(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from moa_question where question_writer= ? order by question_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();

		List<MoaQuestionDto> list = new ArrayList<>();
		while (rs.next()) {
			MoaQuestionDto moaQuestionDto = new MoaQuestionDto();
			moaQuestionDto.setQuestionNo(rs.getInt("question_no"));
			moaQuestionDto.setQuestionType(rs.getString("question_type"));
			moaQuestionDto.setQuestionTitle(rs.getString("question_title"));
			moaQuestionDto.setQuestionWriter(rs.getInt("question_writer"));
			moaQuestionDto.setQuestionContent(rs.getString("question_content"));
			moaQuestionDto.setQuestionTime(rs.getDate("question_time"));
			moaQuestionDto.setAnswerStatus(rs.getInt("answer_status"));
			
			list.add(moaQuestionDto);
		}

		con.close();

		return list;
	}
	
	//답변 삭제
	public boolean delete(int questionNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete moa_question where question_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, questionNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}
	
}
