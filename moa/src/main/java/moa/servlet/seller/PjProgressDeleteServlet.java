package moa.servlet.seller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.AttachDao;
import moa.beans.AttachDto;
import moa.beans.PjProgressDao;
import moa.beans.ProgressAttachDao;
import moa.beans.ProgressAttachDto;

@WebServlet(urlPatterns = "/seller/progress_delete.do")
public class PjProgressDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비
			int progressNo = Integer.parseInt(req.getParameter("progressNo"));

			ProgressAttachDao progressAttachDao = new ProgressAttachDao();
			ProgressAttachDto progressAttachDto = progressAttachDao.selectOne(progressNo);

			AttachDto attachDto;
			AttachDao attachDao;
			if (progressAttachDto != null) {
				int attachNo = progressAttachDto.getAttachNo();
				attachDao = new AttachDao();
				attachDto = attachDao.selectOne(attachNo);
			} else {
				attachDto = null;
				attachDao = null;
			}
			
			// 처리
			PjProgressDao pjProgressDao = new PjProgressDao();
			pjProgressDao.delete(progressNo);
			

			// 출력
			resp.sendRedirect("my_page.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
