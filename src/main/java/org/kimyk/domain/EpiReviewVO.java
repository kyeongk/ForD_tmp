package org.kimyk.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EpiReviewVO {
	private Long id;
	private Long watched_drama_id;
	private Long all_drama_id;
	private float score;
	private String epiReview;
	private int epiNumber;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date watchedDate;
	private Date regDate;
	private Date modifyDate;
	private String viewState;
	private String userid;
	

}
