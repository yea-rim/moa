package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FundingStatusDao {
	//전체목록
	public List<FundingStatusDto> selectList() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from funding_status order by funding_date";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<FundingStatusDto> list = new ArrayList<>();
		while(rs.next()) {
			FundingStatusDto statusDto = new FundingStatusDto();
			statusDto.setFundingDate(rs.getString("funding_date"));
			statusDto.setTotal(rs.getInt("total"));

			list.add(statusDto);
		}
		
		con.close();
		return list;
	}
}
