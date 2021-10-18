package org.kimyk.service;

import java.util.List;

import org.kimyk.domain.AuthVO;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.MemberVO;

public interface MemberService {
	//회원가입을 위한 추상메서드
	public void signUp(MemberVO member);
	//회원 목록(페이징 있음)
	public List<MemberVO> getMemberList(Criteria cri);
	//전체게시물 수 구하기
	public int getTotalMember(Criteria cri);
	//아이디,이메일 중복확인
	public int idDupliChk(MemberVO member);
	public int emailDupliChk(MemberVO member);
	public String checkPw(String userid);
	//사용자의 회원수정
	public boolean modifyByUser(MemberVO member);
	public boolean modifyPwByUser(MemberVO member);
	//사용자의 회원탈퇴
	public boolean removeByUser(MemberVO member);
	//회원수정(한개의값)
	//public boolean modify(AuthVO auth);
	//회원수정 (여러개의 값)
	//public void modify(ArrayList<AuthVO> useridList);
	public void modify(String auth,String userid);
	public void modify(AuthVO auth);
	//회원삭제
	//public boolean remove(String userid);
	//회원삭제(여러건)
	public void delete(String userid);
	
	//회원정보보기
	public MemberVO read(String userid);

}
