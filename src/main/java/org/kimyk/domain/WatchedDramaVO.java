package org.kimyk.domain;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class WatchedDramaVO {
	private Long id;
	private Long all_drama_id;
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date watchedStartDate;
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date watchedEndDate;
	private Date watchedRegDate;
	private double avgScore;
	private String totalReview;
	private Date modifyDate;
	private String userid;
	private List<AllDramaVO> allDramaList;
	private AllDramaVO allDramaVO;
}
