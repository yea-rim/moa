package moa.servlet.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.CommunityDao;
import moa.beans.CommunityReplyDao;
import moa.beans.CommunityReplyDto;

@WebServlet(urlPatterns="/community/reply_insert.do")
public class CommunityReplyInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int communityNo = Integer.parseInt(req.getParameter("communityNo"));
			int communityMemberNo = (Integer)(req.getSession().getAttribute("login"));
			CommunityReplyDto communityReplyDto = new CommunityReplyDto();
			communityReplyDto.setCommunityNo(communityNo);
			communityReplyDto.setCommunityMemberNo(communityMemberNo);
			communityReplyDto.setCommunityReplyContent(req.getParameter("community_reply_content"));
			
			// 시퀀스 생성
			CommunityReplyDao communityReplyDao = new CommunityReplyDao();
			communityReplyDto.setCommunityReplyNo(communityReplyDao.getCommunityReplySeq());
			
			// communityReply 등록
			
			communityReplyDao.insert(communityReplyDto);
			
			CommunityDao communityDao = new CommunityDao();
			communityDao.updateReplyCount(communityNo);
			
			resp.sendRedirect("detail.jsp?communityNo="+communityNo);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
