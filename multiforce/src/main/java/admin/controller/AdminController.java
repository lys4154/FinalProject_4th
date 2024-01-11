package admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.UUID;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class AdminController {
	
	@GetMapping("/notices")
	public ModelAndView notices() {
		ModelAndView mv = new ModelAndView();
		//이벤트 게시물 dto list를 모델로 넣어주기 
		mv.setViewName("admin/notices");
		return mv;
	}
	
	@GetMapping("/notices/write")
	public String noticesWrite() {
		return "admin/notices_write";
	}
	
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public JsonNode uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> resultMap = new HashMap<>();
		
		String fileRoot = "C:\\fullstack\\workspace_springboot\\FinalProject_4th\\"
							+ "multiforce\\src\\main\\resources\\static\\images\\notices\\";//저장될 외부 파일 경로
//		String fileRoot = "C:\\fullstack\\workspace_springboot\\images\\notices\\";
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;//저장될 파일 명

		try {
			File targetFile = new File(fileRoot + savedFileName);//파일저장
			multipartFile.transferTo(targetFile);
			System.out.println("try 작동");
			resultMap.put("url", "/images/notices/"+savedFileName);
			//resultMap.put("url", "/noticesimages/"+savedFileName);
			resultMap.put("responseCode", "success");
		} catch (IOException e) {
			resultMap.put("responseCode", "false");
			e.printStackTrace();
		}
		JsonNode resultJsonNode = mapper.convertValue(resultMap, JsonNode.class);
		return resultJsonNode;
	}
	
	@PostMapping("/testsummer")
	public String testsummer(String editordata) {
		System.out.println(editordata);
		return "common/mainpage";
	}
}
