package com.maum.my.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.maum.my.dao.IMemberDAO;
import com.maum.my.vo.MemberVO;

@Service
public class MemberService {

    @Autowired
    IMemberDAO dao;

    // 회원가입
    public void join(MemberVO member) {
        dao.insertMember(member);
    }

    // 로그인
    public MemberVO login(String memId, String memPass) {
        MemberVO dbMember = dao.selectMemberById(memId);
        if (dbMember != null && dbMember.getMemPass().equals(memPass)) {
            return dbMember; // 로그인 성공
        }
        return null; // 실패
    }

    // 마이페이지 - 아이디로 회원 조회
    public MemberVO getMemberById(String memId) {
        return dao.selectMemberById(memId);
    }

    // 마이페이지 - 회원정보 수정
    public void updateMember(MemberVO member) {
        dao.updateMember(member);
    }

    // 마이페이지 - 프로필 이미지 수정
    public void updateProfileImg(MemberVO member) {
        dao.updateProfileImg(member);
    }
}
