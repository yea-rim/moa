package moa.servlet.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.CommunityReplyDao;
import moa.beans.CommunityReplyDto;

@WebServlet(urlPatterns="/community/reply_edit.do")
public class CommunityReplyEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int communityNo = Integer.parseInt(req.getParameter("communityNo"));
			CommunityReplyDao communityReplyDao = new CommunityReplyDao();
			int communityReplyNo = Integer.parseInt(req.getParameter("communityReplyNo"));
			String communityReplyContent = req.getParameter("communityReplyContent");
			
			communityReplyDao.edit(communityReplyNo, communityReplyContent);
			
			resp.sendRedirect("detail.jsp?communityNo="+communityNo);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
