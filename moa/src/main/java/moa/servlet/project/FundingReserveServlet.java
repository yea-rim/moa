package moa.servlet.project;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import moa.beans.FundingDao;
import moa.beans.FundingDto;
import moa.beans.ProjectDao;
import moa.beans.RewardDao;
import moa.beans.RewardDto;
import moa.beans.RewardSelectionDao;
import moa.beans.RewardSelectionDto;

@WebServlet(urlPatterns = "project/funding.do")
public class FundingReserveServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			//프로젝트 번호
			int projectNo = Integer.parseInt(req.getParameter("projectNo"));
			//멤버 정보
			Integer memberNo = (Integer) req.getSession().getAttribute("login");
			//리워드 정보 파라미터
			String[] rewardNo = req.getParameterValues("rewardNo");
			String[] selectionRewardAmount = req.getParameterValues("selectionRewardAmount");
			String[] selectionOption = req.getParameterValues("selectionOption");
			
			//펀딩 수령인 정보 파라미터
			String fundingGetter = req.getParameter("fundingGetter");
			String fundingPost = req.getParameter("fundingPost");
			String fundingBasicAddress = req.getParameter("fundingBasicAddress");
			String fundingDetailAddress = req.getParameter("fundingDetailAddress");
			String fundingPhone = req.getParameter("fundingPhone");
			String fundingPostMessage = req.getParameter("fundingPostMessage");
			
			
			
			//필요한 그 외 정보
			ProjectDao projectDao = new ProjectDao();
			int totalPrice = 0;
			int totalDelivery = 0;
			int deliveryCount = 1;
			Date paymentDate = projectDao.paymentDate(projectNo);
			
			RewardDao rewardDao = new RewardDao();
			//리워드선택에 들어갈 각각의 리워드가격에 수량을 곱한 중간합계 가격 계산
			for(int i = 0; i < rewardNo.length; i++) {
				RewardDto rewardDto = rewardDao.selectOne(projectNo, Integer.parseInt(rewardNo[i]));
				int price = rewardDto.getRewardPrice();
				int amount = Integer.parseInt(selectionRewardAmount[i]);
				totalPrice += amount * price;
				
				if(rewardDto.getRewardEach()==1) {
					totalDelivery += amount * rewardDto.getRewardDelivery();
				}else if(rewardDto.getRewardEach()==0 && deliveryCount == 1){
					totalDelivery += deliveryCount * rewardDao.selectDeliveryOne(projectNo);
					deliveryCount--;
				}
			}
			
			//펀딩 예약 정보 등록
			FundingDto fundingDto = new FundingDto();
			FundingDao fundingDao = new FundingDao();
			int fundingNo = fundingDao.getFundingSequence();
			fundingDto.setFundingNo(fundingNo);
			fundingDto.setFundingMemberNo(fundingNo);
			fundingDto.setFundingGetter(fundingGetter);
			fundingDto.setFundingPost(fundingPost);
			fundingDto.setFundingBasicAddress(fundingBasicAddress);
			fundingDto.setFundingDetailAddress(fundingDetailAddress);
			fundingDto.setFundingPhone(fundingPhone);
			fundingDto.setFundingPostMessage(fundingPostMessage);
			fundingDto.setFundingPaymentDate(paymentDate);
			fundingDto.setFundingTotalprice(totalPrice);
			fundingDto.setFundingTotaldelivery(totalDelivery);
			
			fundingDao.insert(fundingDto);
			
			//리워드 선택 정보 등록
			RewardSelectionDao rewardSelectionDao = new RewardSelectionDao();
			for(int i = 0; i < rewardNo.length; i++) {
				RewardSelectionDto rewardSelectionDto = new RewardSelectionDto();
				rewardSelectionDto.setSelectionFundingNo(fundingNo);
				rewardSelectionDto.setSelectionRewardNo(Integer.parseInt(rewardNo[i]));
				rewardSelectionDto.setSelectionRewardAmount(Integer.parseInt(selectionRewardAmount[i]));
				if(selectionOption.length > 0) {
				rewardSelectionDto.setSelectionOption(selectionOption[i]);
				}
				rewardSelectionDao.insert(rewardSelectionDto);
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
	
}
