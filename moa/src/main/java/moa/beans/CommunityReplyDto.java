package moa.beans;

import java.util.Date;

public class CommunityReplyDto {

	private int communityReplyNo;
	private int communityNo; 
	private int communityMemberNo;
	private Date communityReplyTime;
	private String communityReplyContent;
	
	public CommunityReplyDto() {
		super();
	}

	public int getCommunityReplyNo() {
		return communityReplyNo;
	}

	public void setCommunityReplyNo(int communityReplyNo) {
		this.communityReplyNo = communityReplyNo;
	}

	public int getCommunityNo() {
		return communityNo;
	}

	public void setCommunityNo(int communityNo) {
		this.communityNo = communityNo;
	}

	public int getCommunityMemberNo() {
		return communityMemberNo;
	}

	public void setCommunityMemberNo(int communityMemberNo) {
		this.communityMemberNo = communityMemberNo;
	}

	public Date getCommunityReplyTime() {
		return communityReplyTime;
	}

	public void setCommunityReplyTime(Date communityReplyTime) {
		this.communityReplyTime = communityReplyTime;
	}

	public String getCommunityReplyContent() {
		return communityReplyContent;
	}

	public void setCommunityReplyContent(String communityReplyContent) {
		this.communityReplyContent = communityReplyContent;
	}
	
}
