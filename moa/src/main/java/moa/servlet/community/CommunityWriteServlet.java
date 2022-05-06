package moa.servlet.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.CommunityDao;
import moa.beans.CommunityDto;
import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet(urlPatterns="/community/write.do")
public class CommunityWriteServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int communityProjectNo = Integer.parseInt(req.getParameter("communityProjectNo"));
			int communityMemberNo = (Integer)req.getSession().getAttribute("login");
			
			
			CommunityDto communityDto = new CommunityDto();
			communityDto.setCommunityProjectNo(communityProjectNo);
			communityDto.setCommunityMemberNo(communityMemberNo);
			communityDto.setCommunityTitle(req.getParameter("communityTitle"));
			communityDto.setCommunityContent(req.getParameter("communityContent"));
			
			// 시퀀스 생성
			CommunityDao communityDao = new CommunityDao();
			communityDto.setCommunityNo(communityDao.getCommunityNo());
			
			// 작성
			communityDao.insert(communityDto);
			
			// 출력
			resp.sendRedirect("list.jsp");
//			resp.sendRedirect("detail.jsp?communityNo="+communityDto.getCommunityNo());
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
