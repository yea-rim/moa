package moa.servlet.seller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.SellerDao;
import moa.beans.SellerDto;

@WebServlet(urlPatterns = "/seller/sellerRequest.do")
public class SellerRequestServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNo(Integer.parseInt(req.getParameter("sellerNo")));
			sellerDto.setSellerNick(req.getParameter("sellerNick"));
			sellerDto.setSellerAccountBank(req.getParameter("sellerAccountBank"));
			sellerDto.setSellerAccountNo(req.getParameter("sellerAccountNo"));
			sellerDto.setSellerType(req.getParameter("sellerType"));

			// 처리
			SellerDao sellerDao = new SellerDao();
			sellerDao.insert(sellerDto);

			// 출력
			resp.sendRedirect(req.getContextPath() + "/seller/request_finish.jsp");
			
			req.getSession().setAttribute("sellerNo", sellerDto.getSellerNo());
			req.getSession().setAttribute("sellerRegistDate", sellerDto.getSellerRegistDate());
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
