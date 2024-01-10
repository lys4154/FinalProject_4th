package admin.dto;

import org.springframework.stereotype.Component;

@Component
public class NoticeBoardDTO {
	
	String title;
	String content;
	String write_date;
	boolean del_status;
	String del_date;
}
