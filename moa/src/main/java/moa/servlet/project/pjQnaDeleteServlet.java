package moa.servlet.project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.PjQnaDao;

@WebServlet(urlPatterns = "/project/detail/qna_delete.do")
public class pjQnaDeleteServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int qnaNo = Integer.parseInt(req.getParameter("qnaNo"));
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			PjQnaDao pjQnaDao = new PjQnaDao();
			
			boolean delete = pjQnaDao.delete(qnaNo);
			
			resp.sendRedirect(req.getContextPath()+"/project/detail/qna.jsp?projectNo="+projectNo);
		
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
	}
	

}
