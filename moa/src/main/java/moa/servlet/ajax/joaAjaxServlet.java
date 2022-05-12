package moa.servlet.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.JoaDao;

@WebServlet(urlPatterns="/ajax/joa.do")
public class joaAjaxServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			Integer memberNo = (Integer)req.getSession().getAttribute("login");

			boolean login = memberNo != null;
			resp.setContentType("text/plain; charset=UTF-8");
			
			if(!login) {
				resp.getWriter().print("login");
				return;
			}
			JoaDao joaDao = new JoaDao();
			
			
			if(joaDao.isSearch(projectNo, memberNo)) {
				joaDao.delete(projectNo, memberNo);
				resp.getWriter().print("delete");
				
			}else {
				joaDao.insert(projectNo, memberNo);
				resp.getWriter().print("insert");
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
