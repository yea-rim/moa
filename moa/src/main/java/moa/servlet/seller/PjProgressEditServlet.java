package moa.servlet.seller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import moa.beans.AttachDao;
import moa.beans.AttachDto;
import moa.beans.PjProgressDao;
import moa.beans.PjProgressDto;
import moa.beans.ProgressAttachDao;
import moa.beans.ProgressAttachDto;

@WebServlet(urlPatterns="/seller/progress_edit.do")
public class PjProgressEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//파일 저장
			String path = System.getProperty("user.home")+"/upload";

			File dir = new File(path);
			dir.mkdirs(); //폴더생성
			
			int max = 10*1024*1024; //최대 크기 제한(byte);
			String encoding = "UTF-8";
			
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
			int progressNo = Integer.parseInt(mRequest.getParameter("progressNo"));
			int projectNo = Integer.parseInt(mRequest.getParameter("projectNo"));
			
			
			PjProgressDto pjProgressDto = new PjProgressDto();
			pjProgressDto.setProgressNo(progressNo);
			pjProgressDto.setProgressTitle(mRequest.getParameter("progressTitle"));
			
			String progressContent = mRequest.getParameter("progressContent");
			progressContent = progressContent.replace("\r\n", "<br>");
			pjProgressDto.setProgressContent(progressContent);
			
			
			// 수정
			PjProgressDao pjProgressDao = new PjProgressDao();
			pjProgressDao.edit(pjProgressDto);
			
			
			// 파일 처리
			String uploadName = mRequest.getOriginalFileName("attach");
	 		String saveName = mRequest.getFilesystemName("attach");
	 		String contentType = mRequest.getContentType("attach");
	 		File target = mRequest.getFile("attach"); 
	 		long fileSize = 0L;
	 		if(target != null){
	 			fileSize = target.length();
	 		}
	 		
	 		if(uploadName != null) {
		 		ProgressAttachDao progressAttachDao = new ProgressAttachDao();
		 		ProgressAttachDto progressAttachDto = new ProgressAttachDto(); 
		 		
		 		AttachDao attachDao = new AttachDao();
	 			AttachDto attachDto = new AttachDto();
	 			
		 		if(progressAttachDao.selectOne(progressNo) != null) {
		 			attachDao.delete(progressAttachDto.getAttachNo());
		 			progressAttachDao.delete(progressNo);
		 			
		 			int attachNo = attachDao.getSequence();
		 			
		 			attachDto.setAttachNo(attachNo);
					attachDto.setAttachUploadname(uploadName);
					attachDto.setAttachSavename(saveName);
					attachDto.setAttachType(contentType);
					attachDto.setAttachSize(fileSize);
					
					attachDao.insert(attachDto);
					
					progressAttachDto.setAttachNo(attachDto.getAttachNo());
				 	progressAttachDto.setProgressNo(progressNo);
		 		}
		 		else {
		 			int attachNo = attachDao.getSequence();
		 			
		 			attachDto.setAttachNo(attachNo);
					attachDto.setAttachUploadname(uploadName);
					attachDto.setAttachSavename(saveName);
					attachDto.setAttachType(contentType);
					attachDto.setAttachSize(fileSize);
					
					attachDao.insert(attachDto);
					
					progressAttachDto.setAttachNo(attachDto.getAttachNo());
				 	progressAttachDto.setProgressNo(progressNo);
		 		}
		 		
		 		progressAttachDao.insert(progressAttachDto);
	 		}
	 		
			// 출력
	 		resp.sendRedirect(req.getContextPath()+"/project/detail/notice.jsp?projectNo="+projectNo+"&progressNo="+progressNo);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
