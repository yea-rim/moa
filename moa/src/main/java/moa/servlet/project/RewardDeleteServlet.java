package moa.servlet.project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.RewardDao;

@WebServlet(urlPatterns = "/admin/rewardDelete.do")
public class RewardDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int rewardNo =  Integer.parseInt(req.getParameter("rewardNo"));
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			RewardDao rewardDao = new RewardDao();
			boolean success = rewardDao.delete(rewardNo);
			
			if(success) {
				resp.sendRedirect("rewardEdit.jsp?projectNo="+projectNo);
			}
			else {
				resp.sendError(404);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
