package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.AttachDao;
import moa.beans.MemberProfileDao;
import moa.beans.MemberProfileDto;

@WebServlet(urlPatterns="/member/delete_profile.do")
public class MemberProfileDeleteServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			// 준비
			int memberNo = Integer.parseInt(req.getParameter("memberNo"));
			
			MemberProfileDao memberProfileDao = new MemberProfileDao();
			AttachDao attachDao = new AttachDao();
			
			// 처리
			MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberNo);
			memberProfileDao.delete(memberNo); // attachNo가 삭제되면 cascade로 memberProfile도 수정됨 
			attachDao.delete(memberProfileDto.getAttachNo());
			
			// 출력 
			resp.sendRedirect(req.getContextPath()+"/member/my_page.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
