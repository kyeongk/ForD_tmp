package org.kimyk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kimyk.domain.AllDramaVO;
import org.kimyk.domain.Criteria;

public interface AllDramaMapper {
	public List<AllDramaVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	
	public List<AllDramaVO> getListByUserid(@Param("cri") Criteria cri, @Param("userid") String userid);
	public int getTotalCountByUserid(@Param("cri") Criteria cri, @Param("userid") String userid);
	
	public void insert(AllDramaVO allDrama);
	public void insertSelectKey(AllDramaVO allDrama);
	public AllDramaVO detail(Long id);
	public int modify(AllDramaVO allDrama);
	public int remove(Long id);
	public int checkAllDramaList(AllDramaVO allDrama);
	public List<AllDramaVO> getSearchList(Criteria cri);
	
	public List<AllDramaVO> getOnAirList(String dayOfWeek);
	public List<AllDramaVO> getExpectedList();
	public List<AllDramaVO> getWatchingList(String userid);
	public List<AllDramaVO> getWatchingList();
	
	public int modifyAvgScore(Long id);
	//public int modifyAvgScore(@Param("score") double score, @Param("watchedTotalCount") int watchedTotalCount,@Param("id") Long id );
	public int modifyViewCount(Long id);
	
	public void modifyState();
	
}
