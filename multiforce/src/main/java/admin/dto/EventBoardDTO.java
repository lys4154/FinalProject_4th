package admin.dto;

import org.springframework.stereotype.Component;

@Component
public class EventBoardDTO {
	
	String title;
	String content;
	String write_date;
	String start_date;
	String end_date;
	boolean del_status;
	String del_date;
}
