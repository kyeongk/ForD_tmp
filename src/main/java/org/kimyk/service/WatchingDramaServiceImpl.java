package org.kimyk.service;

import java.util.List;


import org.kimyk.domain.Criteria;
import org.kimyk.domain.WatchingDramaVO;
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
public class WatchingDramaServiceImpl implements WatchingDramaService{
	@Setter(onMethod_=@Autowired)
	private WatchedDramaMapper watchedMapper;
	@Setter(onMethod_=@Autowired)
	private WatchingDramaMapper watchingMapper;
	@Setter(onMethod_=@Autowired)
	private WishesDramaMapper wishesMapper;
	
	@Override
	public List<WatchingDramaVO> getList(Criteria cri){
		return watchingMapper.getList(cri);
	}
	
	@Override
	public int getTotalCount(Criteria cri) {
		return watchingMapper.getTotalCount(cri);
	}
	
	@Transactional
	@Override
	public void insert(WatchingDramaVO watchingDrama) {
		int watched=watchedMapper.checkWatchedTable(watchingDrama.getAll_drama_id(),watchingDrama.getUserid());
		int watching=watchingMapper.checkWatchingTable(watchingDrama.getAll_drama_id(),watchingDrama.getUserid());
		int wishes=wishesMapper.checkWishesTable(watchingDrama.getAll_drama_id(),watchingDrama.getUserid());
		
		if(watched==1&&watching==0&&wishes==0) {//시청완료에만 들어있는 드라마이면
			watchingMapper.insertSelectKey(watchingDrama);//시청중으로 인서트
		}else if(watched==0&&watching==1&&wishes==0) {//시청중에만 들어있는 드라마이면
			watchingMapper.remove(watchingDrama.getAll_drama_id(),watchingDrama.getUserid());//시청중에서 삭제
		}else if(watched==0&&watching==0&&wishes==1) {//시청예정에만 들어있는 드라마이면
			wishesMapper.remove(watchingDrama.getAll_drama_id(),watchingDrama.getUserid());//시청예정에서 삭제
			watchingMapper.insertSelectKey(watchingDrama);//시청중으로 인서트
		}else if(watched==1&&watching==1&&wishes==0) {//시청완료와 시청중에 들어있는 드라마이면
			watchingMapper.remove(watchingDrama.getAll_drama_id(),watchingDrama.getUserid());//시청중에서 삭제
		}else if(watched==1&&watching==0&&wishes==1) {//시청완료와 시청예정에 들어있는 드라마이면
			wishesMapper.remove(watchingDrama.getAll_drama_id(),watchingDrama.getUserid());//시청예정에서 삭제
			watchingMapper.insertSelectKey(watchingDrama);//시청중으로 인서트
		}else if(watched==0&&watching==0&&wishes==0) {//어느곳에도 없으면
			watchingMapper.insertSelectKey(watchingDrama);//시청중으로 인서트
		}else {
			log.info("watchingDramaService에서 오류남");
		}
		
	}
	
	@Override
	public WatchingDramaVO detail(Long all_drama_id,String userid) {
		return watchingMapper.detail(all_drama_id,userid);
	}
	
	@Override
	public boolean remove(Long all_drama_id,String userid) {
		return watchingMapper.remove(all_drama_id,userid)==1;
	}
	
	@Override
	public int checkWatchingTable(Long all_drama_id,String userid) {
		return watchingMapper.checkWatchingTable(all_drama_id,userid);
	}
	

}
