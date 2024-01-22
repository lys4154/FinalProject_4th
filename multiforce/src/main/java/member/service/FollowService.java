package member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.wls.shaded.org.apache.regexp.recompile;

import member.dao.FollowDAO;
import member.dto.MemberDTO;

@Service
public class FollowService {
	
	@Autowired
	private FollowDAO followDao;

	//마이프로필 - 팔로워
	public List<Integer> getMyFollower(int memberSeq) {
		return followDao.getMyFollower(memberSeq); 
	}

	//마이프로필 - 팔로잉
	public List<Integer> getMyFollowing(int memberSeq) {
		return followDao.getMyFollowing(memberSeq); 
	}
	
	//마이프로필 - 팔로워의 팔로워 
	public Integer getCountByFollowingSeq(Integer followerSeq) {
		return followDao.getCountByFollowingSeq(followerSeq); 
	}

	//마이프로필 - 팔로워 팔로우하기
	public int followerAdd(int followingMemberSeq, int followerMemberSeq) {
		return followDao.followerAdd(followingMemberSeq, followerMemberSeq);
	}
	
	//마이프로필 - 팔로우 취소하기
	public int unfollow(int followingMemberSeq, int followerMemberSeq) {
		return followDao.unfollow(followingMemberSeq, followerMemberSeq);
	}




}
