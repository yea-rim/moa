package moa.servlet.admin;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

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

@WebServlet(urlPatterns = "/admin/notice_insert.do")
public class NoticeInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 파일 저장
			String path = System.getProperty("user.home") + "/upload";

			File dir = new File(path);
			dir.mkdirs(); // 폴더생성

			int max = 10 * 1024 * 1024; // 최대 크기 제한(byte);
			String encoding = "UTF-8";

			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);

			MoaNoticeDto moaNoticeDto = new MoaNoticeDto();
			moaNoticeDto.setNoticeTitle(mRequest.getParameter("noticeTitle"));
			String noticeContent = mRequest.getParameter("noticeContent");

			// textarea 줄바꿈 처리
			noticeContent = noticeContent.replace("\r\n", "<br>");
			moaNoticeDto.setNoticeContent(noticeContent);

			int adminNo = (Integer) req.getSession().getAttribute("login");
			moaNoticeDto.setNoticeAdminNo(adminNo);

			MoaNoticeDao moaNoticeDao = new MoaNoticeDao();
			// 시퀀스 생성 및 set
			int noticeNo = moaNoticeDao.getMoaNoticeyNo();
			moaNoticeDto.setNoticeNo(noticeNo);

			moaNoticeDao.insert(moaNoticeDto);

			// 파일처리(프로필)
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
				AttachDto attachDto = new AttachDto();
				AttachDao attachDao = new AttachDao();

				attachDto.setAttachNo(attachDao.getSequence());
				attachDto.setAttachUploadname(uploadName1);
				attachDto.setAttachSavename(saveName1);
				attachDto.setAttachType(contentType1);
				attachDto.setAttachSize(fileSize);

				attachDao.insert(attachDto);

				if (moaNoticeAttachDao.selectProfile(noticeNo) != null) {
					moaNoticeAttachDao.delete(noticeNo);

					moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
					moaNoticeAttachDto.setNoticeNo(noticeNo);
					moaNoticeAttachDto.setAttachType("프로필");
				} else {
					moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
					moaNoticeAttachDto.setNoticeNo(noticeNo);
					moaNoticeAttachDto.setAttachType("프로필");
				}

				moaNoticeAttachDao.insert(moaNoticeAttachDto);
			}

			// 파일처리(본문)
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
				AttachDto attachDto = new AttachDto();
				AttachDao attachDao = new AttachDao();

				attachDto.setAttachNo(attachDao.getSequence());
				attachDto.setAttachUploadname(uploadName2);
				attachDto.setAttachSavename(saveName2);
				attachDto.setAttachType(contentType2);
				attachDto.setAttachSize(fileSize);

				attachDao.insert(attachDto);

				if (moaNoticeAttachDao.selectContent(noticeNo) != null) {
					moaNoticeAttachDao.delete(noticeNo);

					moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
					moaNoticeAttachDto.setNoticeNo(noticeNo);
					moaNoticeAttachDto.setAttachType("본문");
				} else {
					moaNoticeAttachDto.setAttachNo(attachDto.getAttachNo());
					moaNoticeAttachDto.setNoticeNo(noticeNo);
					moaNoticeAttachDto.setAttachType("본문");
				}
				moaNoticeAttachDao.insert(moaNoticeAttachDto);
			}

			// 출력
			resp.sendRedirect("notice_detail.jsp?noticeNo=" + noticeNo);
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
