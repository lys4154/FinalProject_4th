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

	List<MemberDTO> MyFollowerList(List<Integer> getMyFollower);

	List<MemberDTO> MyFollowingList(List<Integer> getMyFollower);

	MemberDTO getNicknameById(int member_seq);

	
}
