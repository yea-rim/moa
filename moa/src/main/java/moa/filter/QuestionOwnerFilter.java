package moa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MoaQuestionDao;

//1:1문의 삭제 필터
@WebFilter(filterName = "g4-questionOwner" , urlPatterns = {		
				"/question/delete.do"
				})
public class QuestionOwnerFilter implements Filter{
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		try {		
			// 1. 관리자인지 확인
			Integer admin  = (Integer) req.getSession().getAttribute("admin");
			
			if(admin != null) {
				chain.doFilter(request, response);
				return;
			}
			
			// 2. 작성자 본인인지 확인
			int memberNo = (int) req.getSession().getAttribute("login");
			int questionNo = Integer.parseInt(req.getParameter("questionNo"));
			
			MoaQuestionDao moaQuestionDao = new MoaQuestionDao();
			int questionWriter = moaQuestionDao.selectWriter(questionNo);
			//Login 필터를 거쳐오기 때문에 null일 수가 없으므로 null 검사는 안해도 됨
			boolean auth = memberNo==questionWriter;
			
			if(auth) {
				chain.doFilter(request, response);
			}else { //본인이아니라면: 권한 없음 에러 발생(403, forbidden)
				resp.sendError(403);			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
