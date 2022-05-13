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

@WebServlet(urlPatterns="/seller/progress_insert.do")
public class PjProgressInsertServlet extends HttpServlet {
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
			//정상실행이 되었다면 모든 정보는 mRequest 객체에 들어있다.
			//-들어있는 정보를 꺼내서 화면에 출력하거나 DB에 저장하거나 원하는 작업을 수행한다.
			
			// 시퀀스 생성
			PjProgressDao pjProgressDao = new PjProgressDao();
			int progressNo = pjProgressDao.getProgressNo();
			
			int progressProjectNo = Integer.parseInt(mRequest.getParameter("projectNo")); // 프로젝트 번호
			
			PjProgressDto pjProgressDto = new PjProgressDto();
			pjProgressDto.setProgressNo(progressNo);
			pjProgressDto.setProgressProjectNo(progressProjectNo);
			pjProgressDto.setProgressTitle(mRequest.getParameter("progressTitle"));
			
			String progressContent = mRequest.getParameter("progressContent");
			progressContent = progressContent.replace("\r\n", "<br>");
			
			pjProgressDto.setProgressContent(progressContent);
			
			
			// 작성
			pjProgressDao.insert(pjProgressDto);
			
			
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
	 			ProgressAttachDto progressAttachDto = new ProgressAttachDto();
	 			ProgressAttachDao progressAttachDao = new ProgressAttachDao();
		 		AttachDto attachDto = new AttachDto();
		 		AttachDao attachDao = new AttachDao();
		 		
				attachDto.setAttachNo(attachDao.getSequence());
				attachDto.setAttachUploadname(uploadName);
				attachDto.setAttachSavename(saveName);
				attachDto.setAttachType(contentType);
				attachDto.setAttachSize(fileSize);
				
				attachDao.insert(attachDto);
				
				if(progressAttachDao.selectOne(progressNo) != null) {
					progressAttachDao.delete(progressNo);
				}
				else {
					progressAttachDto.setAttachNo(attachDto.getAttachNo());
					progressAttachDto.setProgressNo(progressNo);
				}
				progressAttachDto.setAttachNo(attachDto.getAttachNo());
				progressAttachDto.setProgressNo(progressNo);
				
				progressAttachDao.insert(progressAttachDto);
	 		}
			// 출력
	 		// 임시 주소 / 해당 프로젝트 디테일페이지로 갈 예정
			resp.sendRedirect("my_page.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
