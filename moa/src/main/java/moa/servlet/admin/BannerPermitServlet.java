package moa.servlet.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.BannerDao;
import moa.beans.ProjectDao;

@WebServlet("/admin/banner_permit.do")
public class BannerPermitServlet extends HttpServlet{
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			BannerDao bannerDao = new BannerDao();
			boolean success = bannerDao.bannerPermit(projectNo);
			
			resp.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = resp.getWriter(); 
			if(success) {
				writer.println("<script>alert('배너 승인이 완료되었습니다.'); location.href='"+req.getContextPath()+"/admin/banner_list.jsp';</script>"); writer.close();
			} else {
				writer.println("<script>alert('배너 승인에 실패하였습니다.'); location.href='"+req.getContextPath()+"/admin/banner_list.jsp';</script>"); writer.close();
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
