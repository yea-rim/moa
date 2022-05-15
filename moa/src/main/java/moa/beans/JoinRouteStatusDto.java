package moa.beans;

public class JoinRouteStatusDto {
	private String memberRoute;
	private int cnt;
	
	public JoinRouteStatusDto() {
		super();
	}

	public String getMemberRoute() {
		return memberRoute;
	}

	public void setMemberRoute(String memberRoute) {
		this.memberRoute = memberRoute;
	}

	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

}
