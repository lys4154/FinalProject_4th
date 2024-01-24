package project.code;

public enum ProjectCategory {
	
	ALL("전체", "all"),
	BOARD_GAME("보드게임", "board_game"),
	DIGITAL_GAME("디지털 게임", "digital_game"),
	WEBTOON_AND_COMICS("웹툰·만화", "webtoon_and_comics"),
	WEBTOON_RESOURCE("웹툰 리소스", "webtoon_resource"),
	DESIGN_STATIONERY("디자인 문구", "design_stationery"),
	CHARACTER_AND_GOODS("캐릭터·굿즈", "character_and_goods"),
	HOME_AND_LIVING("홈·리빙", "home_and_living"),
	TECHNOLOGY_AND_HOUSEHOLE_APPLIANCE("테크·가전", "technology_and_household_appliance"),
	PET("반려동물", "pet"),
	FOOD("푸드", "food"),
	PERFUME_AND_BEAUTY("향수·뷰티", "perfume_and_beauty"),
	APPARELS("의류", "apparels"),
	ASSORTED_GOODS("잡화", "assorted_goods"),
	JEWELLERY("주얼리", "jewellery"),
	PUBLICATION("출판", "publication"),
	DESIGN("디자인", "design"),
	ART("예술", "art"),
	PHOTOGRAPHY("사진", "photography"),
	MUSIC("음악", "music"),
	FILM_AND_VIDEO("영화·비디오", "film_and_video"),
	SHOW("공연", "show");
	
	final private String korName;
	final private String engName;
	
	private ProjectCategory(String korName, String engName) {
		this.korName = korName;
		this.engName = engName;
	}

	public String getKorName() {
		return korName;
	}
	
	public String getEngName() {
		return engName;
	}
	
	
}
