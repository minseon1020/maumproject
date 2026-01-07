package com.maum.my;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.maum.my.service.MentalHealthCenterService;
import com.maum.my.vo.MentalHealthCenterVO;

@Controller
public class MentalHealthCenterController {

    @Autowired
    private MentalHealthCenterService service;

    // 상담센터 메인 페이지
    @RequestMapping("/center")
    public String centerPage() {
        return "center/center";  // WEB-INF/views/center/center.jsp
    }

    // 전체 센터 JSON
    @ResponseBody
    @RequestMapping("/api/centerList")
    public List<MentalHealthCenterVO> centerList() {
        return service.getAllCenters();
    }

    // 검색 JSON
    @ResponseBody
    @RequestMapping("/api/searchCenters")
    public List<MentalHealthCenterVO> searchCenters(@RequestParam("keyword") String keyword) {
        return service.searchCenters(keyword);
    }
}

