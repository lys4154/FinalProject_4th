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


}
