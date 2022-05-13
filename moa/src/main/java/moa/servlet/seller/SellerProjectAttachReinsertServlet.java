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

@WebServlet(urlPatterns="/seller/attach_reinsert.do")
public class SellerProjectAttachReinsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			//파일 저장
			String path = System.getProperty("user.home")+"/upload";//저장할 경로 /운영체제에서 사용자에게 제공되는 home폴더

			File dir = new File(path);
			dir.mkdirs(); //폴더생성
			
			int max = 10*1024*1024; //최대 크기 제한(byte);
			String encoding = "UTF-8";
			
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
			//파일 처리 
			String uploadName = mRequest.getOriginalFileName("attach");
	 		String saveName = mRequest.getFilesystemName("attach");
	 		String contentType = mRequest.getContentType("attach");
	 		File target = mRequest.getFile("attach"); 
	 		long fileSize = 0L;
	 		if(target != null){
	 			fileSize = target.length();
	 		}
	 		
	 		int attachNo = Integer.parseInt(mRequest.getParameter("attachNo"));
	 		int projectNo = Integer.parseInt(mRequest.getParameter("projectNo"));
	  		
	 		if(uploadName != null) {
		 		AttachDto attachDto = new AttachDto();
		 		AttachDao attachDao = new AttachDao();
		 		
				attachDto.setAttachNo(attachNo);
				attachDto.setAttachUploadname(uploadName);
				attachDto.setAttachSavename(saveName);
				attachDto.setAttachType(contentType);
				attachDto.setAttachSize(fileSize);		
				
				attachDao.edit(attachDto);		
	 		}
	 		
	 		//화면 이동
	 		resp.sendRedirect("project_reapply.jsp?projectNo="+projectNo);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
