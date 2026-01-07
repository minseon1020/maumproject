package com.maum.my.vo;

public class DiaryVO {

	private Long dId;
    private String title;
    private String memId;
    private String cContent;
    private String diaryDate;
    private String createdAt;
	public DiaryVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DiaryVO(Long dId, String title, String memId, String cContent, String diaryDate, String createdAt) {
		super();
		this.dId = dId;
		this.title = title;
		this.memId = memId;
		this.cContent = cContent;
		this.diaryDate = diaryDate;
		this.createdAt = createdAt;
	}
	public Long getdId() {
		return dId;
	}
	public void setdId(Long dId) {
		this.dId = dId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getcContent() {
		return cContent;
	}
	public void setcContent(String cContent) {
		this.cContent = cContent;
	}
	public String getDiaryDate() {
		return diaryDate;
	}
	public void setDiaryDate(String diaryDate) {
		this.diaryDate = diaryDate;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "DiaryVO [dId=" + dId + ", title=" + title + ", memId=" + memId + ", cContent=" + cContent
				+ ", diaryDate=" + diaryDate + ", createdAt=" + createdAt + "]";
	}
	
}
