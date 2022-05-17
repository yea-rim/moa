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

@WebServlet(urlPatterns="/community/insert.do")
public class CommunityInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//파일 저장
			String path = System.getProperty("D:") + "/upload/kh95";

			File dir = new File(path);
			dir.mkdirs(); //폴더생성
			
			int max = 10*1024*1024; //최대 크기 제한(byte);
			String encoding = "UTF-8";
			
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			//정상실행이 되었다면 모든 정보는 mRequest 객체에 들어있다.
			//-들어있는 정보를 꺼내서 화면에 출력하거나 DB에 저장하거나 원하는 작업을 수행한다.
			
			// 시퀀스 생성
			CommunityDao communityDao = new CommunityDao();
			int communityNo = communityDao.getCommunityNo();
			
			int communityProjectNo = Integer.parseInt(mRequest.getParameter("projectNo")); // 프로젝트 번호
			int communityMemberNo = (Integer)req.getSession().getAttribute("login");  // 작성자 번호
			
			
			CommunityDto communityDto = new CommunityDto();
			communityDto.setCommunityNo(communityNo);
			communityDto.setCommunityProjectNo(communityProjectNo);
			communityDto.setCommunityMemberNo(communityMemberNo);
			communityDto.setCommunityTitle(mRequest.getParameter("communityTitle"));
			String communityContent = mRequest.getParameter("communityContent");
			communityContent = communityContent.replace("\r\n", "<br>");
			communityDto.setCommunityContent(communityContent);
			
			
			// 작성
			communityDao.insert(communityDto);
			
			
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
	 			CommunityPhotoDto communityPhotoDto = new CommunityPhotoDto();
	 			CommunityPhotoDao communityPhotoDao = new CommunityPhotoDao();
		 		AttachDto attachDto = new AttachDto();
		 		AttachDao attachDao = new AttachDao();
		 		
				attachDto.setAttachNo(attachDao.getSequence());
				attachDto.setAttachUploadname(uploadName);
				attachDto.setAttachSavename(saveName);
				attachDto.setAttachType(contentType);
				attachDto.setAttachSize(fileSize);
				
				attachDao.insert(attachDto);
				
				if(communityPhotoDao.selectOne(communityNo) != null) {
					communityPhotoDao.delete(communityNo);
				}
				else {
					communityPhotoDto.setAttachNo(attachDto.getAttachNo());
					communityPhotoDto.setCommunityNo(communityNo);
				}
				communityPhotoDto.setAttachNo(attachDto.getAttachNo());
				communityPhotoDto.setCommunityNo(communityNo);
				
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
