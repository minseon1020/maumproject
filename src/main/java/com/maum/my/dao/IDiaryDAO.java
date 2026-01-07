package com.maum.my.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.maum.my.vo.DiaryVO;



@Mapper
public interface IDiaryDAO {

	public void saveDiary(DiaryVO diary);//일기 저장 
	
	public ArrayList<DiaryVO> selectDiary(String memId); //월별 달력 일기 조회 
	
	public DiaryVO selectDiaryById(Long dId);         // 단일 조회
	
    public void updateDiary(DiaryVO diary);           // 수정
    
    public void deleteDiary(DiaryVO diary);   //삭제
}
