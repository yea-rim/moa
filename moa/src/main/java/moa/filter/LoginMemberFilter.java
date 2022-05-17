package moa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebFilter(filterName = "f2-login" , urlPatterns = {
//		"/community/insert.jsp",
//		"/community/insert.do",
//		"/community/reply_insert.do",
//		"/community/edit.do",
//		"/community/delete.do",
//		"/community/reply_insert.do",
//		"/community/reply_edit.do",
//		"/community/reply_delete.do",
//		"/member/change_address.jsp",
//		"/member/change_password.jsp",
//		"/member/change_phone.jsp",
//		"/member/confirm_pw.jsp",
//		"/member/exit.jsp",
//		"/member/funding_cancel_finish.jsp",
//		"/member/funding_cancel_info.jsp",
//		"/member/funding_cancel_list.jsp",
//		"/member/funding_finish_list.jsp",
//		"/member/funding_information.jsp",
//		"/member/funding_wait_list.jsp",
//		"/member/joa_list.jsp",
//		"/member/my_page.jsp",
//		"/member/profile.jsp",
//		"/member/funding_cancel.do",
//		"/member/confirm_pw.do",
//		"/member/edit_information.do",
//		"/member/change_address.do",
//		"/member/change_phone.do",
//		"/member/change_password.do",
//		"/member/exit.do",
//		"/member/edit.do",
//		"/member/logout.do",
//		"/member/delete_profile.do",
//		"/member/seller_wait.jsp",
//		"/project/qna_write.do",
//		"/project/qna_edit.do",
//		"/project/qna_delete.do",
//		"/project/funding.jsp",
//		"/project/funding_success.jsp",
//		"/project/funding_fail.jsp",
//		"/project/funding.do",
//		"/question/delete.do",
//		"/question/insert.do",
//		"/seller/*",
//		"/question/insert.jsp"
//})
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
