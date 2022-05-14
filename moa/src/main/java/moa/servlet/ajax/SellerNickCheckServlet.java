package moa.servlet.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;
import moa.beans.SellerDao;
import moa.beans.SellerDto;

@WebServlet(urlPatterns="/ajax/sellerNick.do")
public class SellerNickCheckServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			String sellerNick = req.getParameter("sellerNick");
			
			//처리
			SellerDao sellerDao = new SellerDao();
			SellerDto sellerDto = sellerDao.findByNickname(sellerNick);
			
			//출력
			if(sellerDto != null) {//사용중
				resp.getWriter().print("NN");
			}
			else {//사용가능
				resp.getWriter().print("YY");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
