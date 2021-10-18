package org.kimyk.service;

import java.util.List;

import org.kimyk.domain.Criteria;
import org.kimyk.domain.WishesDramaVO;

public interface WishesDramaService {
	public List<WishesDramaVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public void insert(WishesDramaVO wishesDrama);
	public WishesDramaVO detail(Long all_drama_id,String userid);
	public boolean remove(Long all_drama_id,String userid);
	public int checkWishesTable(Long all_drama_id,String userid);

}
