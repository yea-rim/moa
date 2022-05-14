package moa.servlet.question;

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
import moa.beans.MoaQuestionAttachDao;
import moa.beans.MoaQuestionAttachDto;
import moa.beans.MoaQuestionDao;
import moa.beans.MoaQuestionDto;

@WebServlet(urlPatterns="/question/insert.do")
public class QuestionInsertServlet extends HttpServlet {
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
			
			// 시퀀스 생성
			MoaQuestionDao moaQuestionDao = new MoaQuestionDao();
			int moaQuestionNo = moaQuestionDao.getQuestionNo();
			
			// 작성자 회원번호
			int memberNo = (Integer)req.getSession().getAttribute("login");  
			System.out.println(memberNo);
			//문의글 등록
			MoaQuestionDto moaQuestionDto = new MoaQuestionDto();
			moaQuestionDto.setQuestionNo(moaQuestionNo);
			moaQuestionDto.setQuestionWriter(memberNo);
			moaQuestionDto.setQuestionType(mRequest.getParameter("questionType"));
			moaQuestionDto.setQuestionTitle(mRequest.getParameter("questionTitle"));
			moaQuestionDto.setQuestionContent(mRequest.getParameter("questionContent"));
			
			moaQuestionDao.insert(moaQuestionDto);
			
			
			// 파일 처리
			String uploadName = mRequest.getOriginalFileName("attach");
	 		String saveName = mRequest.getFilesystemName("attach");
	 		String contentType = mRequest.getContentType("attach");
	 		File target = mRequest.getFile("attach"); 
	 		long fileSize = 0L;
	 		if(target != null){
	 			fileSize = target.length();
	 		}
	 		
	 		//파일이 있으면
	 		if(uploadName != null) {	
	 			//첨부파일 정보 저장
		 		AttachDto attachDto = new AttachDto();
		 		AttachDao attachDao = new AttachDao();
		 		
		 		int attachNo = attachDao.getSequence();//첨부파일 시퀀스번호
				attachDto.setAttachNo(attachNo);
				attachDto.setAttachUploadname(uploadName);
				attachDto.setAttachSavename(saveName);
				attachDto.setAttachType(contentType);
				attachDto.setAttachSize(fileSize);
				
				attachDao.insert(attachDto);
				
				//문의 첨부파일 저장
				MoaQuestionAttachDto moaQuestionAttachDto = new MoaQuestionAttachDto();				
				moaQuestionAttachDto.setQuestionNo(moaQuestionNo);
				moaQuestionAttachDto.setAttachNo(attachNo);
				
				MoaQuestionAttachDao moaQuestionAttachDao = new MoaQuestionAttachDao();
				moaQuestionAttachDao.insert(moaQuestionAttachDto);
	 		}
			// 출력
			resp.sendRedirect(req.getContextPath()+"/member/my_page.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
