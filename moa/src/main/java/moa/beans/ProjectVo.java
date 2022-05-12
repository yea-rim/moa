package moa.beans;

public class ProjectVo {
	
	private int projectNo;
	private int daycount;
	private int percent;
	private int joacount;
	private int presentMoney;
	private int sponsor;
	
	
	public int getProjectNo() {
		return projectNo;
	}
	public int getDaycount() {
		return daycount;
	}
	public int getPercent() {
		return percent;
	}
	public int getJoacount() {
		return joacount;
	}
	public void setProjectNo(int projectNo) {
		this.projectNo = projectNo;
	}
	public void setDaycount(int daycount) {
		this.daycount = daycount;
	}
	public void setPercent(int percent) {
		this.percent = percent;
	}
	public void setJoacount(int joacount) {
		this.joacount = joacount;
	}
	public int getPresentMoney() {
		return presentMoney;
	}
	public int getSponsor() {
		return sponsor;
	}
	public void setPresentMoney(int presentMoney) {
		this.presentMoney = presentMoney;
	}
	public void setSponsor(int sponsor) {
		this.sponsor = sponsor;
	}
	public ProjectVo() {
	}
	
	

}
