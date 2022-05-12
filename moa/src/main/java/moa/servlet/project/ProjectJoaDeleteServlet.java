package moa.servlet.project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.JoaDao;

@WebServlet("/project/joa_delete.do")
public class ProjectJoaDeleteServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			// 준비
			int memberNo = Integer.parseInt(req.getParameter("memberNo"));
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			// 처리 
			JoaDao joaDao = new JoaDao();
			joaDao.delete(projectNo, memberNo);
			
			// 출력 
			resp.sendRedirect(req.getContextPath()+"/member/joa_list.jsp");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
