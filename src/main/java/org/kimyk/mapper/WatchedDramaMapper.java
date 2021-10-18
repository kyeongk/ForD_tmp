package org.kimyk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.WatchedDramaVO;

public interface WatchedDramaMapper {
	public List<WatchedDramaVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public void insert(WatchedDramaVO watchedDrama);
	public void insertSelectKey(WatchedDramaVO watchedDrama);
	public int checkAllDramaId(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int modifyScore(WatchedDramaVO watchedDrama);
	public WatchedDramaVO detail(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int remove(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int modify(WatchedDramaVO watchedDrama);
	public int checkWatchedTable(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);

}
