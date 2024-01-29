package member.controller;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.service.FollowService;
import member.service.MemberService;
import project.dto.ProjectDTO;
import project.service.ProjectService;

@Controller
public class UserProfileController {
	
	@Autowired
	private MemberService memberservice;
	@Autowired
	private ProjectService projectservice;
	@Autowired
	private FollowService followservice;
		
	
	
	//해당 회원 프로필로 이동
	@GetMapping("/user_profile/{member_url}")
	public String userProfile(@PathVariable String member_url, Model model) {
		System.out.println(member_url);
		String userUrl = "/user_profile/" + member_url;
		
        MemberDTO userProfile = memberservice.userProfile(userUrl);
        
        model.addAttribute("user", userProfile);
        return "member/user_profile";
	}	
		
	
	
	//회원의 올린 프로젝트
    @GetMapping("/getUserproject")
    @ResponseBody
    List<ProjectDTO> getMyproject(int memberSeq) {
    	
		List<ProjectDTO> myprojectList = projectservice.getProjectsByMemberSeq(memberSeq);	
		return myprojectList;    	
    }
    

    
    //회원의 팔로워
    @GetMapping("/getUserFollower")
    @ResponseBody
    Map<String, Object> getFollower(int memberSeq) {

        List<Integer> getMyFollower = followservice.getMyFollower(memberSeq);		// 현재 회원의 팔로워들의 memberSeq 리스트
        
        if (getMyFollower.size() != 0) {
            List<MemberDTO> myFollower = memberservice.myFollowerList(getMyFollower);	// 위 회원들의 정보

            
            List<Integer> followersSeq = new ArrayList<>();								// 팔로워들의 seq
            for (MemberDTO follower : myFollower) {
            	followersSeq.add(follower.getMember_seq());
            }

            Map<Integer, Integer> followerCounts = new HashMap<>();						// 팔로워들의 팔로워 찾기
            Map<Integer, Integer> followerProject = new HashMap<>();					// 팔로워들의 올린프로젝트 찾기

            for (Integer followerSeq : followersSeq) {
                Integer count = followservice.getCountByFollowingSeq(followerSeq);
                if (count == null) {
                    count = 0;
                }
                followerCounts.put(followerSeq, count);
                
                Integer projectCount = projectservice.getProjectCount(followerSeq);
                followerProject.put(followerSeq, projectCount);
            }
            
            Map<String, Object> myFollowers = new HashMap<>();
            myFollowers.put("myFollower", myFollower);
            myFollowers.put("followerCounts", followerCounts);
            myFollowers.put("followerProject", followerProject);
            
            return myFollowers;
        }
        return null;	        	
    }
    
  
     
    //팔로우 버튼 클릭
    @PostMapping("/userFollower_btn")
    @ResponseBody
    public int followerAdd(int followerSeq, HttpSession session) {
    	if(session.getAttribute("login_user_seq") == null) {
    		System.out.println("세션 null");
    		return 2;
    		//session이 비어있으면 로그인으로 이동
    	}
    	
    	int followingMemberSeq = (int)session.getAttribute("login_user_seq"); //로그인본인seq
    	int followerMemberSeq = followerSeq;	//팔로워의seq
    	
    	int followerAdd = followservice.followerAdd(followingMemberSeq,followerMemberSeq); // 1-> insert됨,  0-> 이미 팔로우
    	
    	if (followerAdd == 0) {
    		return 3;
    		//이미 팔로우 되어있을때.
    	}

		return followerAdd;
	}
    
    
    
    //회원의 팔로잉
    @GetMapping("/getUserFollowing")
    @ResponseBody
    Map<String, Object> getFollowing(int memberSeq) { 
		
		List<Integer> getMyFollowing = followservice.getMyFollowing(memberSeq); 		//현재 회원의 팔로잉들의 memberSeq 리스트
		if (getMyFollowing.size() != 0) {
			List<MemberDTO> myFollowing = memberservice.myFollowingList(getMyFollowing);	//위 회원들의 정보
			
	        List<Integer> followersSeq = new ArrayList<>();								// 팔로잉들의 seq
	        for (MemberDTO following : myFollowing) {
	        	followersSeq.add(following.getMember_seq());
	        }
	        
	        Map<Integer, Integer> followerCounts = new HashMap<>();						// 팔로워들의 팔로워 찾기
	        Map<Integer, Integer> followerProject = new HashMap<>();					// 팔로워들의 올린프로젝트 찾기

	        for (Integer followerSeq : followersSeq) {
	            Integer count = followservice.getCountByFollowingSeq(followerSeq);
	            if (count == null) {
	                count = 0;
	            }
	            followerCounts.put(followerSeq, count);

	            Integer projectCount = projectservice.getProjectCount(followerSeq);
	            followerProject.put(followerSeq, projectCount);
	        }
	        
	        Map<String, Object> myFollowings = new HashMap<>();
	        myFollowings.put("myFollowing", myFollowing);
	        myFollowings.put("followerCounts", followerCounts);
	        myFollowings.put("followerProject", followerProject);

			return myFollowings; 
		}
		return null;
    }
 
	
    
    //이미 팔로우시 취소
    @PostMapping("/unFollow")
    @ResponseBody
    public int unfollow(int followerSeq, HttpSession session) {
			
		int followingMemberSeq = (int) session.getAttribute("login_user_seq"); //로그인본인seq
		int followerMemberSeq = followerSeq; //팔로워의seq
		  
		int unfollow = followservice.unfollow(followingMemberSeq,followerMemberSeq); // 1-> delete됨 		 
		return unfollow;
	}    
    
}
