package moa.servlet.project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.ProjectDao;

@WebServlet(urlPatterns = "/admin/projectPermit.do")
public class ProjectPermitServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			ProjectDao projectDao = new ProjectDao();
			boolean success = projectDao.projectPermit(projectNo);
			
			if(success) {
				resp.sendRedirect(req.getContextPath()+"/admin/permit_success.jsp");
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
