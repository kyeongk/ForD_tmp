package org.kimyk.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.kimyk.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomUser extends User{
	private static final long serialVersionUTD=SpringSecurityCoreVersion.SERIAL_VERSION_UID;


	
	private MemberVO member;
	
	/*private String uname;
	private String userEmail;
	private boolean enabled;
	
	private Date regDate;
	private Date updateDate;
	
	private AuthVO authvo;*/
	
	public CustomUser(String username, String password,Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	public CustomUser(MemberVO vo) {
		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream().map(auth->new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.member=vo;
	}

}
