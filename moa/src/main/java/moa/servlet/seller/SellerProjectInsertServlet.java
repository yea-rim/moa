package moa.servlet.seller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
import moa.beans.ProjectAttachDao;
import moa.beans.ProjectAttachDto;
import moa.beans.ProjectDao;
import moa.beans.ProjectDto;
import moa.beans.RewardDao;
import moa.beans.RewardDto;

@WebServlet(urlPatterns = "/seller/project_insert.do")
public class SellerProjectInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 파일 저장
			String path = System.getProperty("user.home") + "/upload";// 저장할 경로 /운영체제에서 사용자에게 제공되는 home폴더

			File dir = new File(path);
			dir.mkdirs(); // 폴더생성

			int max = 10 * 1024 * 1024; // 최대 크기 제한(byte);
			String encoding = "UTF-8";

			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			// 정상실행이 되었다면 모든 정보는 mRequest 객체에 들어있다.
			// -들어있는 정보를 꺼내서 화면에 출력하거나 DB에 저장하거나 원하는 작업을 수행한다.

			// 프로젝트 신청 시퀀스번호 생성
			ProjectDao projectDao = new ProjectDao();
			int projectNo = projectDao.getSequence();
			
			//판매자 번호
			int sellerNo = (int)req.getSession().getAttribute("login");


			// 프로젝트 신청 처리
			ProjectDto projectDto = new ProjectDto();
			projectDto.setProjectNo(projectNo); //가져온 시퀀스 번호 넣어주기
			projectDto.setProjectSellerNo(sellerNo);
			projectDto.setProjectCategory(mRequest.getParameter("projectCategory"));
			projectDto.setProjectName(mRequest.getParameter("projectName"));
			projectDto.setProjectSummary(mRequest.getParameter("projectSummary"));
			projectDto.setProjectTargetMoney(Integer.parseInt(mRequest.getParameter("projectTargetMoney")));
			projectDto.setProjectStartDate(Date.valueOf(mRequest.getParameter("projectStartDate")));
			projectDto.setProjectSemiFinish(Date.valueOf(mRequest.getParameter("projectSemiFinish")));
			projectDto.setProjectFinishDate(Date.valueOf(mRequest.getParameter("projectSemiFinish")));

			projectDao.insert(projectDto);

			// 다중 파일 저장 처리
			AttachDao attachDao = new AttachDao();

			Enumeration files = mRequest.getFileNames(); //파일명정보를 배열로 만들다(files에 name들이 담겨있다)
			while(files.hasMoreElements()){
			    String name = (String)files.nextElement(); //각각의 파일 name을 String name에 담는다.
			    String uploadName = mRequest.getOriginalFileName(name);
			    String saveName = mRequest.getFilesystemName(name); //각각의 파일 name을 통해서 파일의 정보를 얻는다.
			    String contentType = mRequest.getContentType(name);
			    File target = mRequest.getFile(name);
			    int fileSize = 0;
			 	if(target != null)	fileSize = (int)target.length();	

			 	//파일 정보 저장
				AttachDto attachDto = new AttachDto();
				attachDto.setAttachNo(attachDao.getSequence());
				attachDto.setAttachUploadname(uploadName);
				attachDto.setAttachSavename(saveName);
				attachDto.setAttachType(contentType);
				attachDto.setAttachSize(fileSize);

				attachDao.insert(attachDto);

				// 프로젝트 파일 정보 저장
				ProjectAttachDto projectAttachDto = new ProjectAttachDto();
				projectAttachDto.setProjectNo(projectNo);
				projectAttachDto.setAttachNo(attachDto.getAttachNo());
				if (name.contains("profileAttach")) {
					projectAttachDto.setAttachType("프로필");
				} else {
					projectAttachDto.setAttachType("본문");
				}

				ProjectAttachDao projectAttachDao = new ProjectAttachDao();
				projectAttachDao.insert(projectAttachDto);

			}

			// 리워드 신청 처리
			String[] rewardName = mRequest.getParameterValues("rewardName");
			String[] rewardContent = mRequest.getParameterValues("rewardContent");
			String[] rewardPrice = mRequest.getParameterValues("rewardPrice");
			String[] rewardStock = mRequest.getParameterValues("rewardStock");
			String[] rewardDelivery = mRequest.getParameterValues("rewardDelivery");
			String[] rewardEach = mRequest.getParameterValues("rewardEach");
			String[] rewardIsOption = mRequest.getParameterValues("rewardIsOption");			

			RewardDao rewardDao = new RewardDao();
			for (int i = 0; i < rewardName.length; i++) {
				RewardDto rewardDto = new RewardDto();

				rewardDto.setRewardProjectNo(projectNo);
				rewardDto.setRewardName(rewardName[i]);
				rewardDto.setRewardContent(rewardContent[i]);
				rewardDto.setRewardPrice(Integer.parseInt(rewardPrice[i]));
				rewardDto.setRewardStock(Integer.parseInt(rewardStock[i]));
				rewardDto.setRewardDelivery(Integer.parseInt(rewardDelivery[i]));
				rewardDto.setRewardEach(Integer.parseInt(rewardEach[i]));
				rewardDto.setRewardIsoption(Integer.parseInt(rewardIsOption[i]));

				rewardDao.insert(rewardDto);
			}

			// 심사중 페이지로 이동
			resp.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = resp.getWriter(); 
			writer.println("<script>alert('프로젝트 신청이 완료되었습니다. 관리자 승인을 기다려 주세요.'); location.href='"+req.getContextPath()+"/seller/my_permit_project.jsp';</script>"); writer.close();

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
