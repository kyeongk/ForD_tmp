package org.kimyk.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WishesDramaVO {
	private Long id;
	private Long all_drama_id;
	private Date wishesRegDate;
	private AllDramaVO allDramaVO;
	private String userid;

}
