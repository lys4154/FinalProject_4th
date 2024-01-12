package summernote.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ImageUploadController {
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public JsonNode uploadSummernoteImageFile(
			@RequestParam("file") MultipartFile multipartFile, String path, String url) {
		
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> resultMap = new HashMap<>();
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;//저장될 파일 명

		try {
			File targetFile = new File(path + savedFileName);//파일저장
			multipartFile.transferTo(targetFile);
			resultMap.put("url", url + savedFileName);
			resultMap.put("responseCode", "success");
		} catch (IOException e) {
			resultMap.put("responseCode", "false");
			e.printStackTrace();
		}
		JsonNode resultJsonNode = mapper.convertValue(resultMap, JsonNode.class);
		return resultJsonNode;
	}
}
