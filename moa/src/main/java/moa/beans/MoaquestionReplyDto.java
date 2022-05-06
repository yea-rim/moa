package moa.beans;

import java.sql.Date;

public class MoaquestionReplyDto {
	private int questionReplyNo;
	private int questionTargetNo;
	private int questionReplyAdmin;
	private int questionReplyMember;
	private Date questionReplyTime;
	private String questionReplyContent;
	
	public MoaquestionReplyDto() {
		super();
	}
	
	public int getQuestionReplyAdmin() {
		return questionReplyAdmin;
	}
	public void setQuestionReplyAdmin(int questionReplyAdmin) {
		this.questionReplyAdmin = questionReplyAdmin;
	}
	public int getQuestionReplyNo() {
		return questionReplyNo;
	}
	public int getQuestionTargetNo() {
		return questionTargetNo;
	}
	
	public int getQuestionReplyMember() {
		return questionReplyMember;
	}
	public Date getQuestionReplyTime() {
		return questionReplyTime;
	}
	public String getQuestionReplyContent() {
		return questionReplyContent;
	}
	public void setQuestionReplyNo(int questionReplyNo) {
		this.questionReplyNo = questionReplyNo;
	}
	public void setQuestionTargetNo(int questionTargetNo) {
		this.questionTargetNo = questionTargetNo;
	}
	
	public void setQuestionReplyMember(int questionReplyMember) {
		this.questionReplyMember = questionReplyMember;
	}
	public void setQuestionReplyTime(Date questionReplyTime) {
		this.questionReplyTime = questionReplyTime;
	}
	public void setQuestionReplyContent(String questionReplyContent) {
		this.questionReplyContent = questionReplyContent;
	}
	
	
	
}
