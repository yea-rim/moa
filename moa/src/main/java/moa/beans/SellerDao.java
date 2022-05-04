package moa.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SellerDao {

	public void request(SellerDto sellerDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into seller(seller_no, seller_regist_date, seller_account_bank, seller_account_no, "
				+ "seller_nick, seller_type) values (?, sysdate, ?, ?, ?, ?)";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, sellerDto.getSellerNo());
		ps.setString(2, sellerDto.getSellerAccountBank());
		ps.setString(3, sellerDto.getSellerAccountNo());
		ps.setString(4, sellerDto.getSellerNick());
		ps.setString(5, sellerDto.getSellerType());
		ps.execute();

		con.close();

	}

}
