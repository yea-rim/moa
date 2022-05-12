package moa.servlet.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns="/ajax/nick.do")
public class MemberNickCheckServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			String memberNick = req.getParameter("memberNick");
			
			//처리
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.findByNickname(memberNick);
			
			//출력
			if(memberDto != null) {//사용중
				resp.getWriter().print("N");
			}
			else {//사용가능
				resp.getWriter().print("Y");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
