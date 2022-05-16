package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

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
			MemberDto realMember = memberDao.selectOne(memberNo);
			
			// 현재 핸드폰 번호 
			String currentPhone = realMember.getMemberPhone();
			
			boolean isSame = currentPhone.equals(memberPhone);
			
			memberDao.changePhone(memberPhone, memberNo);
			
			if(isSame) {
				memberDao.changePhone(memberPhone, memberNo);
			} 
			
			// 출력
			resp.sendRedirect("my_page.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
