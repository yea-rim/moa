package moa.servlet.seller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.ProjectDao;

@WebServlet(urlPatterns="/seller/project_reapply.do")
public class SellerProjectReapplyServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			// 준비
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			// 처리
			ProjectDao projectDao = new ProjectDao();
			boolean isSuccess = projectDao.reapply(projectNo);
			
			// 출력
			if(isSuccess) {
				resp.sendRedirect("project_reapply_finish.jsp");
			} else {
				resp.sendRedirect("project_reapply_finish.jsp?error");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
