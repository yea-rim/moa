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
			SellerDto changeDto = new SellerDto();
			changeDto.setSellerNick(req.getParameter("sellerNick"));
			changeDto.setSellerAccountBank(req.getParameter("sellerAccountBank"));
			changeDto.setSellerAccountNo(req.getParameter("sellerAccountNo"));
			changeDto.setSellerNo(Integer.parseInt(req.getParameter("sellerNo")));
			
			// 처리
			SellerDao sellerDao = new SellerDao();
			SellerDto sellerDto = sellerDao.selectOne(Integer.parseInt(req.getParameter("sellerNo")));
			boolean isSuccess = sellerDao.edit(changeDto);
			boolean isSeller = sellerDto.getSellerPermission() == 1;
			
//			System.out.println(sellerDto2.getSellerPermission());
//			System.out.println(isSeller);
			
			// 출력
			if(isSuccess) { // 수정 성공시 
				if(isSeller) { // 판매자 승인이 났으면  
					resp.sendRedirect(req.getContextPath()+"/seller/my_page.jsp");
				} else { // 판매자 승인이 나지 않았으면 
					resp.sendRedirect(req.getContextPath()+"/seller/seller_wait.jsp");
				}
			} else { // 수정 실패시 
				resp.sendRedirect(req.getContextPath()+"/seller/seller_wait.jsp?error");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
