package member.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import member.dto.MemberDTO;


@Repository
@Mapper
public interface FollowDAO {

	//마이프로필 - 팔로워
	List<Integer> getMyFollower(int memberSeq);

	//마이프로필 - 팔로잉
	List<Integer> getMyFollowing(int memberSeq);

	//마이프로필 - 팔로워의 팔로워
	Integer getCountByFollowingSeq(Integer followerSeq);

	//마이프로필 - 팔로워 팔로우하기
	int followerAdd(int param1, int param2);

	//마이프로필 - 팔로우 취소하기
	int unfollow(int param1, int param2);


}
