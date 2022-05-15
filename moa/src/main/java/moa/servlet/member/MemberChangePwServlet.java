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
			
			String currentPw = req.getParameter("currentPw");
			String changePw = req.getParameter("changePw");
			
			// 처리
			// 1. 기존 비밀번호와 새로운 비밀번호가 일치하는지 검사 
			boolean isSamePw = currentPw.equals(changePw);
			// 2. 입력창이 비어있는지 검사
			boolean isEmpty = currentPw == null || changePw ==  null;
			
			if(isSamePw || isEmpty) {
				resp.sendRedirect("change_password.jsp?error=1");
				return;
			}
		
			
			// 변경 진행
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.selectOne(memberNo);
			memberDao.changePassword(memberDto.getMemberEmail(), changePw);
			
			// 출력
			resp.sendRedirect(req.getContextPath()+"/member/my_page.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
