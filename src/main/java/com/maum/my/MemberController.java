package com.maum.my;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.maum.my.service.MemberService;
import com.maum.my.vo.MemberVO;

import javax.servlet.http.HttpSession;

@Controller
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 회원가입 화면
    @GetMapping("/join")
    public String showJoinForm() {
        return "join"; // /WEB-INF/views/join.jsp
    }

    // 회원가입 처리
    // 회원가입 처리
    @PostMapping("/join")
    public String processJoin(MemberVO member, Model model) {
        // (기존 서버측 중복 체크도 유지 - 안전장치)
        if (memberService.getMemberById(member.getMemId()) != null) {
            model.addAttribute("error", "이미 존재하는 아이디입니다.");
            return "join";
        }

        if (member.getProfileImg() == null || member.getProfileImg().isEmpty()) {
            member.setProfileImg("/assets/img/non.png");
        }

        memberService.join(member);
        return "redirect:/login";
    }

    // 아이디 중복확인 (AJAX)
    @PostMapping("/checkId")
    @ResponseBody
    public String checkId(@RequestParam String memId) {
        MemberVO member = memberService.getMemberById(memId);
        if (member != null) {
            return "EXIST";
        }
        return "OK";
    }

    // 로그인 화면
    @GetMapping("/login")
    public String showLoginForm() {
        return "login"; // /WEB-INF/views/login.jsp
    }

    // 로그인 처리
    @PostMapping("/login")
    public String processLogin(@RequestParam String memId,
            @RequestParam String memPass,
            HttpSession session,
            Model model) {

        MemberVO loginUser = memberService.login(memId, memPass);

        if (loginUser != null) {
            // 세션에 로그인 사용자 저장
            session.setAttribute("loginUser", loginUser);
            return "redirect:/"; // 로그인 성공 → 홈으로 이동
        } else {
            model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login"; // 로그인 실패 → 다시 로그인 페이지
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 전체 삭제
        return "redirect:/login"; // 로그아웃 후 로그인 페이지로 바로 이동
    }

}
