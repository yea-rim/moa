package moa.servlet.seller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.SellerDao;
import moa.beans.SellerDto;

@WebServlet(urlPatterns = "/seller/list.do")
public class SellerListServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 처리
			SellerDao sellerDao = new SellerDao();
			List<SellerDto> list = sellerDao.selectList();

			// 출력
			for (SellerDto sellerDto : list) {
				resp.getWriter().println(sellerDto);
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}