package org.kimyk.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; //한페이지에 보이는 페이지넘버들의 시작넘버
	private int endPage; //한페이지에 보이는 페이지넘버들의 끝넘버
	private boolean prev, next; //이전 버튼과 다음 버튼 생성 여부
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri=cri;
		this.total=total;
		
		this.endPage=(int) (Math.ceil(cri.getPageNum()/10.0))*10; //Math.ceil - 올림
		this.startPage=this.endPage-9;
		
		int realEnd=(int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		if(realEnd<this.endPage) {//end페이지가 실제 마지막 페이지보다 크면 실제마지막페이지를 end페이지로 만든다.
			this.endPage=realEnd;
		}
		
		this.prev=this.startPage>1; //다음 버튼 생성 여부 판단
		this.next=this.endPage<realEnd; //이전 버튼 생성 여부 판단
	}

}
