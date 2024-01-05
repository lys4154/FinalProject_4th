package member.service;

import org.springframework.stereotype.Service;

import member.dto.MemberDTO;

@Service("memberservice")
public interface MemberService {

	MemberDTO loginMember(String email);

}
