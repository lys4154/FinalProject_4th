package project.code;

public enum ProjectProcess {
	WRITE_INCOMPLETE(0, "작성 미완료"), 
	REQUEST_APPROVAL(1, "승인 요청"),
	REQUEST_REJECT(2, "반려"),
	REQUEST_ADMIT(3, "펀딩 예정"),
	FUNDING_START(4, "진행중"),
	FUNDING_FAILED(5, "펀딩 실패"),
	FUNDING_SUCCESS(6, "펀딩 성공"),
	FUNDING_COMPLETE(7, "펀딩 완료");
	
	final private int code;
	final private String name;
	
	public String getName() {
		return name;
	}
	public int getCode() {
		return code;
	}
	private ProjectProcess(int code, String name) {
		this.name = name;
		this.code = code;
	}
}
