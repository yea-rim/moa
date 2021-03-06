package moa.beans;

import java.sql.Date;

public class CommunityDto {

	private int communityNo;
	private int communityProjectNo;
	private int communityMemberNo;
	private String communityTitle;
	private String communityContent;
	private Date communityTime;
	private int communityReadcount;
	private int communityReplycount;
	
	public CommunityDto() {
		super();
	}

	public int getCommunityNo() {
		return communityNo;
	}

	public void setCommunityNo(int communityNo) {
		this.communityNo = communityNo;
	}

	public int getCommunityProjectNo() {
		return communityProjectNo;
	}

	public void setCommunityProjectNo(int communityProjectNo) {
		this.communityProjectNo = communityProjectNo;
	}

	public int getCommunityMemberNo() {
		return communityMemberNo;
	}

	public void setCommunityMemberNo(int communityMemberNo) {
		this.communityMemberNo = communityMemberNo;
	}

	public String getCommunityTitle() {
		return communityTitle;
	}

	public void setCommunityTitle(String communityTitle) {
		this.communityTitle = communityTitle;
	}

	public String getCommunityContent() {
		return communityContent;
	}

	public void setCommunityContent(String communityContent) {
		this.communityContent = communityContent;
	}

	public Date getCommunityTime() {
		return communityTime;
	}

	public void setCommunityTime(Date communityTime) {
		this.communityTime = communityTime;
	}

	public int getCommunityReadcount() {
		return communityReadcount;
	}

	public void setCommunityReadcount(int communityReadcount) {
		this.communityReadcount = communityReadcount;
	}

	public int getCommunityReplycount() {
		return communityReplycount;
	}

	public void setCommunityReplycount(int communityReplycount) {
		this.communityReplycount = communityReplycount;
	}

}
