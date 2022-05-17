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
import moa.beans.ProjectAttachDao;
import moa.beans.ProjectAttachDto;

@WebServlet(urlPatterns = "/seller/attach_insert.do")
public class SellerProjectAttachInsertServlet extends HttpServlet{
	 @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 파일 저장
			String path = System.getProperty("D:") + "/upload/kh95";// 저장할 경로 /운영체제에서 사용자에게 제공되는 home폴더

			File dir = new File(path);
			dir.mkdirs(); // 폴더생성

			int max = 10 * 1024 * 1024; // 최대 크기 제한(byte);
			String encoding = "UTF-8";

			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);

			int projectNo = Integer.parseInt(mRequest.getParameter("projectNo"));
					
			// 파일 처리(프로필) 		
	 		if(mRequest.getFile("profileAttach") != null) {	
	 			//첨부파일 정보 저장
		 		AttachDto attachDto = new AttachDto();
		 		AttachDao attachDao = new AttachDao();
		 		
		 		int attachNo = attachDao.getSequence();//첨부파일 시퀀스번호
				attachDto.setAttachNo(attachNo);
				attachDto.setAttachUploadname(mRequest.getOriginalFileName("profileAttach"));
				attachDto.setAttachSavename(mRequest.getFilesystemName("profileAttach"));
				attachDto.setAttachType(mRequest.getContentType("profileAttach"));
				File target = mRequest.getFile("profileAttach"); 
				attachDto.setAttachSize(target.length());
				
				attachDao.insert(attachDto);
				
				// 프로젝트 파일 정보 저장
				ProjectAttachDto projectAttachDto = new ProjectAttachDto();
				projectAttachDto.setProjectNo(projectNo);
				projectAttachDto.setAttachNo(attachDto.getAttachNo());
				projectAttachDto.setAttachType("프로필");

				ProjectAttachDao projectAttachDao = new ProjectAttachDao();
				projectAttachDao.insert(projectAttachDto);
	 		}
	 		
	 		
	 		// 파일 처리(본문)
	 		if(mRequest.getFile("detailAttach") != null) {	
	 			//첨부파일 정보 저장
		 		AttachDto attachDto = new AttachDto();
		 		AttachDao attachDao = new AttachDao();
		 		
		 		int attachNo = attachDao.getSequence();//첨부파일 시퀀스번호
				attachDto.setAttachNo(attachNo);
				attachDto.setAttachUploadname(mRequest.getOriginalFileName("detailAttach"));
				attachDto.setAttachSavename( mRequest.getFilesystemName("detailAttach"));
				attachDto.setAttachType( mRequest.getContentType("detailAttach"));
				File target = mRequest.getFile("detailAttach"); 
				attachDto.setAttachSize(target.length());
				
				attachDao.insert(attachDto);
				
				// 프로젝트 파일 정보 저장
				ProjectAttachDto projectAttachDto = new ProjectAttachDto();
				projectAttachDto.setProjectNo(projectNo);
				projectAttachDto.setAttachNo(attachDto.getAttachNo());
				projectAttachDto.setAttachType("본문");

				ProjectAttachDao projectAttachDao = new ProjectAttachDao();
				projectAttachDao.insert(projectAttachDto);
	 		}
	 		
	 		//페이지 이동
	 		resp.sendRedirect("attach_edit.jsp?projectNo="+projectNo);
	 		
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
