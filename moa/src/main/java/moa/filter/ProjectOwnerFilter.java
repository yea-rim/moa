package moa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.ProjectDao;
import moa.beans.ProjectDto;

//프로젝트 필터
@WebFilter(filterName = "g3-projectOwner", urlPatterns = {
			"/seller/attach_edit.jsp",
			"/seller/banner_insert.jsp",
			"/seller/fail_project_detail.jsp",
			"/seller/funding_member_detail.jsp",
			"/seller/funding_member_list.jsp",
			"/seller/my_sponsor.jsp",
			"/seller/permit_project_detail.jsp",
			"/seller/pj_progress_edit.jsp",
			"/seller/pj_progress_insert.jsp",
			"/seller/project_edit.jsp",
			"/seller/project_reapply.jsp",
			"/seller/rejected_project_detail.jsp",
			"/seller/reward_edit.jsp",
			"/seller/success_project_detail.jsp",
			"/seller/banner_insert.do",
			"/seller/progress_delete.do",
			"/seller/attach_delete.do",
			"/seller/attach_edit.do",
			"/seller/attach_reinsert.do",
			"/seller/project_delete.do",
			"/seller/project_edit.do",
			"/seller/project_reapply.do",
			"/seller/project_reinsert.do",
			"/seller/reward_delete.do",
			"/seller/reward_edit.do",
			"/seller/reward_reinsert.do"
			})
public class ProjectOwnerFilter implements Filter{
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		try {		
			// 1. 관리자인지 확인
			Integer admin  = (Integer) req.getSession().getAttribute("admin");
			if(admin != null) {
				chain.doFilter(request, response);
				return;
			}
			
			// 2. 작성자 본인인지 확인
			int memberNo = (int) req.getSession().getAttribute("login");
			
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			ProjectDao projectDao = new ProjectDao();
			ProjectDto projectDto = projectDao.selectOne(projectNo);
			//Login 필터를 거쳐오기 때문에 null일 수가 없으므로 null 검사는 안해도 됨
			boolean auth = memberNo == projectDto.getProjectSellerNo();
		
			if(auth) {
				chain.doFilter(request, response);
			}else { //본인이아니라면: 권한 없음 에러 발생(403, forbidden)
				resp.sendError(403);				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
