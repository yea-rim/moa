//package moa.servlet.funding;
//
//import java.util.Calendar;
//import java.util.Timer;
//import java.util.TimerTask;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//
//import moa.beans.FundingDao;
//
//
////매일 새벽 1시에 자동으로 결제날짜가 지난 프로젝트 결제하는 메서드 작동(취소된 펀딩은 제외)
//@WebServlet(urlPatterns = "/fundingautopaymentservlet.do", loadOnStartup = 1)
//public class FundingPaymentServlet extends HttpServlet {
//
//	@Override
//	public void init() throws ServletException {
//		FundingDao fundingDao = new FundingDao();
//
//		
//		Calendar date = Calendar.getInstance();
//		
//		date.add(Calendar.DATE, 1);
//		date.set(Calendar.HOUR_OF_DAY , 1);
//		date.set(Calendar.MINUTE, 0);
//		date.set(Calendar.SECOND, 0);
//		date.set(Calendar.MILLISECOND, 0);
//		
//		
//		Timer timer = new Timer();
//
//		TimerTask TimerTask = new TimerTask() {
//
//			@Override
//			public void run() {
//				try {
//					boolean success = fundingDao.paymentCheck();
//					System.out.println("가동");
//					if(success) {
//						System.out.println("결제 성공");
//					}else {
//						System.out.println("결제 실패");
//					}
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//		};
//		
//		timer.scheduleAtFixedRate(TimerTask, date.getTime(), 60000*60*24);
//
//	}
//	
//}
