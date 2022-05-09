package moa.servlet.community;

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
import moa.beans.CommunityDao;
import moa.beans.CommunityDto;
import moa.beans.CommunityPhotoDao;
import moa.beans.CommunityPhotoDto;

@WebServlet(urlPatterns="/community/edit.do")
public class CommunityEditServlet extends HttpServlet {
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
			int communityNo = Integer.parseInt(mRequest.getParameter("communityNo"));
			
			
			CommunityDto communityDto = new CommunityDto();
			communityDto.setCommunityNo(communityNo);
			communityDto.setCommunityTitle(mRequest.getParameter("communityTitle"));
			communityDto.setCommunityContent(mRequest.getParameter("communityContent"));
			
			
			// 수정
			CommunityDao communityDao = new CommunityDao();
			communityDao.edit(communityDto);
			
			
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
		 		CommunityPhotoDao communityPhotoDao = new CommunityPhotoDao();
		 		CommunityPhotoDto communityPhotoDto = new CommunityPhotoDto(); 
		 		
		 		AttachDao attachDao = new AttachDao();
	 			AttachDto attachDto = new AttachDto();
	 			
		 		if(communityPhotoDao.selectOne(communityNo) != null) {
		 			attachDao.delete(communityPhotoDto.getAttachNo());
		 			communityPhotoDao.delete(communityNo);
		 			
		 			int attachNo = attachDao.getSequence();
		 			
		 			attachDto.setAttachNo(attachNo);
					attachDto.setAttachUploadname(uploadName);
					attachDto.setAttachSavename(saveName);
					attachDto.setAttachType(contentType);
					attachDto.setAttachSize(fileSize);
					
					attachDao.insert(attachDto);
					
					communityPhotoDto.setAttachNo(attachDto.getAttachNo());
				 	communityPhotoDto.setCommunityNo(communityNo);
		 		}
		 		else {
		 			int attachNo = attachDao.getSequence();
		 			
		 			attachDto.setAttachNo(attachNo);
					attachDto.setAttachUploadname(uploadName);
					attachDto.setAttachSavename(saveName);
					attachDto.setAttachType(contentType);
					attachDto.setAttachSize(fileSize);
					
					attachDao.insert(attachDto);
					
					communityPhotoDto.setAttachNo(attachDto.getAttachNo());
				 	communityPhotoDto.setCommunityNo(communityNo);
		 		}
		 		
		 		communityPhotoDao.insert(communityPhotoDto);
	 		}
	 		
			// 출력
			resp.sendRedirect("detail.jsp?communityNo="+communityDto.getCommunityNo());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
