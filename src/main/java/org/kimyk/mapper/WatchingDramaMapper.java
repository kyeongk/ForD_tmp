package org.kimyk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.WatchingDramaVO;

public interface WatchingDramaMapper {
	public List<WatchingDramaVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public void insert(WatchingDramaVO watchingDrama);
	public void insertSelectKey(WatchingDramaVO watchingDrama);
	public int checkAllDramaId(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public WatchingDramaVO detail(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int remove(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int checkWatchingTable(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	
	public int modifyWatchedEpiNumber(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int modifyWatchedEpiNumberByViewState(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	
	//public List<WatchingDramaVO> getWatchingList(String userid);

}
