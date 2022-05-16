package moa.beans;

import java.sql.Date;

public class BannerDto {
	private int projectNo;
	private int attachNo;
	private int bannerTerm;
	private Date bannerStartDate;
	private int bannerPermission;
	private int bannerNo;
	
	
	public int getBannerNo() {
		return bannerNo;
	}

	public void setBannerNo(int bannerNo) {
		this.bannerNo = bannerNo;
	}

	public BannerDto() {
		super();
	}

	public int getProjectNo() {
		return projectNo;
	}

	public int getAttachNo() {
		return attachNo;
	}

	public int getBannerTerm() {
		return bannerTerm;
	}

	public Date getBannerStartDate() {
		return bannerStartDate;
	}

	public int getBannerPermission() {
		return bannerPermission;
	}

	public void setProjectNo(int projectNo) {
		this.projectNo = projectNo;
	}

	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}

	public void setBannerTerm(int bannerTerm) {
		this.bannerTerm = bannerTerm;
	}

	public void setBannerStartDate(Date bannerStartDate) {
		this.bannerStartDate = bannerStartDate;
	}

	public void setBannerPermission(int bannerPermission) {
		this.bannerPermission = bannerPermission;
	}
	
	
}
