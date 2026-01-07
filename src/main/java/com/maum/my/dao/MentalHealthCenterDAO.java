package com.maum.my.dao;

import java.util.List;
import com.maum.my.vo.MentalHealthCenterVO;

public interface MentalHealthCenterDAO {
    List<MentalHealthCenterVO> selectAllCenters();
    List<MentalHealthCenterVO> searchCenters(String keyword);
}
