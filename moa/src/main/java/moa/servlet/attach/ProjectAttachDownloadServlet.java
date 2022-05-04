package moa.servlet.attach;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.AttachDao;
import moa.beans.AttachDto;
import moa.beans.ProjectAttachDao;
import moa.beans.ProjectAttachDto;

@WebServlet(urlPatterns = "/attach/projectDownload.do")
public class ProjectAttachDownloadServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 만드는 중
			// 준비 : attachmentNo
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			ProjectAttachDao projectAttachDao = new ProjectAttachDao();
			// 프로젝트에 프로필 하나 정보만 가져옴
			ProjectAttachDto projectAttachDto = projectAttachDao.selectOneProfile(projectNo); 
			
			AttachDto attachDto = new AttachDto();

			// 처리
			
//			AttachDao attachDao = new AttachDao();
//			AttachDto attachDto = attachDao.selectOne(projectNo);

			if (attachDto == null) {
				resp.sendError(404);
				return;
			}

			// - 실제 파일의 객체를 생성
			File target = new File(AttachDao.path, attachDto.getAttachSavename());

			resp.setHeader("Content-Type", "application/octest-stream");

			resp.setHeader("Content-Encoding", "UTF-8");

			resp.setHeader("Content-Length", String.valueOf(attachDto.getAttachSize()));

			String filename = URLEncoder.encode(attachDto.getAttachUploadname(), "UTF-8");
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

			byte[] buffer = new byte[8192];
			FileInputStream in = new FileInputStream(target);

			while (true) {
				int size = in.read(buffer);
				if (size == -1)
					break;
				resp.getOutputStream().write(buffer, 0, size);
			}

			in.close();
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
