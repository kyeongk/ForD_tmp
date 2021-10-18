package org.kimyk.security;

import org.kimyk.domain.MemberVO;
import org.kimyk.mapper.MemberMapper;
import org.kimyk.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
public class CustomUserDetailsService implements UserDetailsService{
	@Setter(onMethod_= {@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException{
		log.warn("Load User By UserName: "+userName);
		//userName means userid
		MemberVO vo=memberMapper.read(userName);
		log.warn("queried by member mapper: "+vo);
		
		return vo==null?null:new CustomUser(vo);
	}

}
