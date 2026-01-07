package com.maum.my;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.maum.my.service.MemberService;
import com.maum.my.vo.MemberVO;

@Controller
public class MyPageController {

    @Autowired
    MemberService memberService;

    //  실제 파일 저장 경로 (윈도우)
    private final String CURR_IMAGE_PATH = "C:/upload/profile/";
    //  웹에서 접근할 경로 (WebPath)
    private final String WEB_PATH = "/download?imageFileName=";

    //  마이페이지 화면
    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginUser");
        if (loginMember == null) {
            return "redirect:/login";
        }
        MemberVO dbMember = memberService.getMemberById(loginMember.getMemId());
        model.addAttribute("member", dbMember);
        return "mypage";
    }

    //  회원 정보 수정
    @PostMapping("/mypage/update")
    public String updateMember(MemberVO member, HttpSession session) {
        memberService.updateMember(member);
        session.setAttribute("loginUser", memberService.getMemberById(member.getMemId()));
        session.setAttribute("msg", "수정이 완료되었습니다.");
        return "redirect:/mypage";
    }

    //  프로필 사진 업로드 (AJAX)
    @PostMapping("/files/upload")
    @ResponseBody
    public Map<String, Object> uploadProfile(@RequestParam("uploadImage") MultipartFile file,
                                             HttpSession session) throws IOException {
        Map<String, Object> result = new HashMap<>();
        MemberVO loginMember = (MemberVO) session.getAttribute("loginUser");

        if (file != null && !file.isEmpty()) {
            // 파일 이름
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File dest = new File(CURR_IMAGE_PATH, fileName);
            if (!dest.getParentFile().exists()) {
                dest.getParentFile().mkdirs();
            }
            file.transferTo(dest);

            // DB에 저장될 경로
            String dbPath = WEB_PATH + fileName;
            loginMember.setProfileImg(dbPath);
            memberService.updateProfileImg(loginMember);

            // 세션 업데이트
            session.setAttribute("loginUser", loginMember);

            result.put("message", "success");
            result.put("imagePath", dbPath);
        } else {
            result.put("message", "fail");
        }

        return result;
    }
    //파일 다운로드 
    @RequestMapping("/download")
	public void download(String imageFileName, HttpServletResponse resp) throws IOException {
		System.out.println(CURR_IMAGE_PATH);
		System.out.println(WEB_PATH);
		OutputStream out = resp.getOutputStream();
		String downloadFile = CURR_IMAGE_PATH + "\\" + imageFileName;
		File file = new File(downloadFile);
		if(!file.exists()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "file not found");
		}
		// 서버에서 요청 파일을 찾아서 전달 (실시간 전송)
		resp.setHeader("Cache-Control", "no-cache");
		resp.setHeader("Content-Disposition","attachement; fileName=" + imageFileName);
		try(FileInputStream in = new FileInputStream(file)){
			byte [] buffer = new byte[1024 * 8];
			while(true) {
				int count = in.read(buffer);
				if(count == -1) {
					break;
				}
				out.write(buffer, 0, count); //실시간 전송 
			}
 		}catch(IOException e) {
			e.printStackTrace();
		}finally {
			out.close();
		}
	}
    
}
