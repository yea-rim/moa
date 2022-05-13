package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MoaQuestionAttachDao {
	//생성
	public void insert(MoaQuestionAttachDto moaQuestionAttachDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into moa_question_attach(attach_no,question_no) values(?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, moaQuestionAttachDto.getAttachNo());
		ps.setInt(2, moaQuestionAttachDto.getQuestionNo());
		ps.execute();

		con.close();
	}
	
	//attach번호 가져오기
	public int selectOne(int questionNo) throws Exception {
		String sql = "select attach_no from moa_question_attach where question_no=?";

		Connection con = JdbcUtils.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, questionNo);
		ResultSet rs = ps.executeQuery();

		int attachNo;
		if (rs.next()) {
			attachNo = rs.getInt("attach_no");
						
		} else {
			attachNo = 0;
		}

		con.close();

		return attachNo;
	}
}
