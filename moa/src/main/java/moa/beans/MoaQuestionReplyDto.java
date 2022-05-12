package moa.beans;

import java.sql.Date;

public class MoaQuestionReplyDto {
	private int questionReplyNo;
	private int questionTargetNo;
	private Date questionReplyTime;
	private String questionReplyContent;
	
	public MoaQuestionReplyDto() {
		super();
	}
	

	public int getQuestionReplyNo() {
		return questionReplyNo;
	}
	public int getQuestionTargetNo() {
		return questionTargetNo;
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
	public void setQuestionReplyTime(Date questionReplyTime) {
		this.questionReplyTime = questionReplyTime;
	}
	public void setQuestionReplyContent(String questionReplyContent) {
		this.questionReplyContent = questionReplyContent;
	}
	
	
	
}
