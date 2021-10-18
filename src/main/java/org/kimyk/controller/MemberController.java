package org.kimyk.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.kimyk.domain.AuthVO;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.MemberVO;
import org.kimyk.domain.PageDTO;
import org.kimyk.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;

@Controller

@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	@Autowired
	private PasswordEncoder pwdEncoder;
	//회원가입창으로 이동
	@GetMapping("/signUp")
	public void signUp() {
		
	}
	
	//회원가입처리
	@PostMapping("/signUp")
	public String signUp(MemberVO member, RedirectAttributes rttr) {
		if(service.idDupliChk(member)==0&&service.emailDupliChk(member)==0) {
			service.signUp(member);
			rttr.addFlashAttribute("result", member.getUserid());
		}else {
			rttr.addFlashAttribute("result", "아이디와 이메일 중복확인을 해주세요");
			return "/member/signUp";
		}
		return "redirect:/customLogin";
	}
	
	//회원목록보기(관리자만 가능)
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/memberList")
	public void list(Criteria cri, Model model) {
		model.addAttribute("list", service.getMemberList(cri));
		int total=service.getTotalMember(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	
	//회원정보보기(관리자와 로그인한 본인만 가능)
	@PostMapping("/myInfo")
	@PreAuthorize("principal.username==#userid || hasRole('ROLE_ADMIN')")
	public void detail(@RequestParam("userid") String userid, Model model) {
		model.addAttribute("member", service.read(userid));
	}
	//아이디, 이메일 중복체크
	@ResponseBody
	@PostMapping("/idDupliChk")
	public int idDupliChk(MemberVO member) {
		return service.idDupliChk(member);
	}
	@ResponseBody
	@PostMapping("/emailDupliChk")
	public int emailDupliChk(MemberVO member) {
		return service.emailDupliChk(member);
	}
	//회원탈퇴시 비밀번호 확인
	@ResponseBody
	@PostMapping("/checkPwRemoveMember")
	@PreAuthorize("principal.username==#request.getUserPrincipal().getName()")
	public String checkPwRemoveMember(@RequestBody String paramData,HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		
		String inputPw=paramData.trim();
		String id=principal.getName();
		String encodedPw=service.checkPw(id);
		return String.valueOf(pwdEncoder.matches(inputPw,encodedPw));
	}
	
	//사용자가 회원정보 수정함
	@PostMapping("/modifyByUser")
	@PreAuthorize("principal.username==#member.userid")
	public String modifyByUser(MemberVO member/*, RedirectAttributes rttr*/,Model model) {
		service.modifyByUser(member);
		model.addAttribute("modifyResult", "success");
		return "forward:/member/myInfo";
	}
	@PostMapping("/modifyPwByUser")
	@PreAuthorize("principal.username==#member.userid")
	public String modifyPwByUser(MemberVO member/*, RedirectAttributes rttr*/,Model model) {
		service.modifyPwByUser(member);
		model.addAttribute("modifyResult", "success");
		return "forward:/member/myInfo";
	}
	//사용자의 회원탈퇴
	@PostMapping("/removeByUser")
	@PreAuthorize("principal.username==#member.userid")
	public String removeByUser(MemberVO member,RedirectAttributes rttr) {
		if(service.removeByUser(member)) {
			SecurityContextHolder.clearContext();
		}
		return "redirect:/";
	}
	//회원등급수정
	/*@PostMapping("/modify")
	public String modify(String auth, @RequestParam(value="userid") List<String> useridParams, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr ) {
		log.info("왜 안되니"+auth);
		ArrayList<AuthVO> useridList=new ArrayList<AuthVO>();
		for(String params:useridParams) {
			log.info("파람"+params);
			AuthVO authVO=new AuthVO(params, auth);
			log.info("1번째리스트:"+authVO.getUserid());
			useridList.add(authVO);
		}
		service.modify(useridList);
		log.info("왜 안되니2"+auth);
		return "redirect:/member/memberList"+cri.getListLink();
	}*/
	
	//회원등급수정(여러건)
	@PostMapping("/modify")
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(HttpServletRequest request, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr ) throws Exception{
		try {
			String[] ajaxMsg=request.getParameterValues("useridArr");
			//String auth=request.getParameter("auth");
			String authParam=request.getParameter("auth");
			
			
			for(int i=0;i<ajaxMsg.length;i++) {
				String userid=ajaxMsg[i];
				
				AuthVO auth=new AuthVO();
				auth.setAuth(authParam);
				auth.setUserid(userid);
				//service.modify(auth, userid);
				service.modify(auth);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		rttr.addFlashAttribute("criLink", cri.getListLink());
		return "redirect:/member/memberList";
	}
	
	//회원삭제(한건)
	/*@PostMapping("/remove")
	public String remove(@RequestParam("userid") String userid, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		service.remove(userid);
		return "redirect:/member/memberList"+cri.getListLink();
	}*/
	
	//회원삭제(여러건,관리자용)
	@PostMapping("/remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(HttpServletRequest request, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		String[] ajaxMsg=request.getParameterValues("useridArr");
		
		for(int i=0;i<ajaxMsg.length;i++) {
			String userid=ajaxMsg[i];
			
			service.delete(userid);
		}
		rttr.addFlashAttribute("criLink", cri.getListLink());
		return "redirect:/member/memberList"+cri.getListLink();
	}
	

}
