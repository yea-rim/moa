package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class JoinRouteStatusDao {
	//전체목록
	public List<JoinRouteStatusDto> selectList() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from join_route_stasus";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<JoinRouteStatusDto> list = new ArrayList<>();
		while(rs.next()) {
			JoinRouteStatusDto statusDto = new JoinRouteStatusDto();
			statusDto.setMemberRoute(rs.getString("member_route"));
			statusDto.setCnt(rs.getInt("cnt"));

			list.add(statusDto);
		}
		
		con.close();
		return list;
	}

}
