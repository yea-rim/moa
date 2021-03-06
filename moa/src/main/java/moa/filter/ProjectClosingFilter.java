package moa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.ProjectDao;

//@WebFilter(filterName = "g8-project_closing", urlPatterns = "/project/project_closing.jsp")
public class ProjectClosingFilter implements Filter {
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		try {
			int projectNo = Integer.parseInt(request.getParameter("projectNo"));
			
			ProjectDao projectDao = new ProjectDao();
			int check = projectDao.checkProjectSchedule(projectNo);
			
			if(check == 1){
				resp.sendRedirect(req.getContextPath()+"/project/project_detail.jsp?projectNo="+projectNo);
			}else if(check == 0){
				resp.sendRedirect(req.getContextPath()+"/project/project_coming.jsp?projectNo="+projectNo);
			}else {
				chain.doFilter(request, response);
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
