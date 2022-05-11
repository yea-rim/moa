package moa.servlet.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.CommunityReplyDao;

@WebServlet(urlPatterns="/community/reply_delete.do")
public class CommunityReplyDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int communityNo = Integer.parseInt(req.getParameter("communityNo"));
			int communityReplyNo = Integer.parseInt(req.getParameter("communityReplyNo"));
			
			CommunityReplyDao communityReplyDao = new CommunityReplyDao();
			communityReplyDao.delete(communityReplyNo);
			
			resp.sendRedirect("detail.jsp?communityNo="+communityNo);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
