package moa.servlet.project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.PjQnaDao;
import moa.beans.PjQnaDto;

@WebServlet(urlPatterns = "/project/detail/qna_edit.do")
public class pjQnaEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			int qnaNo = Integer.parseInt(req.getParameter("qnaNo"));
			String qnaTitle = req.getParameter("qnaTitle");
			String qnaContent = req.getParameter("qnaContent");
			int qnaLock;
			if(req.getParameter("qnaLock") != null) {
				qnaLock = Integer.parseInt(req.getParameter("qnaLock"));
			}else {
				qnaLock = 0;
			}
			
			PjQnaDao pjQnaDao = new PjQnaDao();
			PjQnaDto pjQnaDto = new PjQnaDto();
			
			pjQnaDto.setQnaNo(qnaNo);
			pjQnaDto.setQnaTitle(qnaTitle);
			pjQnaDto.setQnaContent(qnaContent);
			pjQnaDto.setQnaLock(qnaLock);
			
			pjQnaDao.edit(pjQnaDto);
			
			resp.sendRedirect(req.getContextPath()+"/project/detail/qna.jsp?projectNo="+projectNo);
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
