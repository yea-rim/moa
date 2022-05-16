package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns="/member/change_address.do")
public class MemberChangeAddressServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 준비
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberNo(memberNo);
			memberDto.setMemberPost(req.getParameter("memberPost"));
			memberDto.setMemberBasicAddress(req.getParameter("memberBasicAddress"));
			memberDto.setMemberDetailAddress(req.getParameter("memberDetailAddress"));
			
			// 처리
			MemberDao memberDao = new MemberDao();
			memberDao.changeAddress(memberDto);
			
			// 출력
			resp.sendRedirect("my_page.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
