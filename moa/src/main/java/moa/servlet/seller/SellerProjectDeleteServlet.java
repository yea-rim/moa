package moa.servlet.seller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.AttachDao;
import moa.beans.ProjectAttachDao;
import moa.beans.ProjectAttachDto;
import moa.beans.ProjectDao;

@WebServlet(urlPatterns = "/seller/project_delete.do")
public class SellerProjectDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			//프로젝트 삭제
			ProjectDao projectDao = new ProjectDao();
			boolean delProject = projectDao.delete(projectNo);
			
			//프로젝트 첨부파일 정보 삭제 & 첨부파일 삭제
			AttachDao attachDao = new AttachDao();
			ProjectAttachDao projectAttachDao = new ProjectAttachDao();
			
			List<ProjectAttachDto> list = projectAttachDao.attachList(projectNo);
			for(ProjectAttachDto dto : list) {
				boolean delAttach = attachDao.delete(dto.getAttachNo());
				if(!delAttach) {
					resp.sendError(404);
				}
			}
							
			if(delProject) {
				resp.sendRedirect(req.getContextPath()+"/seller/my_ongoing_project.jsp");
			}
			else {
				resp.sendError(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
