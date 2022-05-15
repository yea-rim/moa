package moa.servlet.seller;

import java.io.IOException;
import java.io.PrintWriter;

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
				resp.setContentType("text/html; charset=UTF-8"); 
				PrintWriter writer = resp.getWriter(); 
				writer.println("<script>alert('프로젝트 재신청이 완료되었습니다.'); location.href='"+req.getContextPath()+"/seller/my_permit_project.jsp';</script>"); writer.close();

			} else {
				resp.sendRedirect("project_reapply_finish.jsp?error");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
