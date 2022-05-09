package moa.servlet.attach;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.JoaDao;
import moa.beans.JoaDto;
import moa.beans.ProjectAttachDao;
import moa.beans.ProjectDao;
import moa.beans.ProjectDto;
import moa.beans.SellerDao;
import moa.beans.SellerDto;

@WebServlet(urlPatterns="/test/sv.do")
public class TestServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			JoaDao joaDao = new JoaDao();
			List<JoaDto> list = joaDao.selectList(148);
			
			ProjectDao projectDao = new ProjectDao();
			SellerDao sellerDao = new SellerDao();
			ProjectAttachDao projectAttachDao = new ProjectAttachDao();
			
			for(JoaDto joaDto : list) {
				int projectNo = joaDto.getProjectNo();
				
				ProjectDto projectDto = projectDao.selectOne(projectNo);
				SellerDto sellerDto1 = sellerDao.selectOne(projectDto.getProjectSellerNo()); 
				int profileNo = projectAttachDao.getAttachNo(joaDto.getProjectNo()); // 여기서 오류가 뜸 
				
				resp.getWriter().println(projectNo);
				
//				resp.getWriter().print(profileNo);
			}
				
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
