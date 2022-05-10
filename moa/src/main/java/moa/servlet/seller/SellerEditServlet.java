package moa.servlet.seller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.SellerDao;
import moa.beans.SellerDto;

@WebServlet(urlPatterns="/seller/edit.do")
public class SellerEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 준비
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNick(req.getParameter("sellerNick"));
			sellerDto.setSellerAccountBank(req.getParameter("sellerAccountBank"));
			sellerDto.setSellerAccountNo(req.getParameter("sellerAccountNo"));
			sellerDto.setSellerNo(Integer.parseInt(req.getParameter("sellerNo")));
			
			// 처리
			SellerDao sellerDao = new SellerDao();
			boolean isSuccess = sellerDao.edit(sellerDto);
			
			// 출력
			if(isSuccess) { // 수정 성공시 
				resp.sendRedirect(req.getContextPath()+"/seller/seller_wait.jsp");
			} else { // 수정 실패시 
				resp.sendRedirect(req.getContextPath()+"/seller/seller_wait.jsp?error");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
