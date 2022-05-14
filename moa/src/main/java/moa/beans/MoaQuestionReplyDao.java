package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MoaQuestionReplyDao {
	//댓글 등록
	public void insert(int questionNo, String questionContent) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into moa_question_reply(question_target_no,question_reply_content) values(?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, questionNo);
		ps.setString(2,questionContent);
		ps.execute();
		
		con.close();
	}
	
	//댓글 상세 조회
	public MoaQuestionReplyDto selectOne(int questionNo) throws Exception {
		String sql = "select * from moa_question_reply where question_target_no = ?";

		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, questionNo);

		ResultSet rs = ps.executeQuery();

		MoaQuestionReplyDto moaquestionReplyDto;
		if (rs.next()) {
			moaquestionReplyDto = new MoaQuestionReplyDto();
			moaquestionReplyDto.setQuestionTargetNo(rs.getInt("question_target_no"));
			moaquestionReplyDto.setQuestionReplyTime(rs.getDate("question_reply_time"));
			moaquestionReplyDto.setQuestionReplyContent(rs.getString("question_reply_content"));					
		} else {
			moaquestionReplyDto = null;
		}

		con.close();

		return moaquestionReplyDto;
	}
	
	//문의 댓글 삭제
	public boolean delete(int questionNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete moa_question_reply where question_target_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, questionNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}
	
	//문의 댓글 수정
	public boolean edit(int questionNo, String replyContent) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update moa_question_reply set question_reply_content = ? where question_target_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, replyContent);
		ps.setInt(2, questionNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}
}
