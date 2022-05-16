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

import moa.beans.PjQnaDao;
import moa.beans.PjQnaDto;
import moa.beans.ProjectDao;
import moa.beans.ProjectDto;

@WebFilter (filterName = "g2-pjQna", urlPatterns = {"/project/detail/qna_write.do","/project/detail/qna_edit.do","/project/detail/qna_delete.do"})
public class PjQnaFilter implements Filter {
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		try {
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			Integer admin  = (Integer) req.getSession().getAttribute("admin");
			Integer seller = (Integer) req.getSession().getAttribute("seller");
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			//qnaNo가 넘어왔다면 edit나 delete란 뜻으로 작성자나 관리자인지 검사
			if(req.getParameter("qnaNo") != null) {
				Integer qnaNo = Integer.parseInt(req.getParameter("qnaNo"));
				PjQnaDao pjQnaDao = new PjQnaDao();
				PjQnaDto pjQnaDto = pjQnaDao.selectOne(qnaNo);
				if((pjQnaDto.getQnaNo()==memberNo) || admin != null) {
					chain.doFilter(req, resp);
				}else {
					resp.sendError(403);
				}
			}
			
			//qna_write.do 필터링 답글일경구
			if(req.getParameter("superNo")!=null) {
				Integer superNo = Integer.parseInt(req.getParameter("superNo"));
				ProjectDao projectDao = new ProjectDao();
				ProjectDto projectDto = projectDao.selectOne(projectNo);
				if((seller != null && memberNo == projectDto.getProjectSellerNo()) || admin != null) {
					chain.doFilter(req, resp);
				}else {
					resp.sendError(403);
				}
			}
			
			//문의하기 로그인한경우 진행
			if(memberNo != null) {
				chain.doFilter(req, resp);
			}else {
				resp.sendRedirect(req.getContextPath()+"/member/login.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
	

}
