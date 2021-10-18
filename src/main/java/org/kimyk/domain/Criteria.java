package org.kimyk.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	private String order;
	private String userid;
	
	private String state;
	private String title;
	private String dayOfWeek;
	
	public Criteria() {
		this(1,10); //기본 1페이지에 10개 출력(생성자)
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	
	public int getSkipCount() {
		return (this.pageNum-1)*amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String [] {}: type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder=UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
	

}
