package org.kimyk.service;

import java.util.List;

import org.kimyk.domain.AdminBoardVO;
import org.kimyk.domain.BoardAttachVO;
import org.kimyk.domain.Criteria;

public interface AdminBoardService {
	public List<AdminBoardVO> getNoticeList(Criteria cri);
	public int getNoticeTotalCount(Criteria cri);
	public List<AdminBoardVO> getFAQList(Criteria cri);
	public int getFAQTotalCount(Criteria cri);
	public void insert(AdminBoardVO adminBoard);
	public AdminBoardVO detail(Long id);
	public boolean modify(AdminBoardVO adminBoard);
	public boolean remove(Long id);
	public List<BoardAttachVO> getAttachList(Long id);

}
