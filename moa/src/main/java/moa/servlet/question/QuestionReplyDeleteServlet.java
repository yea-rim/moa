package moa.servlet.question;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MoaQuestionDao;
import moa.beans.MoaQuestionReplyDao;


@WebServlet(urlPatterns = "/admin/questionReplyDelete.do")
public class QuestionReplyDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int questionNo = Integer.parseInt(req.getParameter("questionNo"));
			
			//댓글삭제
			MoaQuestionReplyDao moaQuestionReplyDao = new MoaQuestionReplyDao();
			moaQuestionReplyDao.delete(questionNo);
			
			//답변여부
			MoaQuestionDao moaQuestionDao = new MoaQuestionDao();
			moaQuestionDao.cencleAnswer(questionNo);
			
			//리스트로 이동
			resp.sendRedirect("question_list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
