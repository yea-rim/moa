package moa.beans;

import java.util.Date;

public class PjQnaDto {
	private int qnaNo;
	private int qnaMemberNo;
	private int qnaProjectNo;
	private String qnaContent;
	private Date qnaTime;
	private int groupNo;
	private int superNo;
	private int depth;
	private int qnaLock;
	
	public PjQnaDto() {
		super();
	}
	
	public int getQnaNo() {
		return qnaNo;
	}
	public int getQnaMemberNo() {
		return qnaMemberNo;
	}
	public int getQnaProjectNo() {
		return qnaProjectNo;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public Date getQnaTime() {
		return qnaTime;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public int getSuperNo() {
		return superNo;
	}
	public int getDepth() {
		return depth;
	}
	public int getQnaLock() {
		return qnaLock;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public void setQnaMemberNo(int qnaMemberNo) {
		this.qnaMemberNo = qnaMemberNo;
	}
	public void setQnaProjectNo(int qnaProjectNo) {
		this.qnaProjectNo = qnaProjectNo;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public void setQnaTime(Date qnaTime) {
		this.qnaTime = qnaTime;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public void setSuperNo(int superNo) {
		this.superNo = superNo;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public void setQnaLock(int qnaLock) {
		this.qnaLock = qnaLock;
	}
	
	
}
