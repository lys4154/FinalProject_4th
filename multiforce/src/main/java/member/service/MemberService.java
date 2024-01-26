package member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import member.dao.MemberDAO;
import member.dto.FollowDTO;
import member.dto.MemberDTO;
import project.dto.ProjectDTO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDao;
	
	public MemberDTO loginMember(String email) {
		return memberDao.loginMember(email);
	}

	//마이프로필 - 팔로워
	public List<MemberDTO> myFollowerList(List<Integer> getMyFollower) {
		return memberDao.myFollowerList(getMyFollower);
	}

	//마이프로필 - 팔로잉
	public List<MemberDTO> myFollowingList(List<Integer> getMyFollower) {
		return memberDao.myFollowerList(getMyFollower);
	}

	public MemberDTO getNicknameById(int member_seq) {
		return memberDao.getNicknameById(member_seq);
	}

	public MemberDTO loginProcess(String id, String pw) {
		return memberDao.loginProcess(id, pw);
	}

	public MemberDTO idDupCheck(String id) {
		return memberDao.selectMemberById(id);
	}

	public MemberDTO nicknameDupCheck(String nickname) {
		return  memberDao.selectMemberByNickName(nickname);
	}

	public MemberDTO emailDupCheck(String email) {
		return memberDao.selectMemberByEmail(email);
		
	}

	public int signUp(MemberDTO dto) {
		return memberDao.insertMember(dto);
	}

	//회원정보수정 - 프로필사진 변경
	public int updateProfileImg(String filePath, int memberSeq) {
		return memberDao.updateProfileImg(filePath, memberSeq);
	}

	//회원정보수정 - 프로필사진 삭제
	public int profileimgDelete(int memberSeq) {
		return memberDao.profileimgDelete(memberSeq);
	}

	//회원정보수정 - 닉네임 변경
	public int nicknameChange(int memberSeq, String nickname) {
		return memberDao.nicknameChange(memberSeq, nickname);
	}

	//회원정보수정 - 소개 변경
	public int descriptionChange(int memberSeq, String desc) {
		return memberDao.descriptionChange(memberSeq, desc);
	}

	//회원정보수정 - 메일 변경
	public int emailChange(int memberSeq, String email) {
		return memberDao.emailChange(memberSeq, email);
	}

	//회원정보수정 - 비밀번호 변경
	public int passwordChange(int memberSeq, String newPw) {
		return memberDao.passwordChange(memberSeq, newPw);
	}

	//member_seq로 회원 DTO 갖고오기
	public MemberDTO loginMemberSeq(int memberSeq) {
		return memberDao.loginMemberSeq(memberSeq);
	}

	//해당 회원 프로필로 이동
	public MemberDTO userProfile(String member_url) {
		return memberDao.userProfile(member_url);
	}



}
