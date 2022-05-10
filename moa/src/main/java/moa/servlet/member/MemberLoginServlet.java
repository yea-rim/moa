package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;
import moa.beans.SellerDao;
import moa.beans.SellerDto;

@WebServlet(urlPatterns = "/member/login.do")
public class MemberLoginServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			// 준비
			req.setCharacterEncoding("utf-8");
			String memberEmail = req.getParameter("memberEmail");
			String memberPw = req.getParameter("memberPw");
			
			
			// 처리
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.selectOne(memberEmail);
			SellerDao sellerDao = new SellerDao();
			SellerDto sellerDto = sellerDao.selectOne(memberDto.getMemberNo());
			
			
			// memberDto가 존재하면서 비밀번호 일치 여부 검사 
			boolean isLogin = memberDto != null && memberDto.getMemberPw().equals(memberPw);
			
//			System.out.println(isLogin);
			
			
			// 출력 
			if(isLogin) { // 로그인 성공 
				resp.sendRedirect(req.getContextPath()); // 메인 페이지로 이동
				
				// 세션에 login 추가
				req.getSession().setAttribute("login", memberDto.getMemberNo());
				
				if(sellerDto.getSellerRegistDate() != null) {
					req.getSession().setAttribute("sellerRegistDate", sellerDto.getSellerRegistDate());
				}
				
			} else { // 로그인 실패 
				resp.sendRedirect(req.getContextPath()+"/member/login.jsp?error");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}

}
