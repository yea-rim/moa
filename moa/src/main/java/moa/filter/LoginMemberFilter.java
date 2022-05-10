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

/*@WebFilter(urlPatterns = {
		
})*/
public class LoginMemberFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		try {
			
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			
			if(memberNo == null) { // 비어있으면 
				resp.sendRedirect(req.getContextPath()+"/member/login.jsp");
				// +) resp.sendError(401); => 401 (Unauthorize - 미인증) 
			} else { // 로그인 정보 있으면 
				chain.doFilter(request, response); // 통과 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
