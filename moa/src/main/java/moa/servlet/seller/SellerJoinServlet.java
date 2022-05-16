package moa.servlet.seller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
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
import moa.beans.ProjectDao;
import moa.beans.ProjectDto;
import moa.beans.SellerAttachDao;
import moa.beans.SellerAttachDto;
import moa.beans.SellerDao;
import moa.beans.SellerDto;

// 수정 중

@WebServlet(urlPatterns = "/member/seller_join.do")
public class SellerJoinServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 파일 관련 코드
			String path = System.getProperty("user.home") + "/upload";

			File dir = new File(path);
			dir.mkdirs();

			int max = 1 * 1024 * 1024; // 1메가 바이트
			String encoding = "utf-8";

			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy(); // 덮어쓰기 관련 처리객체

			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);

			// 준비
			MemberDto memberDto = new MemberDto();
			int memberNo = memberDto.getMemberNo();
			SellerDto sellerDto = new SellerDto();
			sellerDto.setSellerNo(memberNo);

			sellerDto.setSellerNo(Integer.parseInt(mRequest.getParameter("sellerNo")));
			sellerDto.setSellerNick(mRequest.getParameter("sellerNick"));
			sellerDto.setSellerAccountBank(mRequest.getParameter("sellerAccountBank"));
			sellerDto.setSellerAccountNo(mRequest.getParameter("sellerAccountNo"));
			sellerDto.setSellerType(mRequest.getParameter("sellerType"));

			// 처리
			SellerDao sellerDao = new SellerDao();
			sellerDao.insert(sellerDto);

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
			if (target != null) {
				fileSize = (int) target.length();
			}

			// 도구 준비
			AttachDto attachDto = new AttachDto();
			AttachDao attachDao = new AttachDao();
			SellerAttachDto sellerAttachDto = new SellerAttachDto();
			SellerAttachDao sellerAttachDao = new SellerAttachDao();

			// AttachDto 저장
			attachDto.setAttachUploadname(uploadName);
			attachDto.setAttachSavename(saveName);
			attachDto.setAttachType(contentType);
			attachDto.setAttachSize(fileSize);
			attachDto.setAttachNo(attachDao.getSequence());

			attachDao.insert(attachDto);

			// 데이터 등록 진행
			sellerAttachDto.setAttachNo(attachDto.getAttachNo());
			sellerAttachDto.setSellerNo(sellerDto.getSellerNo());

			sellerAttachDao.insert(sellerAttachDto);

			// 출력
			resp.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = resp.getWriter(); 
			writer.println("<script>alert('판매자 신청이 완료되었습니다.'); location.href='"+req.getContextPath()+"/member/seller_wait.jsp';</script>"); writer.close();

			req.getSession().setAttribute("sellerNo", sellerDto.getSellerNo());
			req.getSession().setAttribute("sellerPermission", sellerDto.getSellerPermission());

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
