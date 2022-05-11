package moa.servlet.project;

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

@WebServlet(urlPatterns = "/project/delete.do")
public class ProjectDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			//준비
			ProjectDao projectDao = new ProjectDao();
			AttachDao attachDao = new AttachDao();
			ProjectAttachDao projectAttachDao = new ProjectAttachDao();			
						
			//프로젝트 첨부파일 정보 삭제 & 첨부파일 삭제
			List<ProjectAttachDto> list = projectAttachDao.attachList(projectNo);
			for(ProjectAttachDto dto : list) {
				boolean delAttach = attachDao.delete(dto.getAttachNo());
				System.out.println(dto.getAttachNo());
				if(!delAttach) {
					resp.sendError(404);
				}
			}
			//프로젝트 삭제
			boolean delProject = projectDao.delete(projectNo);
			
			if(delProject) {
				resp.sendRedirect(req.getContextPath()+"/admin/projectList.jsp");
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
