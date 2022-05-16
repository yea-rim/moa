package moa.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MemberDao;
import moa.beans.MemberDto;

@WebServlet (urlPatterns = "/member/edit_information.do")
public class EditInformationServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비 
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			
			
			String currentPw = req.getParameter("currentPw");
			String changePw = req.getParameter("changePw");
			
			
			MemberDto changeDto = new MemberDto();
			changeDto.setMemberPhone(req.getParameter("memberPhone"));
			changeDto.setMemberPost(req.getParameter("memberPost"));
			changeDto.setMemberBasicAddress(req.getParameter("memberBasicAddress"));
			changeDto.setMemberDetailAddress(req.getParameter("memberDetailAddress"));
			changeDto.setMemberNo(memberNo);
			
			// 처리 
			// 1. 기존 비밀번호와 새로운 비밀번호가 일치하는지 검사 
			boolean isSamePassword =  currentPw.equals(changePw); // 변경하면 안되는 상황 
			if(isSamePassword) {
				resp.sendRedirect("edit_information.jsp?error=1");
				return;
			}
			// 2. 입력창이 비어있는지 검사 
			boolean isEmpty = currentPw == null || changePw == null;
			if(isEmpty) {
				resp.sendRedirect("edit_information.jsp?error=2");
				return; 
			}
			
			// 3. 변경 진행 
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.selectOne(memberNo);
			
			memberDao.changeInformation(changeDto);
			memberDao.changePassword(memberDto.getMemberEmail(), changePw);
			
			
			// 출력 
			resp.sendRedirect(req.getContextPath()+"/member/my_page.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
