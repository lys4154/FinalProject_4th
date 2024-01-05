package member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import member.dto.MemberDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	SqlSession session;

	public MemberDTO loginMember(String email) {
		return session.selectOne("loginMember",email);
	}
	
	
	
}
