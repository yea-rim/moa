package moa.servlet.seller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.RewardDao;
import moa.beans.RewardDto;

@WebServlet(urlPatterns="/seller/reward_reinsert.do")
public class SellerRewardReinsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			
			//기존 리워드 수정 처리
			if(req.getParameterValues("rewardNo")!=null) {
				String [] rewardNo = req.getParameterValues("rewardNo");
				String [] rewardName = req.getParameterValues("rewardName"); 
				String [] rewardContent = req.getParameterValues("rewardContent"); 
				String [] rewardPrice = req.getParameterValues("rewardPrice"); 
				String [] rewardStock = req.getParameterValues("rewardStock"); 	
				String [] rewardDelivery = req.getParameterValues("rewardDelivery"); 
				String [] rewardEach = req.getParameterValues("rewardEach"); 	
				 
				RewardDao rewardDao = new RewardDao();
				for(int i=0; i<rewardNo.length; i++) {
					RewardDto rewardDto = new RewardDto();
					
					rewardDto.setRewardNo(Integer.parseInt(rewardNo[i]));
					rewardDto.setRewardName(rewardName[i]);
					rewardDto.setRewardContent(rewardContent[i]);
					rewardDto.setRewardPrice(Integer.parseInt(rewardPrice[i]));
					rewardDto.setRewardStock(Integer.parseInt(rewardStock[i]));
					rewardDto.setRewardDelivery(Integer.parseInt(rewardDelivery[i]));
					rewardDto.setRewardEach(Integer.parseInt(rewardEach[i]));
					
					boolean success = rewardDao.edit(rewardDto);
					if(!success) {
						resp.sendError(500);
					}
				}
			}
				
			//리워드 추가 처리	
			if(req.getParameter("addRewardName")!=null) {
				String [] addRewardName = req.getParameterValues("addRewardName"); 
				String [] addRewardContent = req.getParameterValues("addRewardContent"); 
				String [] addRewardPrice = req.getParameterValues("addRewardPrice"); 
				String [] addRewardStock = req.getParameterValues("addRewardStock"); 
				String [] addRewardDelivery = req.getParameterValues("addRewardDelivery"); 
				String [] addRewardEach = req.getParameterValues("addRewardEach"); 
				
				 RewardDao addRewardDao = new RewardDao();
					for(int i=0; i<addRewardName.length; i++) {
						RewardDto rewardDto = new RewardDto();
						
						rewardDto.setRewardProjectNo(projectNo);
						rewardDto.setRewardName(addRewardName[i]);
						rewardDto.setRewardContent(addRewardContent[i]);
						rewardDto.setRewardPrice(Integer.parseInt(addRewardPrice[i]));
						rewardDto.setRewardStock(Integer.parseInt(addRewardStock[i]));
						rewardDto.setRewardDelivery(Integer.parseInt(addRewardDelivery[i]));
						rewardDto.setRewardEach(Integer.parseInt(addRewardEach[i]));							
						
						addRewardDao.insert(rewardDto);
					}
			}
		
			//상세페이지로 이동
			resp.sendRedirect("project_reapply.jsp?projectNo="+projectNo);			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
