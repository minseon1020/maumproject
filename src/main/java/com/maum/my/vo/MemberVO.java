package com.maum.my.vo;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

public class MemberVO {
    private String memId;     // 아이디
    private String memPass;   // 비밀번호
    private String memName;   // 이름

    @DateTimeFormat(pattern = "yyyy-MM-dd")  // "2025-09-28" -> Date로 변환
    private Date memBir;      // 생년월일

    private String memHp;     // 휴대폰
    private String memMail;   // 이메일
    private String profileImg; // 프로필 이미지 파일명 (추가)

    public MemberVO() {
    	
    }

	public MemberVO(String memId, String memPass, String memName, Date memBir, String memHp, String memMail, String profileImg) {
        super();
        this.memId = memId;
        this.memPass = memPass;
        this.memName = memName;
        this.memBir = memBir;
        this.memHp = memHp;
        this.memMail = memMail;
        this.profileImg = profileImg;
    }

	public String getMemId() {
        return memId;
    }
    public void setMemId(String memId) {
        this.memId = memId;
    }
    public String getMemPass() {
        return memPass;
    }
    public void setMemPass(String memPass) {
        this.memPass = memPass;
    }
    public String getMemName() {
        return memName;
    }
    public void setMemName(String memName) {
        this.memName = memName;
    }
    public Date getMemBir() {
        return memBir;
    }
    public void setMemBir(Date memBir) {
        this.memBir = memBir;
    }
    public String getMemHp() {
        return memHp;
    }
    public void setMemHp(String memHp) {
        this.memHp = memHp;
    }
    public String getMemMail() {
        return memMail;
    }
    public void setMemMail(String memMail) {
        this.memMail = memMail;
    }
    
    public String getProfileImg() {
    	return profileImg;
    }
    
    public void setProfileImg(String profileImg) {
    	this.profileImg = profileImg;
    }
    @Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPass=" + memPass + ", memName=" + memName + ", memBir=" + memBir
				+ ", memHp=" + memHp + ", memMail=" + memMail + ", profileImg=" + profileImg + "]";
	}
}
