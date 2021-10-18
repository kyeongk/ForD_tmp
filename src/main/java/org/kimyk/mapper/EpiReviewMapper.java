package org.kimyk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.EpiReviewVO;

public interface EpiReviewMapper {
	public List<EpiReviewVO> getList(@Param("cri") Criteria cri, @Param("all_drama_id") Long all_drama_id,@Param("userid") String userid);
	public int getTotalCount(@Param("all_drama_id") Long all_drama_id, @Param("userid") String userid);
	public int insert(EpiReviewVO epiReview);
	public int modifyScore(EpiReviewVO epiReview);
	public int modify(EpiReviewVO epiReview);
	public EpiReviewVO detail(Long id);
	public int remove(Long id);
	public int modifyViewState(EpiReviewVO epiReview);
	public int modifyViewStateAll(EpiReviewVO epiReview);
	public int removeAll(@Param("all_drama_id") Long all_drama_id, @Param("userid") String userid);
	
	public int update(EpiReviewVO epireview);
	

}
