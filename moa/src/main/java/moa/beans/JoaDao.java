package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class JoaDao {

	// 목록 조회 
	public List<JoaDto> selectList(int memberNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from joa J "
				+ "inner join project P on P.project_no = J.project_no "
				+ "where J.member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		
		ResultSet rs = ps.executeQuery();
		
		List<JoaDto> list = new ArrayList<>();
		
		if(rs.next()) {
			JoaDto joaDto = new JoaDto();
			
			joaDto.setProjectNo(rs.getInt("project_no"));
			joaDto.setMemberNo(rs.getInt("member_no"));
			
			list.add(joaDto);
		}
		
		con.close();
		
		return list; 
	}
}
