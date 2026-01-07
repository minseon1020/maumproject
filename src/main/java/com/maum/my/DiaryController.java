package com.maum.my;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.maum.my.service.DiaryService;
import com.maum.my.vo.DiaryVO;
import com.maum.my.vo.MemberVO;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/diary")
public class DiaryController {

    @Autowired
    DiaryService diaryService;

    // 작성 페이지 이동
    @GetMapping("/write")
    public String writeDiary(@RequestParam String date, Model model) {
        model.addAttribute("date", date);
        return "diary/diaryWrite"; // views/diary/diaryWrite.jsp
    }

    //  저장 (세션에서 memId 가져오기)
    @PostMapping("/save")
    public String saveDiary(DiaryVO vo, HttpSession session) {
        // 로그인 사용자 세션 확인
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login"; // 로그인 안 되어 있으면 로그인 페이지로
        }

        // 세션에 있는 아이디를 DiaryVO에 세팅
        vo.setMemId(loginUser.getMemId());

        // DB 저장
        diaryService.saveDiary(vo);

        return "redirect:/"; // 홈으로 이동
    }

    // 단일 조회
    @GetMapping("/view")
    public String viewDiary(@RequestParam Long dId, Model model) {
        DiaryVO diary = diaryService.getDiaryById(dId);
        model.addAttribute("diary", diary);
        return "diary/diaryView"; // JSP 이동
    }

    // 수정
    @PostMapping("/update")
    public String updateDiary(DiaryVO diary, HttpSession session) {
        // 로그인 사용자 확인 후 본인 글만 수정 가능하도록
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        diary.setMemId(loginUser.getMemId());
        diaryService.updateDiary(diary);

        return "redirect:/";
    }

    // 삭제
    @PostMapping("/delete")
    public String deleteDiary(@RequestParam Long dId, HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        DiaryVO vo = new DiaryVO();
        vo.setdId(dId);
        vo.setMemId(loginUser.getMemId());

        diaryService.deleteDiary(vo);
        return "redirect:/"; // 홈으로 이동
    }
}
