package moa.servlet.member;

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
import moa.beans.MemberDao;
import moa.beans.MemberDto;
import moa.beans.MemberProfileDao;
import moa.beans.MemberProfileDto;

@WebServlet(urlPatterns = "/member/edit.do")
public class MemberInformationServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			// 파일 관련 코드 
			String path = System.getProperty("D:") + "/upload/kh95";
			
			File dir = new File(path);
			dir.mkdirs();
			
			int max = 1 * 1024 * 1024; // 1메가 바이트
			String encoding = "utf-8";
			
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy(); // 덮어쓰기 관련 처리객체
			
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
			
			// 변경할 데이터 받아오기 (parameter)
			int memberNo = Integer.parseInt(mRequest.getParameter("memberNo"));
			String memberNick = mRequest.getParameter("memberNick");
			
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.selectOne(memberNo); 
			
			
			// 변경 처리 
			memberDao.changeNick(memberNo, memberNick);
			
			
			// 업로드된 파일의 정보를 분석하는 코드
			// 1. 파일의 올린 이름 (업로드 이름)
			String uploadName = mRequest.getOriginalFileName("attach");

			// 2. 파일의 실제 저장 이름
			String saveName = mRequest.getFilesystemName("attach");
			
			// 3. 파일의 유형
			String contentType = mRequest.getContentType("attach");
			
			// 4. 파일의 크기
			File target = mRequest.getFile("attach"); // 파일 객체를 구해와서
			int fileSize = 0;
			if(target != null) {
				fileSize = (int) target.length();
			}
			
//			System.out.println(uploadName);
//			System.out.println(saveName);
//			System.out.println(contentType);
//			System.out.println(fileSize);
			
			
			if(uploadName != null) { // uploadName에 정보가 있으면 

				// 도구 준비
				AttachDto attachDto = new AttachDto();
				AttachDao attachDao = new AttachDao();
				MemberProfileDto memberProfileDto = new MemberProfileDto();
				MemberProfileDao memberProfileDao = new MemberProfileDao();
				
				if(attachDao.selectAttachNo(memberDto.getMemberNo()) != null) {
					// 기존에 있던 AttachNo 삭제  
					int currentAttachNo = attachDao.selectAttachNo(memberDto.getMemberNo());
					attachDao.delete(currentAttachNo);
				}
				
				// AttachDto 저장 
				attachDto.setAttachUploadname(uploadName);
				attachDto.setAttachSavename(saveName);
				attachDto.setAttachType(contentType);
				attachDto.setAttachSize(fileSize);
				attachDto.setAttachNo(attachDao.getSequence());
				
				attachDao.insert(attachDto);
				
				
				// memberProfile에 정보 저장 
				
					// memberProfile에 이미 데이터가 존재한다면 삭제 
					if(memberProfileDao.selectOne(memberDto.getMemberNo()) != null) {
						// memberProfile 테이블에서 중복되는 memberNor가 있다면 삭제 
						memberProfileDao.delete(memberDto.getMemberNo());

						// 프로필 사진 변경할 때 attach 테이블에 있던 기존 프로필 사진을 삭제하고 싶은데 구현 방법을 모르겠다! 
						
					} else { // 존재하지 않는다면 등록 진행 
						memberProfileDto.setAttachNo(attachDto.getAttachNo());
						memberProfileDto.setMemberNo(memberDto.getMemberNo());
					}
				
				// memberProfile에 데이터 등록 진행 
				memberProfileDto.setAttachNo(attachDto.getAttachNo());
				memberProfileDto.setMemberNo(memberDto.getMemberNo());
			
				memberProfileDao.insert(memberProfileDto);
			} 
			
			
			// 출력 
			resp.sendRedirect("my_page.jsp");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
