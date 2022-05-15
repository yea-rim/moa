package moa.servlet.seller;

import java.io.IOException;

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
			bannerDao.insert(bannerDto);
			
			resp.sendRedirect("my_page.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
