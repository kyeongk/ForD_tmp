package org.kimyk.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AdminBoardVO {
	private Long id;
	private String subject;
	private String content;
	private String category;
	private String imgUrl;
	private Date regDate;
	private String userid;
	private List<BoardAttachVO> attachList;

}
