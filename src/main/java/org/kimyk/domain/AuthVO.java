package org.kimyk.domain;

import java.util.List;

import lombok.Data;

@Data
public class AuthVO {
	private String userid;
	private String auth;
	private List<AuthVO> authlist;
	
	public AuthVO() {
		
	}
	public AuthVO(String auth,String userid) {
		this.auth=auth;
		this.userid=userid;
	}
	


}
