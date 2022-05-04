package moa.beans;

import java.sql.Date;

public class PjProgressDto {
	private int progressNo;
	private int progressProjectNo;
	private int progressTitle;
	private int progressContent;
	private Date progressTime;
	public PjProgressDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getProgressNo() {
		return progressNo;
	}
	public int getProgressProjectNo() {
		return progressProjectNo;
	}
	public int getProgressTitle() {
		return progressTitle;
	}
	public int getProgressContent() {
		return progressContent;
	}
	public Date getProgressTime() {
		return progressTime;
	}
	public void setProgressNo(int progressNo) {
		this.progressNo = progressNo;
	}
	public void setProgressProjectNo(int progressProjectNo) {
		this.progressProjectNo = progressProjectNo;
	}
	public void setProgressTitle(int progressTitle) {
		this.progressTitle = progressTitle;
	}
	public void setProgressContent(int progressContent) {
		this.progressContent = progressContent;
	}
	public void setProgressTime(Date progressTime) {
		this.progressTime = progressTime;
	}
	
	
}
