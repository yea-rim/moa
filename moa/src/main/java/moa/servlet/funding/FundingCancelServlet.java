package moa.servlet.funding;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.FundingDao;

@WebServlet(urlPatterns="/member/funding_cancel.do")
public class FundingCancelServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 펀딩취소 : 펀딩 테이블 - cancelDate 활성화
			int fundingNo = Integer.parseInt(req.getParameter("fundingNo"));
			
			// 처리
			FundingDao fundingDao = new FundingDao();
			boolean isSuccess = fundingDao.cancelFunding(fundingNo);
			
			
			// 출력
			if(isSuccess) {
				resp.sendRedirect("funding_cancel_finish.jsp");
			} else {
				resp.sendError(500);
			}
			
		} catch (Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}  
}
