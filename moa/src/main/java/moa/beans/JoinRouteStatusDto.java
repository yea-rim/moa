package moa.beans;

public class JoinRouteStatusDto {
	private String member_route;
	private int cnt;
	
	public JoinRouteStatusDto() {
		super();
	}
	public String getMember_route() {
		return member_route;
	}
	public void setMember_route(String member_route) {
		this.member_route = member_route;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

}
