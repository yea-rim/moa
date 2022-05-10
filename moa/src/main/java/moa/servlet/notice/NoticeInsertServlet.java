package moa.servlet.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MoaNoticeDao;
import moa.beans.MoaNoticeDto;

@WebServlet(urlPatterns="/notice/insert.do")
public class NoticeInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			MoaNoticeDto moaNoticeDto = new MoaNoticeDto();
			moaNoticeDto.setNoticeTitle(req.getParameter("noticeTitle"));
			moaNoticeDto.setNoticeContent(req.getParameter("noticeContent"));
			moaNoticeDto.setNoticeAdminNo(0);
			
			MoaNoticeDao moaNoticeDao = new MoaNoticeDao();
			moaNoticeDto.setNoticeNo(moaNoticeDao.getMoaNoticeyNo());
			
			moaNoticeDao.insert(moaNoticeDto);
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
