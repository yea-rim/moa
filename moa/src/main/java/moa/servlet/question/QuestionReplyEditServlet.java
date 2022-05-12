package moa.servlet.question;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.CommunityReplyDao;
import moa.beans.MoaQuestionReplyDao;

@WebServlet(urlPatterns = "/admin/questionReplyEdit.do")
public class QuestionReplyEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int questionNo = Integer.parseInt(req.getParameter("questionTargetNo"));
			String replyContent = req.getParameter("questionReplyContent");
			
			MoaQuestionReplyDao moaQuestionReplyDao = new MoaQuestionReplyDao();
			moaQuestionReplyDao.edit(questionNo, replyContent);
			
			resp.sendRedirect("question_list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
