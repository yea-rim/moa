package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;

@WebServlet(urlPatterns = "/member/exit.do")
public class MemberExitServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 준비
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			System.out.println(memberNo);
			
			
			// 처리
			MemberDao memberDao = new MemberDao();
			memberDao.exit(memberNo);
			
			req.getSession().removeAttribute("login");
			req.getSession().removeAttribute("admin");
			
			// 출력 
			resp.sendRedirect("exit_finish.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
