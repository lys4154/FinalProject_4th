package member.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import jakarta.annotation.ManagedBean;
import member.dto.MemberDTO;
import project.dto.ProjectDTO;

@Repository
@Mapper
public interface MemberDAO {
	

	MemberDTO loginMember(String email);

	List<ProjectDTO> getMyproject(int memberSeq);

	List<MemberDTO> myFollowerList(List<Integer> getMyFollower);

	List<MemberDTO> myFollowingList(List<Integer> getMyFollower);

	MemberDTO getNicknameById(int member_seq);

	MemberDTO loginProcess(String member_id, String password);

	MemberDTO selectMemberById(String id);

	MemberDTO selectMemberByNickName(String nickname);

	MemberDTO selectMemberByEmail(String email);
	
	MemberDTO selectMemberByIdEmail(String email, String id);

	int insertMember(MemberDTO dto);

	int updateMemberPw(String email, String id, String tempPw);

	//회원정보수정 - 프로필사진 변경
	int updateProfileImg(String filePath, int memberSeq);

	//회원정보수정 - 프로필사진 삭제
	int profileimgDelete(int memberSeq);
	
	//회원정보수정 - 모든 회원 닉네임
	List<String> allMemberNick();

	//회원정보수정 - 닉네임 변경
	int nicknameChange(int memberSeq, String nickname);

	//회원정보수정 - 소개 변경
	int descriptionChange(int memberSeq, String desc);

	//회원정보수정 - 메일 변경
	int emailChange(int memberSeq, String email);

	//회원정보수정 - 비밀번호 변경
	int passwordChange(int memberSeq, String newPw);

	//member_seq로 회원 DTO 갖고오기
	MemberDTO loginMemberSeq(int memberSeq);

	//해당 회원 프로필로 이동
	MemberDTO userProfile(String userUrl);

	//회원정보수정 - 모든 회원 url 갖고오기
	List<String> allMemberurl();

	//회원정보수정 - url 변경
	int urlChange(int memberSeq, String newUrlPath);





	
};
