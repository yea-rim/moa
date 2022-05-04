package moa.servlet.project;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.ProjectDao;
import moa.beans.ProjectDto;

@WebServlet(urlPatterns = "/project/insert.do")
public class ProjectInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {			
			
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectCategory(req.getParameter("projectCategory"));
			projectDto.setProjectName(req.getParameter("projectName"));
			projectDto.setProjectSummary(req.getParameter("projectSummary"));
			projectDto.setProjectTargetMoney(Integer.parseInt(req.getParameter("projectTargetMoney")));
			projectDto.setProjectStartDate(Date.valueOf(req.getParameter("projectStartDate")));
			projectDto.setProjectSemiFinish(Date.valueOf(req.getParameter("projectSemiFinish")));
			projectDto.setProjectFinishDate(Date.valueOf(req.getParameter("projectFinishDate")));
			
			ProjectDao projectDao = new ProjectDao();
			projectDao.insert(projectDto);
			
			resp.sendRedirect("insert_success.jsp");
			
			
			//String [] a = req.getParameterValues('a'); 
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
