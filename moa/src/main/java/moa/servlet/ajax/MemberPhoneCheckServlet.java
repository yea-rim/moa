package moa.servlet.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns="/ajax/phone.do")
public class MemberPhoneCheckServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			String memberPhone = req.getParameter("memberPhone");
			
			//처리
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.findByPhone(memberPhone);
			
			MemberDto realMember = memberDao.selectOne(memberNo);
			
			// 현재 핸드폰 번호 
			String currentPhone = realMember.getMemberPhone();
						
			boolean isSame = currentPhone.equals(memberPhone);
			
			//출력
			if(memberDto == null || isSame) {// 사용 가능 
				resp.getWriter().print("Yes");
			}
			else {//사용가능
				resp.getWriter().print("No");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
