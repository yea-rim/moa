package moa.servlet.seller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.BannerDao;
import moa.beans.BannerDto;

@WebServlet(urlPatterns="/seller/banner_insert.do")
public class BannerInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			int attachNo = Integer.parseInt(req.getParameter("projectAttach"));
			int bannerTerm = Integer.parseInt(req.getParameter("bannerTerm"));
			
			BannerDto bannerDto = new BannerDto();
			bannerDto.setProjectNo(projectNo);
			bannerDto.setAttachNo(attachNo);
			bannerDto.setBannerTerm(bannerTerm);
			
			BannerDao bannerDao = new BannerDao();
			
			// banner 시퀀스 생성 
			bannerDto.setBannerNo(bannerDao.getSequence());
			
			// 기존에 신청했는지 확인
			BannerDto bannerDto2 = bannerDao.selectOne(projectNo);
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			if(bannerDto2 == null) {
				bannerDao.insert(bannerDto);
				writer.println("<script>alert('배너 신청이 완료되었습니다.'); location.href='"+req.getContextPath()+"/seller/my_page.jsp';</script>"); writer.close();
			}
			else {
				writer.println("<script>alert('이미 신청한 프로젝트입니다.'); location.href='"+req.getContextPath()+"/seller/my_page.jsp';</script>"); writer.close();
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
