package moa.servlet.ajax;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import moa.beans.ProjectDao;
import moa.beans.ProjectDto;

@WebServlet(urlPatterns="/ajax/ongoingList.do")
public class OngoingProjectListServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비 
			int p = Integer.parseInt(req.getParameter("p")); // 페이지 번호
			int s = Integer.parseInt(req.getParameter("s")); // 페이지 번호
			String sort = req.getParameter("sort");
			
			// 처리 
			ProjectDao projectDao = new ProjectDao();
			List<ProjectDto> list = projectDao.ongoingSelectList(p, s, sort);
			
			// 출력 
//			resp.getWriter().print(list); // 자바스크립트에서 알아들을 수 없는 형태 
			
			// Jacson-databind 라는 라이브러리를 이용하여 list를 JSON 형태로 변환 후 출력할 예정 
			// [1] ObjectMapper라는 클래스의 객체를 생성한다. 
			ObjectMapper mapper = new ObjectMapper();
			// [2] 명령을 사용하여 객체를 JSON으로 변환한다. 
			String jsonString = mapper.writeValueAsString(list);
			// [3] client에게 변환된 데이터를 전송 
			resp.setContentType("application/json; charset=UTF-8");
			resp.getWriter().print(jsonString);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
