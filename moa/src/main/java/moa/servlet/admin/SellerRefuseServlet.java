package moa.servlet.admin;

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

@WebServlet(urlPatterns="/admin/refuse.do")
public class SellerRefuseServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			int sellerNo = Integer.parseInt(req.getParameter("sellerNo"));
			int memberNo = Integer.parseInt(req.getParameter("sellerNo"));
			String sellerRefuseMsg = req.getParameter("sellerRefuseMsg");
			
			//처리
			SellerDao sellerDao = new SellerDao();
			boolean success = sellerDao.refuse(sellerNo, sellerRefuseMsg);

			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.selectOne(memberNo);
			
			SellerDto sellerDto = sellerDao.selectOne(memberDto.getMemberNo());
			
			//출력
			
			System.out.println(success);
			System.out.println(req.getParameter("sellerPermission"));
			
			if(success) {
				resp.sendRedirect("seller_join_list.jsp");
				req.getSession().setAttribute("seller", sellerDto.getSellerPermission());	
			}
			else {
				resp.sendRedirect("approve_refuse.jsp");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}



