package org.kimyk.service;

import java.util.List;

import org.kimyk.domain.Criteria;
import org.kimyk.domain.WatchedDramaVO;
import org.kimyk.mapper.AllDramaMapper;
import org.kimyk.mapper.WatchedDramaMapper;
import org.kimyk.mapper.WatchingDramaMapper;
import org.kimyk.mapper.WishesDramaMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
@AllArgsConstructor
public class WatchedDramaServiceImpl implements WatchedDramaService{
	@Setter(onMethod_=@Autowired)
	private WatchedDramaMapper watchedMapper;
	@Setter(onMethod_=@Autowired)
	private WatchingDramaMapper watchingMapper;
	@Setter(onMethod_=@Autowired)
	private WishesDramaMapper wishesMapper;
	@Setter(onMethod_=@Autowired)
	private AllDramaMapper allDramaMapper;
	
	@Override
	public List<WatchedDramaVO> getList(Criteria cri){
		return watchedMapper.getList(cri);
	}
	
	@Override
	public int getTotalCount(Criteria cri) {
		return watchedMapper.getTotalCount(cri);
	}
	
	@Transactional
	@Override
	public void insert(WatchedDramaVO watchedDrama) {
		String totalReview=watchedDrama.getTotalReview();
		if(totalReview!=null) {
			//감상평에 있는 엔터공백을 <br>태그로 변경
			totalReview = totalReview.replace("\r\n","<br>");
			watchedDrama.setTotalReview(totalReview);
		}
		
		//각 게시판에 들어있는 드라마인지 확인(들어있으면 1,없으면 0)
		int watched=watchedMapper.checkWatchedTable(watchedDrama.getAll_drama_id(),watchedDrama.getUserid());
		int watching=watchingMapper.checkWatchingTable(watchedDrama.getAll_drama_id(),watchedDrama.getUserid());
		int wishes=wishesMapper.checkWishesTable(watchedDrama.getAll_drama_id(),watchedDrama.getUserid());
		
		if(watched==1&&watching==0&&wishes==0) {							   //시청완료에만 들어있는 드라마이면
			watchedMapper.modifyScore(watchedDrama); 										   //점수 수정
		}else if(watched==0&&watching==1&&wishes==0) {							//시청중에만 들어있는 드라마이면
			watchingMapper.remove(watchedDrama.getAll_drama_id(),watchedDrama.getUserid());//시청중에서 삭제
			watchedMapper.insertSelectKey(watchedDrama);								 //시청완료에 인서트
		}else if(watched==0&&watching==0&&wishes==1) {						   //시청예정에만 들어있는 드라마이면
			wishesMapper.remove(watchedDrama.getAll_drama_id(),watchedDrama.getUserid());//시청예정에서 삭제
			watchedMapper.insertSelectKey(watchedDrama);								  //시청완료로 인서트
		}else if(watched==1&&watching==1&&wishes==0) {					   //시청완료와 시청중에 들어있는 드라마이면
			watchedMapper.modifyScore(watchedDrama);											//점수수정
		}else if(watched==1&&watching==0&&wishes==1) {					  //시청완료와 시청예정에 들어있는 드라마이면
			watchedMapper.modifyScore(watchedDrama);											//점수수정
		}else if(watched==0&&watching==0&&wishes==0) {										//어느곳에도 없으면
			watchedMapper.insertSelectKey(watchedDrama);									//시청완료로 인서트
		}else {
			log.info("watchedDramaService에서 오류남");
		}
	}
	
	@Override
	public WatchedDramaVO detail(Long all_drama_id,String userid) {
		return watchedMapper.detail(all_drama_id,userid);
	}
	
	@Override
	public boolean remove(Long all_drama_id,String userid) {
		return watchedMapper.remove(all_drama_id,userid)==1;
	}
	
	@Override
	public boolean modify(WatchedDramaVO watchedDrama) {
		String totalReview=watchedDrama.getTotalReview();
		if(totalReview!=null) {
			totalReview = totalReview.replace("\r\n","<br>");
			watchedDrama.setTotalReview(totalReview);
		}
		return watchedMapper.modify(watchedDrama)==1;
	}
	
	@Override
	public int checkWatchedTable(Long all_drama_id,String userid) {
		
		return watchedMapper.checkWatchedTable(all_drama_id,userid);
	}
	
	@Override
	public boolean modifyAvgScore(Long id) {
		return allDramaMapper.modifyAvgScore(id)==1;
	}
	
	@Override
	public boolean modifyViewCount(Long id) {
		return allDramaMapper.modifyViewCount(id)==1;
	}
}
