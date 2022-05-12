package moa.beans;

import java.sql.Date;

public class MoaQuestionDto {
	private int questionNo;
	private int questionWriter;
	private String questionTitle;
	private String questionContent;
	private Date questionTime;
	private String questionType;
	private int answerStatus;
	
	public MoaQuestionDto() {
		super();
	}
	
	public int getAnswerStatus() {
		return answerStatus;
	}


	public void setAnswerStatus(int answerStatus) {
		this.answerStatus = answerStatus;
	}

	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}

	
	public int getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}

	public int getQuestionWriter() {
		return questionWriter;
	}

	public void setQuestionWriter(int questionWriter) {
		this.questionWriter = questionWriter;
	}

	public String getQuestionTitle() {
		return questionTitle;
	}

	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public Date getQuestionTime() {
		return questionTime;
	}

	public void setQuestionTime(Date questionTime) {
		this.questionTime = questionTime;
	}

}
