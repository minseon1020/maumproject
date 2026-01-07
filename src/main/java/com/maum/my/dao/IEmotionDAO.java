package com.maum.my.dao;

import com.maum.my.vo.EmotionLogVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface IEmotionDAO {

    // 1. 감정 클릭 로그 저장
    public void insertEmotionLog(EmotionLogVO log);

    // 2. 특정 날짜 로그 조회
    public List<EmotionLogVO> getLogsByDate(String memId, String date);

    // 3. 특정 날짜 통계
    public List<EmotionLogVO> getDailyStatsByDate(String memId, String date);

    // 4. 최근 7일 로그
    public List<EmotionLogVO> getWeeklyLogs(String memId);

    // 5. 하루 통계
    public List<EmotionLogVO> getDailyStats(String memId);

    // 6. 주간 통계
    public List<EmotionLogVO> getWeeklyStats(String memId);

    // 7. 월간 통계
    public List<EmotionLogVO> getMonthlyStats(String memId);

    // 8. 월간 최다 감정
    public EmotionLogVO getTopMonthlyEmotion(String memId);

    // 9. 시간대별 패턴
    public List<EmotionLogVO> getTimeBlockStats(@Param("memId") String memId,
            									@Param("date") String date);
    
    public List<EmotionLogVO> getWeeklyStatsByDate(@Param("memId") String memId,@Param("date") String date);
    

    public List<EmotionLogVO> getMonthlyStatsByDate(@Param("memId") String memId,@Param("date") String date);
    
    public List<EmotionLogVO> getEmotionLogsByDate(@Param("memId") String memId,
            										@Param("selectedDate") String selectedDate);
    
    
}
