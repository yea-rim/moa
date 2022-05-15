package moa.servlet.project;

import java.io.IOException;
import java.io.PrintWriter;

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
			
			resp.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = resp.getWriter(); 
			if(success) {
				writer.println("<script>alert('프로젝트 승인이 완료되었습니다.'); location.href='"+req.getContextPath()+"/admin/projectList.jsp';</script>"); writer.close();
			} else {
				resp.sendError(404);
				writer.println("<script>alert('프로젝트 승인에 실패하였습니다.'); location.href='"+req.getContextPath()+"/admin/projectList.jsp';</script>"); writer.close();
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
