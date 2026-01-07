package com.maum.my;

import com.maum.my.service.EmotionService;
import com.maum.my.vo.EmotionLogVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import javax.servlet.http.HttpSession;
import com.maum.my.vo.MemberVO;

@RestController
@RequestMapping("/emotion")
public class EmotionController {

    @Autowired
    private EmotionService emotionService;

    // ✅ 감정 클릭 → 로그 저장
    @PostMapping("/click")
    public String saveEmotion(@RequestBody EmotionLogVO log) {
        // 🆕 메모 비어있으면 null 처리
        if (log.getMemo() != null && log.getMemo().trim().isEmpty()) {
            log.setMemo(null);
        }

        emotionService.insertEmotionLog(log);
        return "감정이 저장되었습니다!";
    }

    // ✅ 오늘 통계
    @GetMapping("/stats/daily")
    public List<EmotionLogVO> getDailyStats(@RequestParam String memId) {
        return emotionService.getDailyStats(memId);
    }

    // ✅ 특정 날짜 통계
    @GetMapping("/stats/daily/byDate")
    public List<EmotionLogVO> getDailyStatsByDate(@RequestParam String memId,
            @RequestParam String date) {
        return emotionService.getDailyStatsByDate(memId, date);
    }

    // ✅ 주간 통계
    @GetMapping("/stats/weekly")
    public List<EmotionLogVO> getWeeklyStats(@RequestParam String memId) {
        return emotionService.getWeeklyStats(memId);
    }

    // ✅ 월간 통계
    @GetMapping("/stats/monthly")
    public List<EmotionLogVO> getMonthlyStats(@RequestParam String memId) {
        return emotionService.getMonthlyStats(memId);
    }

    // 월간 최다 감정
    @GetMapping("/stats/monthly/top")
    public EmotionLogVO getTopMonthlyEmotion(@RequestParam String memId) {
        return emotionService.getTopMonthlyEmotion(memId);
    }

    // 시간대별 패턴
    @GetMapping("/stats/time-block")
    public List<EmotionLogVO> getTimeBlockStats(@RequestParam String memId,
            @RequestParam String date) {
        return emotionService.getTimeBlockStats(memId, date);
    }

    // 특정 주간 통계 (날짜 기준)
    @GetMapping("/stats/weekly/byDate")
    public List<EmotionLogVO> getWeeklyStatsByDate(@RequestParam String memId,
            @RequestParam String date) {
        return emotionService.getWeeklyStatsByDate(memId, date);
    }

    // 특정 월간 통계 (날짜 기준)
    @GetMapping("/stats/monthly/byDate")
    public List<EmotionLogVO> getMonthlyStatsByDate(@RequestParam String memId,
            @RequestParam String date) {
        return emotionService.getMonthlyStatsByDate(memId, date);
    }

    // [추가] 특정 날짜 로그 조회 (JSON 반환, 원본 로그용)
    @GetMapping("/logsByDate")
    public List<EmotionLogVO> getLogsByDate(@RequestParam String memId,
            @RequestParam String date) {
        return emotionService.getLogsByDate(memId, date);
    }

    // 감정 타임라인 페이지 (JSP)
    @GetMapping("/timeline")
    public ModelAndView showTimeline(@RequestParam(required = false) String date, HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return new ModelAndView("redirect:/login");
        }
        String memId = loginUser.getMemId();

        if (date == null || date.isEmpty()) {
            date = java.time.LocalDate.now().toString(); // 기본값: 오늘
        }

        List<EmotionLogVO> logs = emotionService.getEmotionLogsByDate(memId, date);

        ModelAndView mv = new ModelAndView("timeline"); // timeline.jsp 연결
        mv.addObject("logs", logs);
        mv.addObject("date", date);
        return mv;
    }

}
