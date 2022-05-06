package moa.servlet.seller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.SellerDao;
import moa.beans.SellerDto;

@WebServlet(urlPatterns = "/seller/detail.do")
public class SellerDetailServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			int sellerNo = Integer.parseInt(req.getParameter("sellerNo"));
			
			//처리		
			SellerDao sellerDao = new SellerDao();
			SellerDto sellerDto = sellerDao.selectOne(sellerNo);
			
			//출력
			resp.setContentType("text/plain;charset=UTF-8");
			if(sellerDto == null) {
				resp.getWriter().println("존재하지 않는 판매자입니다.");
			}
			else {
				resp.getWriter().println("판매자 번호 : " + sellerDto.getSellerNo());
				resp.getWriter().println("닉네임 : " + sellerDto.getSellerNick());
				resp.getWriter().println("은행 : " + sellerDto.getSellerAccountBank());
				resp.getWriter().println("계좌 : " + sellerDto.getSellerAccountNo());
				resp.getWriter().println("판매자 유형 : " + sellerDto.getSellerType());
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}