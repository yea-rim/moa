package moa.servlet.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns="/ajax/id.do")
public class MemberEmailCheckServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 아이디
			String memberEmail = req.getParameter("memberEmail");
			
			//처리 : 아이디 검색
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.selectOne(memberEmail);
			
			//출력
			resp.setContentType("text/plain; charset=UTF-8");
			if(memberDto != null) {//아이디가 있으면 -> 사용 불가
				resp.getWriter().print("NNNNN");
			}
			else {//아이디가 없으면 -> 사용 가능
				resp.getWriter().print("NNNNY");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}