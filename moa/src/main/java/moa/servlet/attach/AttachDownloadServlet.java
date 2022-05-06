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

@WebServlet(urlPatterns = "/attach/download.do")
public class AttachDownloadServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 준비 
			int attachNo = Integer.parseInt(req.getParameter("attachNo"));
			
			// 처리
			AttachDao attachDao = new AttachDao();
			AttachDto attachDto = attachDao.selectOne(attachNo);
			
			if(attachDto == null) {
				resp.sendError(404);
				return;
			}
			
			// 실제 파일 객체 생성
			File target = new File(AttachDao.path, attachDto.getAttachSavename());
			
			
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(attachDto.getAttachSize()));
			String filename = URLEncoder.encode(attachDto.getAttachUploadname(), "UTF-8");
			resp.setHeader("Content-Disposition", "attachment; filename=\""+filename+"\"");
			
			
			// 출력 
			byte[] buffer = new byte[8192];
			FileInputStream in = new FileInputStream(target);
			
			while(true) {
				int size = in.read(buffer);
				if(size == -1) break;
				resp.getOutputStream().write(buffer, 0, size);
			}
			
			in.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
