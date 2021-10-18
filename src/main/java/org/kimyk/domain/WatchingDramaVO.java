package org.kimyk.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WatchingDramaVO {
	private Long id;
	private Long all_drama_id;
	private int watchedEpiNumber;
	private int replayCount;
	private Date watchingRegDate;
	private String userid;
	private AllDramaVO allDramaVO;

}
