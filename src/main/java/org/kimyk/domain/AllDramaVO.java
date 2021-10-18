package org.kimyk.domain;


import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AllDramaVO {
	private Long id;
	private String title;
	private String broadcastingName;
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date startDate;
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date endDate;
	private String state;
	private String posterUrl;
	private double avgScore;
	private int totalEpisode;
	private int viewCount;
	private String userid;
	private List<BoardAttachVO> attachList;
	
	private WatchingDramaVO watchingDramaVO;

	private String dayOfWeek;

}
