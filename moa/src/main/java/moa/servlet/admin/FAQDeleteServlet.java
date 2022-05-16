package moa.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MoaFaqDao;
import moa.beans.MoaFaqDto;

@WebServlet(urlPatterns = "/admin/faq_delete.do")
public class FAQDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int faqNo = Integer.parseInt(req.getParameter("faqNo"));

			// 작성
			MoaFaqDao moaFaqDao = new MoaFaqDao();
			moaFaqDao.delete(faqNo);

			// 출력
			resp.sendRedirect(req.getContextPath()+"/faq/faq_list.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
