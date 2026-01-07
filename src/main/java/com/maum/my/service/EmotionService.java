package com.maum.my.service;

import com.maum.my.dao.IEmotionDAO;
import com.maum.my.vo.EmotionLogVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmotionService {

    @Autowired
    private IEmotionDAO dao;

    public void insertEmotionLog(EmotionLogVO log) {
        dao.insertEmotionLog(log);
    }

    public List<EmotionLogVO> getDailyStats(String memId) {
        return dao.getDailyStats(memId);
    }

    public List<EmotionLogVO> getDailyStatsByDate(String memId, String date) {
        return dao.getDailyStatsByDate(memId, date);
    }

    public List<EmotionLogVO> getWeeklyStats(String memId) {
        return dao.getWeeklyStats(memId);
    }

    public List<EmotionLogVO> getMonthlyStats(String memId) {
        return dao.getMonthlyStats(memId);
    }

    public EmotionLogVO getTopMonthlyEmotion(String memId) {
        return dao.getTopMonthlyEmotion(memId);
    }

    public List<EmotionLogVO> getTimeBlockStats(String memId, String date) {
        return dao.getTimeBlockStats(memId, date);
    }

    public List<EmotionLogVO> getWeeklyStatsByDate(String memId, String week) {
        return dao.getWeeklyStatsByDate(memId, week);
    }

    public List<EmotionLogVO> getMonthlyStatsByDate(String memId, String month) {
        return dao.getMonthlyStatsByDate(memId, month);
    }

    //  특정 날짜 로그 조회 (원본 스타일)
    public List<EmotionLogVO> getLogsByDate(String memId, String date) {
        return dao.getLogsByDate(memId, date);
    }

    //  타임라인: 특정 날짜의 감정 로그(시간+감정+메모) 조회
    public List<EmotionLogVO> getEmotionLogsByDate(String memId, String selectedDate) {
        return dao.getEmotionLogsByDate(memId, selectedDate);
    }
   
}
