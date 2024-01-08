package member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import member.dao.FollowDAO;
import member.dto.MemberDTO;

@Service
public class FollowService {
	
	@Autowired
	private FollowDAO followDao;

	public List<Integer> getMyFollower(int memberSeq) {
		return followDao.getMyFollower(memberSeq); 
	}

	public List<Integer> getMyFollowing(int memberSeq) {
		return followDao.getMyFollowing(memberSeq); 
	}





}
