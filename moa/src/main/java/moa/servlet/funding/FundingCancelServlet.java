package moa.servlet.funding;

import java.io.IOException;
import java.io.PrintWriter;

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
			
			fundingDao.fundingCancel(fundingNo);
			
			resp.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = resp.getWriter(); 
			writer.println("<script>alert('후원 취소가 완료되었습니다.'); location.href='"+req.getContextPath()+"/member/funding_cancel_list.jsp';</script>"); writer.close();
			
		} catch (Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}  
}
