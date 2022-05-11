package moa.servlet.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.AttachDao;
import moa.beans.AttachDto;
import moa.beans.MoaNoticeAttachDao;
import moa.beans.MoaNoticeAttachDto;
import moa.beans.MoaNoticeDao;

@WebServlet(urlPatterns="/notice/delete.do")
public class NoticeDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int noticeNo = Integer.parseInt(req.getParameter("noticeNo"));
			
			MoaNoticeAttachDao moaNoticeAttachDao = new MoaNoticeAttachDao();
			MoaNoticeAttachDto moaNoticeAttachDto = moaNoticeAttachDao.selectOne(noticeNo);
			

			AttachDto attachDto;
			AttachDao attachDao;
			if(moaNoticeAttachDto != null) {
				int attachNo = moaNoticeAttachDto.getAttachNo();
				attachDao = new AttachDao();	
				attachDto = attachDao.selectOne(attachNo);
			}
			else {
				attachDto = null;
				attachDao = null;
			}
			
			// 처리
			MoaNoticeDao moaNoticeDao = new MoaNoticeDao();
			
			if(moaNoticeAttachDto != null && attachDto != null) {
				moaNoticeAttachDao.delete(noticeNo);
				moaNoticeDao.delete(noticeNo);
				attachDao.delete(moaNoticeAttachDto.getAttachNo());
			}
			else {
				moaNoticeDao.delete(noticeNo);
			}
			
			// 출력
			resp.sendRedirect("list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}	
