package com.maum.my.vo;

public class MentalHealthCenterVO {
	private int centerId;
    private String sigunNm;
    private String centerNm;
    private String telno;
    private String zipCd;
    private String lotnoAddr;
    private String roadnmAddr;
    private double lat;
    private double lng;
	public MentalHealthCenterVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MentalHealthCenterVO(int centerId, String sigunNm, String centerNm, String telno, String zipCd,
			String lotnoAddr, String roadnmAddr, double lat, double lng) {
		super();
		this.centerId = centerId;
		this.sigunNm = sigunNm;
		this.centerNm = centerNm;
		this.telno = telno;
		this.zipCd = zipCd;
		this.lotnoAddr = lotnoAddr;
		this.roadnmAddr = roadnmAddr;
		this.lat = lat;
		this.lng = lng;
	}
	public int getCenterId() {
		return centerId;
	}
	public void setCenterId(int centerId) {
		this.centerId = centerId;
	}
	public String getSigunNm() {
		return sigunNm;
	}
	public void setSigunNm(String sigunNm) {
		this.sigunNm = sigunNm;
	}
	public String getCenterNm() {
		return centerNm;
	}
	public void setCenterNm(String centerNm) {
		this.centerNm = centerNm;
	}
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getZipCd() {
		return zipCd;
	}
	public void setZipCd(String zipCd) {
		this.zipCd = zipCd;
	}
	public String getLotnoAddr() {
		return lotnoAddr;
	}
	public void setLotnoAddr(String lotnoAddr) {
		this.lotnoAddr = lotnoAddr;
	}
	public String getRoadnmAddr() {
		return roadnmAddr;
	}
	public void setRoadnmAddr(String roadnmAddr) {
		this.roadnmAddr = roadnmAddr;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	@Override
	public String toString() {
		return "MentalHealthCenterVO [centerId=" + centerId + ", sigunNm=" + sigunNm + ", centerNm=" + centerNm
				+ ", telno=" + telno + ", zipCd=" + zipCd + ", lotnoAddr=" + lotnoAddr + ", roadnmAddr=" + roadnmAddr
				+ ", lat=" + lat + ", lng=" + lng + "]";
	}
	
	
}