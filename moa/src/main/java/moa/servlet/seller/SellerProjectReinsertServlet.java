package moa.servlet.seller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.ProjectDao;
import moa.beans.ProjectDto;

@WebServlet(urlPatterns="/seller/project_reinsert.do")
public class SellerProjectReinsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			System.out.println(Integer.parseInt(req.getParameter("projectNo")));
			System.out.println(req.getParameter("projectCategory"));
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(Integer.parseInt(req.getParameter("projectNo")));
			projectDto.setProjectCategory(req.getParameter("projectCategory"));
			projectDto.setProjectName(req.getParameter("projectName"));
			projectDto.setProjectSummary(req.getParameter("projectSummary"));
			projectDto.setProjectTargetMoney(Integer.parseInt(req.getParameter("projectTargetMoney")));
			projectDto.setProjectStartDate(Date.valueOf(req.getParameter("projectStartDate")));
			projectDto.setProjectSemiFinish(Date.valueOf(req.getParameter("projectSemiFinish")));
			projectDto.setProjectFinishDate(Date.valueOf(req.getParameter("projectSemiFinish")));			
			
			ProjectDao projectDao = new ProjectDao();
			boolean success = projectDao.edit(projectDto);
			
			
			if(success) {
				resp.sendRedirect("project_reapply.jsp?projectNo="+projectDto.getProjectNo());
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
