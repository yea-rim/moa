package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
}
