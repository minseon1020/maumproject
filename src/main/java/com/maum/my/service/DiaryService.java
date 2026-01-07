package com.maum.my.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maum.my.dao.IDiaryDAO;
import com.maum.my.vo.DiaryVO;

@Service
public class DiaryService {

	@Autowired
	IDiaryDAO dao; //db 접근용 인터페이스
	
	public void saveDiary(DiaryVO diary) { //insert 가져옴
        dao.saveDiary(diary);
    }
		
	public ArrayList<DiaryVO> selectDiary(String userId){ //월별 select 여러건 가져옴
		return dao.selectDiary(userId);
	}
	public DiaryVO getDiaryById(Long dId) { //단일 select 한건 가져옴 
        return dao.selectDiaryById(dId);
    }

    public void updateDiary(DiaryVO diary) { //update 수정 가져옴
        dao.updateDiary(diary);
    }
    public void deleteDiary(DiaryVO diary) { //삭제 
        dao.deleteDiary(diary);
    }
    
}

