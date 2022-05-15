package moa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebFilter(urlPatterns = {"/seller/*"})
public class SellerFilter implements Filter{
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		try {		
			Integer seller = (Integer) req.getSession().getAttribute("seller");
			
			//판매자 세션이 null이면
			if(seller == null) {
				resp.sendRedirect(req.getContextPath());
			} 
			else { 
				chain.doFilter(request, response); // 통과 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
