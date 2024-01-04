package board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.dto.BoardDTO;
import board.service.boardService;
import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {
	@Autowired
	private boardService boardService;
	
	@GetMapping("cs/write-form")
    public String CustomerServiceWrite(Model model) {
    	model.addAttribute("boardType", "cs");
        return "board/cs_write"; 
    }
	
	@PostMapping("/boardwrite")
    public String writeProcess(@RequestParam String title,
                               @RequestParam String contents,
                               Model model) {
        
		int tmpUser = 5;
        BoardDTO dto = new BoardDTO();
        dto.setTitle(title);
        dto.setContent(contents);
        dto.setMemberSeq(tmpUser);

        

        boardService.saveBoard(dto);
        

        return "redirect:cs/write-form";
    }
}
