package com.maum.my.vo;

public class EmotionLogVO {
    private int logId;        // 로그 PK
    private String memId;     // 회원 아이디
    private int emotionId;    // 감정 ID
    private String logTime; // 기록 시간
    private String emotionName; // 조인해서 가져올 때 필요
    private int emotionCount;  // 감정 횟수(통계용)
    private String weekRange;   // "2025-09-29 ~ 2025-10-05"
    private String monthRange;  // "2025-09"
    // 시간대별 출력용
    private String timeBlock;   // "00-06", "06-12", "12-18", "18
    private String memo;  // 🆕 추가
	public EmotionLogVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public EmotionLogVO(int logId, String memId, int emotionId, String logTime, String emotionName, int emotionCount,
			String weekRange, String monthRange, String timeBlock, String memo) {
		super();
		this.logId = logId;
		this.memId = memId;
		this.emotionId = emotionId;
		this.logTime = logTime;
		this.emotionName = emotionName;
		this.emotionCount = emotionCount;
		this.weekRange = weekRange;
		this.monthRange = monthRange;
		this.timeBlock = timeBlock;
		this.memo = memo;
	}
	public int getLogId() {
		return logId;
	}
	public void setLogId(int logId) {
		this.logId = logId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public int getEmotionId() {
		return emotionId;
	}
	public void setEmotionId(int emotionId) {
		this.emotionId = emotionId;
	}
	public String getLogTime() {
		return logTime;
	}
	public void setLogTime(String logTime) {
		this.logTime = logTime;
	}
	public String getEmotionName() {
		return emotionName;
	}
	public void setEmotionName(String emotionName) {
		this.emotionName = emotionName;
	}
	public int getEmotionCount() {
		return emotionCount;
	}
	public void setEmotionCount(int emotionCount) {
		this.emotionCount = emotionCount;
	}
	public String getWeekRange() {
		return weekRange;
	}
	public void setWeekRange(String weekRange) {
		this.weekRange = weekRange;
	}
	public String getMonthRange() {
		return monthRange;
	}
	public void setMonthRange(String monthRange) {
		this.monthRange = monthRange;
	}
	public String getTimeBlock() {
		return timeBlock;
	}
	public void setTimeBlock(String timeBlock) {
		this.timeBlock = timeBlock;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	@Override
	public String toString() {
		return "EmotionLogVO [logId=" + logId + ", memId=" + memId + ", emotionId=" + emotionId + ", logTime=" + logTime
				+ ", emotionName=" + emotionName + ", emotionCount=" + emotionCount + ", weekRange=" + weekRange
				+ ", monthRange=" + monthRange + ", timeBlock=" + timeBlock + ", memo=" + memo + "]";
	}
    
}