package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns = "/member/join.do")
public class MemberJoinServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberEmail(req.getParameter("memberEmail"));
			memberDto.setMemberPw(req.getParameter("memberPw"));
			memberDto.setMemberNick(req.getParameter("memberNick"));
			memberDto.setMemberPhone(req.getParameter("memberPhone"));
//			memberDto.setMemberRoute(req.getParameter("memberRoute"));

			// 처리
			MemberDao memberDao = new MemberDao();
			int memberNo = memberDao.getSequence();
			memberDto.setMemberNo(memberNo);
			memberDao.join(memberDto);

			// 출력
			 resp.sendRedirect(req.getContextPath()+"/member/join_finish.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
