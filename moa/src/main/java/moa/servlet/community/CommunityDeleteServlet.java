package moa.servlet.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.AttachDao;
import moa.beans.AttachDto;
import moa.beans.CommunityDao;
import moa.beans.CommunityPhotoDao;
import moa.beans.CommunityPhotoDto;

@WebServlet(urlPatterns="/community/delete.do")
public class CommunityDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비
			int communityNo = Integer.parseInt(req.getParameter("communityNo"));
			
			CommunityPhotoDao communityPhotoDao = new CommunityPhotoDao();
			CommunityPhotoDto communityPhotoDto = communityPhotoDao.selectOne(communityNo);
			
			
			AttachDto attachDto;
			AttachDao attachDao;
			if(communityPhotoDto != null) {
				int attachNo = communityPhotoDto.getAttachNo();
				attachDao = new AttachDao();	
				attachDto = attachDao.selectOne(attachNo);
			}
			else {
				attachDto = null;
				attachDao = null;
			}
			
			// 처리
			CommunityDao communityDao = new CommunityDao();
			
			if(communityPhotoDto != null && attachDto != null) {
				communityPhotoDao.delete(communityNo);
				communityDao.delete(communityNo);
				attachDao.delete(communityPhotoDto.getAttachNo());
			}
			else {
				communityDao.delete(communityNo);
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
