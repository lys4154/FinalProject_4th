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

	public List<ProjectDTO> getMyproject(int memberSeq) { 
		return	memberDao.getMyproject(memberSeq); 
	}


	public List<MemberDTO> MyFollowerList(List<Integer> getMyFollower) {
		return memberDao.MyFollowerList(getMyFollower);
	}

	public List<MemberDTO> MyFollowingList(List<Integer> getMyFollower) {
		return memberDao.MyFollowingList(getMyFollower);
	}

	public MemberDTO getNicknameById(int member_seq) {
		return memberDao.getNicknameById(member_seq);
	}



}
