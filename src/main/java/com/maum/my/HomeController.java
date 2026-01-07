package com.maum.my;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.maum.my.service.DiaryService;
import com.maum.my.vo.DiaryVO;
import com.maum.my.vo.MemberVO;

@Controller
public class HomeController {

    @Autowired
    DiaryService diaryService;

    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        // 세션에서 로그인한 사용자 확인
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 로그인 안 했으면 로그인 페이지로
            return "redirect:/login";
        }

        String userId = loginUser.getMemId(); // 세션에서 회원 아이디 가져옴

        // 해당 회원의 다이어리 조회
        ArrayList<DiaryVO> diaryList = diaryService.selectDiary(userId);
        model.addAttribute("diaryList", diaryList);

        // 로그인한 사용자 이름도 전달
        model.addAttribute("loginUser", loginUser);

        return "home"; // home.jsp
    }
}
