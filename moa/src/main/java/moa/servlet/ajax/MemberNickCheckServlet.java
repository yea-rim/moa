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
			int memberNo = (Integer) req.getSession().getAttribute("login");
			
			//처리
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.findByNickname(memberNick);
			MemberDto realMemberDto = memberDao.selectOne(memberNo);
			
			
			//출력
			if(memberDto == null || memberDto.getMemberNick().equals(realMemberDto.getMemberNick())) {//사용중
				resp.getWriter().print("Y");
			}
			else {//사용가능
				resp.getWriter().print("N");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
