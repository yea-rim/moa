package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns = "/member/find_email.do")
public class MemberFindEmailServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberNick(req.getParameter("memberNick"));
			memberDto.setMemberPhone(req.getParameter("memberPhone"));

			// 처리
			MemberDao memberDao = new MemberDao();
			String memberEmail = memberDao.findEmail(memberDto);

			// 출력
			if (memberEmail == null) {
				resp.sendRedirect("find_email.jsp?error");
			} else {
				resp.sendRedirect("find_email_result.jsp?memberEmail=" + memberEmail);
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
