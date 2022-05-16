package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;

@WebServlet(urlPatterns="/member/change_phone.do")
public class MemberChangePhoneSerlvet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 준비
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			String memberPhone = req.getParameter("memberPhone");
			
			// 처리
			MemberDao memberDao = new MemberDao();
			boolean isSuccess = memberDao.changePhone(memberPhone, memberNo);
			
			// 출력
			if(isSuccess) {
				resp.sendRedirect("my_page.jsp");
			} else {
				resp.sendError(500);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
