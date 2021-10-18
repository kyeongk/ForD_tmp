package org.kimyk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.WishesDramaVO;

public interface WishesDramaMapper {
	public List<WishesDramaVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public void insert(WishesDramaVO wishesDrama);
	public void insertSelectKey(WishesDramaVO wishesDrama);
	public int checkAllDramaId(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public WishesDramaVO detail(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int remove(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int checkWishesTable(@Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);

}
