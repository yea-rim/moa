package moa.servlet.ajax;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import moa.beans.ProjectAttachDao;
import moa.beans.ProjectAttachDto;
import moa.beans.ProjectDao;
import moa.beans.ProjectDto;

@WebServlet(urlPatterns="/ajax/soonList.do")
public class SoonProjectListServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비 
			int p = Integer.parseInt(req.getParameter("p")); // 페이지 번호
			int s = Integer.parseInt(req.getParameter("s")); // 페이지 번호
			
			
			// 처리 
			ProjectDao projectDao = new ProjectDao();
			List<ProjectDto> list = projectDao.selectSoon(p, s);
			
			ProjectAttachDao projectAttachDao = new ProjectAttachDao();
			ProjectAttachDto projectAttachDto;
			
			for(ProjectDto projectDto : list) {
				projectAttachDto = projectAttachDao.selectOne(projectDto.getProjectNo());
				projectAttachDto.getAttachNo();
			}
			
			// 출력 
			resp.setHeader("Access-Control-Allow-Origin", "http://127.0.0.1:5500"); 
			// 아래 설정하지 않으면 일반 글자만 주고 받을 수 있기 때문에 
			// 아래 코드를 통해서 제한을 풀어야한다.
			resp.setHeader("Access-Control-Allow-Headers", "Content-Type");
			
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
