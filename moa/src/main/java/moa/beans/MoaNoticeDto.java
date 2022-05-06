package moa.beans;

import java.sql.Date;

public class MoaNoticeDto {

	private int noticeNo;
	private int noticeAdminNo;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeTime;
	private int noticeReadcount;

	public MoaNoticeDto() {
		super();
	}
	
	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public int getNoticeAdminNo() {
		return noticeAdminNo;
	}

	public void setNoticeAdminNo(int noticeAdminNo) {
		this.noticeAdminNo = noticeAdminNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public Date getNoticeTime() {
		return noticeTime;
	}

	public void setNoticeTime(Date noticeTime) {
		this.noticeTime = noticeTime;
	}

	public int getNoticeReadcount() {
		return noticeReadcount;
	}

	public void setNoticeReadcount(int noticeReadcount) {
		this.noticeReadcount = noticeReadcount;
	}

}
