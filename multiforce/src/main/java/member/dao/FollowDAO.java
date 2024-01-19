package member.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import member.dto.MemberDTO;


@Repository
@Mapper
public interface FollowDAO {

	List<Integer> getMyFollower(int memberSeq);

	List<Integer> getMyFollowing(int memberSeq);

	Integer getCountByFollowingSeq(Integer followerSeq);


}
