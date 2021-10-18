package org.kimyk.service;

import java.util.List;

import org.kimyk.domain.Criteria;
import org.kimyk.domain.WatchedDramaVO;

public interface WatchedDramaService {
	public List<WatchedDramaVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public void insert(WatchedDramaVO watchedDrama);
	public WatchedDramaVO detail(Long all_drama_id,String userid);
	public boolean remove(Long all_drama_id,String userid);
	public boolean modify(WatchedDramaVO watchedDrama);
	public int checkWatchedTable(Long all_drama_id,String userid);
	public boolean modifyAvgScore(Long id);
	public boolean modifyViewCount(Long id);

}
