package moa.servlet.ajax;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import moa.beans.JoinRouteStatusDao;
import moa.beans.JoinRouteStatusDto;


@WebServlet(urlPatterns = "/ajax/join_chart.do")
public class AdminJoinChartServlet extends HttpServlet{
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			JoinRouteStatusDao joinRouteDao = new JoinRouteStatusDao();
			List<JoinRouteStatusDto> list = joinRouteDao.selectList();
			
			ObjectMapper mapper = new ObjectMapper();
			resp.setContentType("application/json; charset=UTF-8");
			resp.getWriter().print(mapper.writeValueAsString(list)); //mapper를 이용해서 변환한 list
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
