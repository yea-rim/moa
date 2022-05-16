package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns="/member/change_password.do")
public class MemberChangePwServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			
			String changePw = req.getParameter("changePw");
			
			// 처리
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.selectOne(memberNo);
			
			String currentPw = memberDto.getMemberPw();
			
			// 1 현재 비밀번호 일치 검사 
			boolean isSame = currentPw.equals(changePw);
			
			if (isSame) {
				resp.sendRedirect(req.getContextPath()+"/member/change_password.jsp?error");
				return;
			}
			
			// 변경 진행
			memberDao.changePassword(memberDto.getMemberEmail(), changePw);
				
		
			// 출력
			resp.sendRedirect(req.getContextPath()+"/member/my_page.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
