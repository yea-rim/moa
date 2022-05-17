package moa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebFilter(filterName = "g0-cors", urlPatterns = "/ajax/*")
public class CorsFilter implements Filter {
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		try {
			
//			resp.setHeader("Access-Control-Allow-Origin", "http://127.0.0.1:5500");
			resp.setHeader("Access-Control-Allow-Headers", "Content-Type");
			
			chain.doFilter(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
	}

}
