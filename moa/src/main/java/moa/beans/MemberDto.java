package moa.beans;

import java.sql.Date;

public class MemberDto {
	private int memberNo;
	private String memberEmail;
	private String memberPw;
	private String memberNick;
	private String memberPhone;
	private Date memberJoinDate;
	private String memberPost;
	private String memberBasicAddress;
	private String memberDetailAddress;
	private String memberRoute;
	
	public MemberDto() {
		super();
	}
	public int getMemberNo() {
		return memberNo;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public String getMemberNick() {
		return memberNick;
	}
	public String getMemberPhone() {
		return memberPhone;
	}
	public Date getMemberJoinDate() {
		return memberJoinDate;
	}
	public String getMemberPost() {
		return memberPost;
	}
	public String getMemberBasicAddress() {
		return memberBasicAddress;
	}
	public String getMemberDetailAddress() {
		return memberDetailAddress;
	}
	public String getMemberRoute() {
		return memberRoute;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}
	public void setMemberJoinDate(Date memberJoinDate) {
		this.memberJoinDate = memberJoinDate;
	}
	public void setMemberPost(String memberPost) {
		this.memberPost = memberPost;
	}
	public void setMemberBasicAddress(String memberBasicAddress) {
		this.memberBasicAddress = memberBasicAddress;
	}
	public void setMemberDetailAddress(String memberDetailAddress) {
		this.memberDetailAddress = memberDetailAddress;
	}
	public void setMemberRoute(String memberRoute) {
		this.memberRoute = memberRoute;
	}
	
	
}
