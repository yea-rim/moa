package moa.servlet.project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.ProjectDao;

@WebServlet(urlPatterns = "/admin/projectRefuse.do")
public class ProjectRefuseServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			String projectRefuseMsg = req.getParameter("projectRefuseMsg");
			
			ProjectDao projectDao = new ProjectDao();
			boolean success = projectDao.projectRefuse(projectNo,projectRefuseMsg);
			
			if(success) {
				resp.sendRedirect(req.getContextPath()+"/admin/projectList.jsp");
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
