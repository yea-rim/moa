package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns = "/member/find_pw.do")
public class MemberFindPwServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberEmail(req.getParameter("memberEmail"));
			memberDto.setMemberPhone(req.getParameter("memberPhone"));
			memberDto.setMemberNick(req.getParameter("memberNick"));

			// 처리
			MemberDao memberDao = new MemberDao();
			MemberDto findDto = memberDao.findPw(memberDto);

			// 출력
			if (findDto != null) {
				resp.sendRedirect("set_pw.jsp?memberEmail=" + findDto.getMemberEmail());
			} else {
				resp.sendRedirect("find_pw.jsp?error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
