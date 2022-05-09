package moa.servlet.project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.PjQnaDao;
import moa.beans.PjQnaDto;

@WebServlet(urlPatterns = "/project/detail/qna_write.do")
public class pjQnaWriteServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			int memberNo = Integer.parseInt(req.getParameter("memberNo"));
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
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
			
			int seq = pjQnaDao.getSequence();
			
			pjQnaDto.setQnaNo(seq);
			pjQnaDto.setQnaMemberNo(memberNo);
			pjQnaDto.setQnaProjectNo(projectNo);
			pjQnaDto.setQnaTitle(qnaTitle);
			pjQnaDto.setQnaContent(qnaContent);
			pjQnaDto.setQnaLock(qnaLock);
			pjQnaDto.setGroupNo(seq);
					
			if(req.getParameter("superNo") != null) {
				int superNo = Integer.parseInt(req.getParameter("superNo"));
				PjQnaDto originDto = pjQnaDao.selectOne(superNo);
				pjQnaDto.setGroupNo(originDto.getGroupNo());
				pjQnaDto.setSuperNo(originDto.getQnaNo());
				pjQnaDto.setDepth(originDto.getDepth()+1);
			}
			
			pjQnaDao.write(pjQnaDto);
			
			resp.sendRedirect(req.getContextPath()+"/project/detail/qna.jsp?projectNo="+projectNo);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}

}
