package org.kimyk.service;


import java.util.List;

import org.kimyk.domain.Criteria;
import org.kimyk.domain.EpiReviewPageDTO;
import org.kimyk.domain.EpiReviewVO;
import org.kimyk.mapper.EpiReviewMapper;
import org.kimyk.mapper.WatchedDramaMapper;
import org.kimyk.mapper.WatchingDramaMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;


@Service
@AllArgsConstructor
public class EpiReviewServiceImpl implements EpiReviewService{
	@Setter(onMethod_ = @Autowired)
	private EpiReviewMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private WatchedDramaMapper watchedDramaMapper;
	
	@Setter(onMethod_ = @Autowired)
	private WatchingDramaMapper watchingDramaMapper;
	
	
	@Override
	public List<EpiReviewVO> getList(Criteria cri, Long all_drama_id,String userid){
		return mapper.getList(cri, all_drama_id,userid);
	}
	@Transactional
	@Override
	public EpiReviewPageDTO getListPage(Criteria cri, Long all_drama_id, String userid) {
		return new EpiReviewPageDTO(
				mapper.getTotalCount(all_drama_id,userid),
				mapper.getList(cri, all_drama_id,userid));
	}
	
	@Transactional
	@Override
	public int insert(EpiReviewVO epiReview) {
		String epiReviewText=epiReview.getEpiReview();
		epiReviewText = epiReviewText.replace("\r\n","<br>");
		epiReview.setEpiReview(epiReviewText);
		int insertResult=mapper.insert(epiReview);
		watchingDramaMapper.modifyWatchedEpiNumber(epiReview.getAll_drama_id(),epiReview.getUserid());
		return insertResult;
	}
	
	@Override
	public int modifyScore(EpiReviewVO epiReview) {
		return mapper.modifyScore(epiReview);
	}
	
	@Override
	public int modify(EpiReviewVO epiReview) {
		String epiReviewText=epiReview.getEpiReview();
		epiReviewText = epiReviewText.replace("\r\n","<br>");
		epiReview.setEpiReview(epiReviewText);
		return mapper.modify(epiReview);
	}
	
	@Override
	public EpiReviewVO detail(Long id) {
		return mapper.detail(id);
	}
	
	@Transactional
	@Override
	public int remove(Long id) {
		EpiReviewVO vo=mapper.detail(id);
		int removeResult=mapper.remove(id);
		watchingDramaMapper.modifyWatchedEpiNumber(vo.getAll_drama_id(), vo.getUserid());
		watchingDramaMapper.modifyWatchedEpiNumberByViewState(vo.getAll_drama_id(), vo.getUserid());
		return removeResult;
	}
	@Transactional
	@Override
	public int removeAll(Long all_drama_id, String userid) {
		int amount=mapper.getTotalCount(all_drama_id, userid);
		int removeAllResult=mapper.removeAll(all_drama_id, userid);
		if (amount!=0) {
			watchingDramaMapper.modifyWatchedEpiNumber(all_drama_id, userid);
			watchingDramaMapper.modifyWatchedEpiNumberByViewState(all_drama_id, userid);
		}
		return removeAllResult;
	}
	@Transactional
	@Override
	public int modifyViewState(EpiReviewVO epiReview) {
		int modiftViewStateResult=mapper.modifyViewState(epiReview);
		watchingDramaMapper.modifyWatchedEpiNumberByViewState(epiReview.getAll_drama_id(), epiReview.getUserid());
		
		return modiftViewStateResult;
	}
	@Override
	public int modifyViewStateAll(EpiReviewVO epiReview) {
		int modifyViewStateAllResult=mapper.modifyViewStateAll(epiReview);
		watchingDramaMapper.modifyWatchedEpiNumberByViewState(epiReview.getAll_drama_id(), epiReview.getUserid());
		return modifyViewStateAllResult;
	}
	
	
	
	
	
}
