package moa.servlet.seller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.AttachDao;

@WebServlet("/seller/attach_delete.do")
public class SellerProjectAttachDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int attachNo = Integer.parseInt(req.getParameter("attachNo"));
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			AttachDao attachDao = new AttachDao();
			boolean success = attachDao.delete(attachNo);
			
			if(success) {
				resp.sendRedirect("attach_edit.jsp?projectNo="+projectNo);
			}else {
				resp.sendError(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
