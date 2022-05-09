package moa.beans;

import java.sql.Date;

public class ProjectDto {
	private int projectNo;
	private int projectSellerNo;
	private String projectCategory;
	private String projectName;
	private String projectSummary;
	private int projectTargetMoney;
	private int projectPresentMoney;
	private int projectSponsorNo;
	private Date projectStartDate;
	private Date projectSemiFinish;
	private Date projectFinishDate;
	private String projectPermission;
	private int projectReadcount;
	private String projectRefuseMsg;
	
	
	public String getProjectRefuseMsg() {
		return projectRefuseMsg;
	}

	public void setProjectRefuseMsg(String projectRefuseMsg) {
		this.projectRefuseMsg = projectRefuseMsg;
	}

	public int getProjectReadcount() {
		return projectReadcount;
	}

	public void setProjectReadcount(int projectReadcount) {
		this.projectReadcount = projectReadcount;
	}

	public ProjectDto() {
		super();
	}
	
	public int getProjectReadCount() {
		return projectReadcount;
	}

	public void setProjectReadCount(int projectReadCount) {
		this.projectReadcount = projectReadCount;
	}

	public int getProjectNo() {
		return projectNo;
	}

	public void setProjectNo(int projectNo) {
		this.projectNo = projectNo;
	}

	public int getProjectSellerNo() {
		return projectSellerNo;
	}

	public void setProjectSellerNo(int projectSellerNo) {
		this.projectSellerNo = projectSellerNo;
	}

	public String getProjectCategory() {
		return projectCategory;
	}

	public void setProjectCategory(String projectCategory) {
		this.projectCategory = projectCategory;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectSummary() {
		return projectSummary;
	}

	public void setProjectSummary(String projectSummary) {
		this.projectSummary = projectSummary;
	}

	public int getProjectTargetMoney() {
		return projectTargetMoney;
	}

	public void setProjectTargetMoney(int projectTargetMoney) {
		this.projectTargetMoney = projectTargetMoney;
	}

	public int getProjectPresentMoney() {
		return projectPresentMoney;
	}

	public void setProjectPresentMoney(int projectPresentMoney) {
		this.projectPresentMoney = projectPresentMoney;
	}

	public int getProjectSponsorNo() {
		return projectSponsorNo;
	}

	public void setProjectSponsorNo(int projectSponsorNo) {
		this.projectSponsorNo = projectSponsorNo;
	}

	public Date getProjectStartDate() {
		return projectStartDate;
	}

	public void setProjectStartDate(Date projectStartDate) {
		this.projectStartDate = projectStartDate;
	}

	public Date getProjectSemiFinish() {
		return projectSemiFinish;
	}

	public void setProjectSemiFinish(Date projectSemiFinish) {
		this.projectSemiFinish = projectSemiFinish;
	}

	public Date getProjectFinishDate() {
		return projectFinishDate;
	}

	public void setProjectFinishDate(Date projectFinishDate) {
		this.projectFinishDate = projectFinishDate;
	}

	public String getProjectPermission() {
		return projectPermission;
	}

	public void setProjectPermission(String projectPermission) {
		this.projectPermission = projectPermission;
	}

}
