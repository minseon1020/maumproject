package com.maum.my.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.maum.my.dao.MentalHealthCenterDAO;
import com.maum.my.vo.MentalHealthCenterVO;

@Service
public class MentalHealthCenterService {
    @Autowired
    MentalHealthCenterDAO dao;

    public List<MentalHealthCenterVO> getAllCenters() {
        return dao.selectAllCenters();
    }

    public List<MentalHealthCenterVO> searchCenters(String keyword) {
        return dao.searchCenters(keyword);
    }
}
