package moa.servlet.question;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.MoaQuestionDao;
import moa.beans.MoaQuestionReplyDao;

@WebServlet(urlPatterns = "/admin/questionReplyInsert.do")
public class QuestionReplyInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int questionNo = Integer.parseInt(req.getParameter("questionTargetNo"));
			String qustionContent = req.getParameter("questionReplyContent");
			
			//댓글등록
			MoaQuestionReplyDao moaQuestionReplyDao = new MoaQuestionReplyDao();
			moaQuestionReplyDao.insert(questionNo, qustionContent);
			
			//답변여부
			MoaQuestionDao moaQuestionDao = new MoaQuestionDao();
			moaQuestionDao.finishAnswer(questionNo);
			
			//리스트로 이동
			resp.sendRedirect("question_list.jsp");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
