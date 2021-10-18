package org.kimyk.service;


import java.util.List;

import org.kimyk.domain.AuthVO;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.MemberVO;
import org.kimyk.mapper.MemberAuthMapper;
import org.kimyk.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;


@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	
	@Setter(onMethod_ = {@Autowired})
	private MemberAuthMapper authMapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	//회원가입
	@Transactional
	@Override
	public void signUp(MemberVO member) {
		if(mapper.idDupliChk(member)==0&&mapper.emailDupliChk(member)==0) {
			String encPw=pwencoder.encode(member.getUserpw());
			member.setUserpw(encPw);
			mapper.signUp(member);
			AuthVO auth=new AuthVO();
			auth.setUserid(member.getUserid());
			auth.setAuth("ROLE_USER");
			authMapper.signUp(auth);
		}
	}
	//회원 목록(페이징 있음)
	@Override
	public List<MemberVO> getMemberList(Criteria cri){
		return mapper.getMemberList(cri);
	}
	//전체게시물 수 구하기
	@Override
	public int getTotalMember(Criteria cri) {
		return mapper.getTotalMember(cri);
	}
	//회원정보보기
	@Override
	public MemberVO read(String userid) {
		return mapper.read(userid);
	}
	//아이디, 이메일 중복 확인
	@Override
	public int idDupliChk(MemberVO member) {
		return mapper.idDupliChk(member);
	}
	@Override
	public int emailDupliChk(MemberVO member) {
		return mapper.emailDupliChk(member);
	}
	//회원탈퇴시 비밀번호 확인
	@Override
	public String checkPw(String userid) {
		return mapper.checkPw(userid);
	}
	//사용자의 회원수정
	@Override
	public boolean modifyByUser(MemberVO member) {
		String encPw=pwencoder.encode(member.getUserpw());
		member.setUserpw(encPw);
		return mapper.modifyByUser(member)==1;
	}
	@Override
	public boolean modifyPwByUser(MemberVO member) {
		String encPw=pwencoder.encode(member.getUserpw());
		member.setUserpw(encPw);
		return mapper.modifyPwByUser(member)==1;
	}
	//사용자의 회원탈퇴
	@Override
	public boolean removeByUser(MemberVO member) {
		return mapper.removeByUser(member)==1;
	}
	
	//회원수정(한개의 값)
	/*@Transactional
	@Override
	public boolean modify(AuthVO auth) {
		log.info("수정좀돼라"+auth);
		boolean modifyResult=authMapper.updateMember(auth)==1;
		auth.getAuthlist().forEach(action->{
			action.setUserid(auth.getUserid());
			action.setAuth(auth.getAuth());
			authMapper.updateMember(action);
		});
		log.info("수정좀돼라2"+auth);
		return modifyResult;
	}*/
	
	//회원수정(여러개의 값)
		/*@Transactional
		@Override
		public void modify(ArrayList<AuthVO> useridList) {
			log.info("수정좀돼라"+useridList);
			for(AuthVO auth:useridList) {
				authMapper.updateMember(useridList);
			}
			
			auth.getAuthlist().forEach(action->{
				action.setUserid(auth.getUserid());
				action.setAuth(auth.getAuth());
				authMapper.updateMember(action);
			});
			log.info("수정좀돼라2"+useridList);
			
		}*/
	
	@Transactional
	@Override
	public void modify(String auth,String userid) {
		
		authMapper.modify(auth, userid);
		
	}
	
	@Transactional
	@Override
	public void modify(AuthVO auth) {
		
		authMapper.modify(auth);
		
	}
	
	//회원삭제(한건)
	/*@Transactional
	@Override
	public boolean remove(String userid) {
		log.info("remove......."+userid);
		return mapper.delete(userid)==1;
	}*/
	//회원삭제
	@Transactional
	@Override
	public void delete(String userid) {
		MemberVO vo=mapper.read(userid);
		if(mapper.checkPw(userid).equals(vo.getUserpw())) {
			mapper.remove(userid);
		}
		
		
	}

}
