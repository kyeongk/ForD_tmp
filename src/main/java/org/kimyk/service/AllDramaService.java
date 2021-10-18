package org.kimyk.service;

import java.util.List;

import org.kimyk.domain.AllDramaVO;
import org.kimyk.domain.BoardAttachVO;
import org.kimyk.domain.Criteria;

public interface AllDramaService {
	public List<AllDramaVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	
	public List<AllDramaVO> getListByUserid(Criteria cri,String userid);
	public int getTotalCountByUserid(Criteria cri,String userid);
	
	public void insert(AllDramaVO allDrama);
	public AllDramaVO detail(Long id);
	public List<BoardAttachVO> getAttachList(Long id);
	public boolean modify (AllDramaVO allDrama);
	public boolean remove(Long id);
	public boolean removeAll(Long id);
	public int checkAllDramaList(AllDramaVO allDrama);
	public List<AllDramaVO> getSearchList(Criteria cri);
	
	public List<AllDramaVO> getOnAirList(String dayOfWeek);
	public List<AllDramaVO> getExpectedList();
	public List<AllDramaVO> getWatchingList(String userid);
	public List<AllDramaVO> getWatchingList();
	
	//오늘 요일 리턴
	public String getTodayOfWeek();

}
