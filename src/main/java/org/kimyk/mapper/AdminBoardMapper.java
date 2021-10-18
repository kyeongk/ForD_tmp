package org.kimyk.mapper;

import java.util.List;

import org.kimyk.domain.AdminBoardVO;
import org.kimyk.domain.Criteria;

public interface AdminBoardMapper {
	public List<AdminBoardVO> getNoticeList(Criteria cri);
	public int getNoticeTotalCount(Criteria cri);
	public List<AdminBoardVO> getFAQList(Criteria cri);
	public int getFAQTotalCount(Criteria cri);
	public void insertSelectKey(AdminBoardVO adminBoard);
	public AdminBoardVO detail(Long id);
	public int modify(AdminBoardVO adminBoard);
	public int remove(Long id);

}
