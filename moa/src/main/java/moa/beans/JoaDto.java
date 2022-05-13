package moa.beans;

import java.sql.Date;

public class JoaDto {
	private int projectNo;
	private int memberNo;
	private Date joaDate;
	
	public JoaDto() {
		super();
	}
	public int getProjectNo() {
		return projectNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setProjectNo(int projectNo) {
		this.projectNo = projectNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public Date getJoaDate() {
		return joaDate;
	}
	public void setJoaDate(Date joaDate) {
		this.joaDate = joaDate;
	}
	
	
}
