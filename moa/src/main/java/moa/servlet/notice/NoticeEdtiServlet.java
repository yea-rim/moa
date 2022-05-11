package moa.servlet.notice;

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
import moa.beans.MoaNoticeAttachDao;
import moa.beans.MoaNoticeAttachDto;
import moa.beans.MoaNoticeDao;
import moa.beans.MoaNoticeDto;

@WebServlet(urlPatterns="/notice/edit.do")
public class NoticeEdtiServlet extends HttpServlet {
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
			int noticeNo = Integer.parseInt(mRequest.getParameter("noticeNo"));
			
			MoaNoticeDto moaNoticeDto = new MoaNoticeDto();
			moaNoticeDto.setNoticeNo(noticeNo);
			moaNoticeDto.setNoticeTitle(mRequest.getParameter("noticeTitle"));
			moaNoticeDto.setNoticeContent(mRequest.getParameter("noticeContent"));
			
			// 수정
			MoaNoticeDao moaNoticeDao = new MoaNoticeDao();
			moaNoticeDao.edit(moaNoticeDto);
			
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
				 			MoaNoticeAttachDao moaNoticeAttachDao = new MoaNoticeAttachDao();
				 			MoaNoticeAttachDto moaNoticeAttachDto = new MoaNoticeAttachDto();
				 			
					 		AttachDao attachDao = new AttachDao();
				 			AttachDto attachDto = new AttachDto();
				 			
					 		if(moaNoticeAttachDao.selectOne(noticeNo) != null) {
					 			attachDao.delete(moaNoticeAttachDto.getAttachNo());
					 			moaNoticeAttachDao.delete(noticeNo);
					 			
					 			int attachNo = attachDao.getSequence();
					 			
					 			attachDto.setAttachNo(attachNo);
								attachDto.setAttachUploadname(uploadName);
								attachDto.setAttachSavename(saveName);
								attachDto.setAttachType(contentType);
								attachDto.setAttachSize(fileSize);
								
								attachDao.insert(attachDto);
								
								moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
							 	moaNoticeAttachDto.setNoticeNo(noticeNo);
					 		}
					 		else {
					 			int attachNo = attachDao.getSequence();
					 			
					 			attachDto.setAttachNo(attachNo);
								attachDto.setAttachUploadname(uploadName);
								attachDto.setAttachSavename(saveName);
								attachDto.setAttachType(contentType);
								attachDto.setAttachSize(fileSize);
								
								attachDao.insert(attachDto);
								
								moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
							 	moaNoticeAttachDto.setNoticeNo(noticeNo);
					 		}
					 		
					 		moaNoticeAttachDao.insert(moaNoticeAttachDto);
				 		}
				 		
						// 출력
						resp.sendRedirect("detail.jsp?noticeNo="+moaNoticeDto.getNoticeNo());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
