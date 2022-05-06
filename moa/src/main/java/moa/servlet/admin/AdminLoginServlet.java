package moa.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.AdminDao;
import moa.beans.AdminDto;

@WebServlet(urlPatterns = "/member/adminLogin.do")
public class AdminLoginServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 1. 준비 
			// 파라미터 받기 
			String adminId = req.getParameter("adminId");
			
			// 2. 처리 
			AdminDao adminDao = new AdminDao();
			AdminDto adminDto = adminDao.selectOne(adminId);
			
			// 유효성 판정 
			boolean isLogin =  adminDto != null && adminDto.getAdminPw().equals(adminId);
			
			// 3. 출력 
			if(isLogin) { // 로그인 성공 
				// 메인 페이지로 이동
				resp.sendRedirect(req.getContextPath()+"/admin/admin_main.jsp");

				// 권한 세션 갱신 
				req.getSession().setAttribute("admin", adminId);
			} else { // 로그인 실패 
				// 로그인 페이지로 "error" 파라미터 전송 
				resp.sendRedirect(req.getContextPath()+"/admin/login.jsp?error"); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
