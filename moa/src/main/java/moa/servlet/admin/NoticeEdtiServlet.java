package moa.servlet.admin;

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

@WebServlet(urlPatterns = "/admin/notice_edit.do")
public class NoticeEdtiServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 파일 저장
			String path = System.getProperty("D:") + "/upload/kh95";

			File dir = new File(path);
			dir.mkdirs(); // 폴더생성

			int max = 10 * 1024 * 1024; // 최대 크기 제한(byte);
			String encoding = "UTF-8";

			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			int noticeNo = Integer.parseInt(mRequest.getParameter("noticeNo"));

			MoaNoticeDto moaNoticeDto = new MoaNoticeDto();
			moaNoticeDto.setNoticeNo(noticeNo);
			moaNoticeDto.setNoticeTitle(mRequest.getParameter("noticeTitle"));

			String noticeContent = mRequest.getParameter("noticeContent");
			noticeContent = noticeContent.replace("\r\n", "<br>");
			moaNoticeDto.setNoticeContent(noticeContent);

			// 수정
			MoaNoticeDao moaNoticeDao = new MoaNoticeDao();
			moaNoticeDao.edit(moaNoticeDto);
			
			// 프로필 파일 처리
			String uploadName1 = mRequest.getOriginalFileName("attachProfile");
			String saveName1 = mRequest.getFilesystemName("attachProfile");
			String contentType1 = mRequest.getContentType("attachProfile");
			File target1 = mRequest.getFile("attachProfile");
			long fileSize = 0L;
			if (target1 != null) {
				fileSize = target1.length();
			}
			
			if (uploadName1 != null) {
				MoaNoticeAttachDao moaNoticeAttachDao = new MoaNoticeAttachDao();
				MoaNoticeAttachDto moaNoticeAttachDto = new MoaNoticeAttachDto();
				
				AttachDao attachDao = new AttachDao();
				AttachDto attachDto = new AttachDto();
				
				if (moaNoticeAttachDao.selectProfile(noticeNo) != null) {
					attachDao.delete(moaNoticeAttachDto.getAttachNo());
					moaNoticeAttachDao.deleteProfile(noticeNo);
					
					int attachNo = attachDao.getSequence();
					
					attachDto.setAttachNo(attachNo);
					attachDto.setAttachUploadname(uploadName1);
					attachDto.setAttachSavename(saveName1);
					attachDto.setAttachType(contentType1);
					attachDto.setAttachSize(fileSize);
					
					attachDao.insert(attachDto);
					
					moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
					moaNoticeAttachDto.setNoticeNo(noticeNo);
					moaNoticeAttachDto.setAttachType("프로필");
				} else {
					int attachNo = attachDao.getSequence();
					
					attachDto.setAttachNo(attachNo);
					attachDto.setAttachUploadname(uploadName1);
					attachDto.setAttachSavename(saveName1);
					attachDto.setAttachType(contentType1);
					attachDto.setAttachSize(fileSize);
					
					attachDao.insert(attachDto);
					
					moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
					moaNoticeAttachDto.setNoticeNo(noticeNo);
					moaNoticeAttachDto.setAttachType("프로필");
				}
				
				moaNoticeAttachDao.insert(moaNoticeAttachDto);
			}
			
			// 프로필이 있는 상태에서 프로필만 변경하면 본문파일이 삭제만 된다. 
			
			// 본문 파일 처리
			String uploadName2 = mRequest.getOriginalFileName("attachContent");
			String saveName2 = mRequest.getFilesystemName("attachContent");
			String contentType2 = mRequest.getContentType("attachContent");
			File target2 = mRequest.getFile("attachContent");
			if (target2 != null) {
				fileSize = target2.length();
			}

			if (uploadName2 != null) {
				MoaNoticeAttachDao moaNoticeAttachDao = new MoaNoticeAttachDao();
				MoaNoticeAttachDto moaNoticeAttachDto = new MoaNoticeAttachDto();

				AttachDao attachDao = new AttachDao();
				AttachDto attachDto = new AttachDto();

				if (moaNoticeAttachDao.selectContent(noticeNo) != null) {
					attachDao.delete(moaNoticeAttachDto.getAttachNo());
					moaNoticeAttachDao.deleteContent(noticeNo);

					int attachNo = attachDao.getSequence();
					
					System.out.println(uploadName2);

					attachDto.setAttachNo(attachNo);
					attachDto.setAttachUploadname(uploadName2);
					attachDto.setAttachSavename(saveName2);
					attachDto.setAttachType(contentType2);
					attachDto.setAttachSize(fileSize);

					attachDao.insert(attachDto);

					moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
					moaNoticeAttachDto.setNoticeNo(noticeNo);
					moaNoticeAttachDto.setAttachType("본문");
				} else {
					int attachNo = attachDao.getSequence();

					attachDto.setAttachNo(attachNo);
					attachDto.setAttachUploadname(uploadName2);
					attachDto.setAttachSavename(saveName2);
					attachDto.setAttachType(contentType2);
					attachDto.setAttachSize(fileSize);

					attachDao.insert(attachDto);

					moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
					moaNoticeAttachDto.setNoticeNo(noticeNo);
					moaNoticeAttachDto.setAttachType("본문");
				}

				moaNoticeAttachDao.insert(moaNoticeAttachDto);
			}

			// 출력
			resp.sendRedirect("notice_detail.jsp?noticeNo=" + moaNoticeDto.getNoticeNo());
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
