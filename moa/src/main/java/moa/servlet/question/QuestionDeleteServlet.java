package moa.servlet.question;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MoaQuestionDao;


@WebServlet(urlPatterns = "/question/delete.do")
public class QuestionDeleteServlet extends HttpServlet{
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int questionNo = Integer.parseInt(req.getParameter("questionNo"));
			
			//댓글삭제
			MoaQuestionDao moaQuestionDao = new MoaQuestionDao();
			moaQuestionDao.delete(questionNo);
			
			
			//리스트로 이동
			if(req.getParameter("admin")!=null) {
				resp.sendRedirect(req.getContextPath()+"/admin/question_list.jsp");								
			}
			else {
				resp.sendRedirect(req.getContextPath()+"/member/my_page.jsp");				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
