package com.maum.my.dao;

import com.maum.my.vo.MemberVO;

public interface IMemberDAO {
   public void insertMember(MemberVO member);       // 회원가입
   public  MemberVO selectMemberById(String memId); // 로그인 시 아이디 확인
   public void updateProfileImg(MemberVO member);      // 프로필 이미지 수정
   public void updateMember(MemberVO member);          // 회원정보 수정
}
