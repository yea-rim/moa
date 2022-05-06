package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns = "/member/confirm_pw.do")
public class ConfirmPwServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			String memberPw = req.getParameter("memberPw");
			
			// 처리
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.selectOne(memberNo);
			
			boolean isCorrect = memberDto.getMemberPw().equals(memberPw);
			
			// 출력 
			if(isCorrect) {
				resp.sendRedirect(req.getContextPath()+"/member/edit_information.jsp");
			} else {
				resp.sendRedirect(req.getContextPath()+"/member/confirm_pw.jsp?error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
