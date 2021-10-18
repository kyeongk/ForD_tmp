package org.kimyk.service;


import java.util.List;

import org.kimyk.domain.Criteria;
import org.kimyk.domain.WishesDramaVO;
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
public class WishesDramaServiceImpl implements WishesDramaService{
	@Setter(onMethod_=@Autowired)
	private WatchedDramaMapper watchedMapper;
	@Setter(onMethod_=@Autowired)
	private WatchingDramaMapper watchingMapper;
	@Setter(onMethod_=@Autowired)
	private WishesDramaMapper wishesMapper;
	
	@Override
	public List<WishesDramaVO> getList(Criteria cri){
		return wishesMapper.getList(cri);
	}
	
	@Override
	public int getTotalCount(Criteria cri) {
		return wishesMapper.getTotalCount(cri);
	}
	
	@Transactional
	@Override
	public void insert(WishesDramaVO wishesDrama) {
		int watched=watchedMapper.checkWatchedTable(wishesDrama.getAll_drama_id(),wishesDrama.getUserid());
		int watching=watchingMapper.checkWatchingTable(wishesDrama.getAll_drama_id(),wishesDrama.getUserid());
		int wishes=wishesMapper.checkWishesTable(wishesDrama.getAll_drama_id(),wishesDrama.getUserid());
		
		if(watched==1&&watching==0&&wishes==0) {//시청완료에만 들어있는 드라마이면
			wishesMapper.insertSelectKey(wishesDrama);//시청예정으로 인서트
		}else if(watched==0&&watching==1&&wishes==0) {//시청중에만 들어있는 드라마이면
			watchingMapper.remove(wishesDrama.getAll_drama_id(),wishesDrama.getUserid());//시청중에서 삭제
			wishesMapper.insertSelectKey(wishesDrama);//시청예정으로 인서트
		}else if(watched==0&&watching==0&&wishes==1) {//시청예정에만 들어있는 드라마이면
			wishesMapper.remove(wishesDrama.getAll_drama_id(),wishesDrama.getUserid());//시청예정에서 삭제
		}else if(watched==1&&watching==1&&wishes==0) {//시청완료와 시청중에 들어있는 드라마이면
			watchingMapper.remove(wishesDrama.getAll_drama_id(),wishesDrama.getUserid());//시청중에서 삭제
			wishesMapper.insertSelectKey(wishesDrama);//시청예정으로 인서트
		}else if(watched==1&&watching==0&&wishes==1) {//시청완료와 시청예정에 들어있는 드라마이면
			wishesMapper.remove(wishesDrama.getAll_drama_id(),wishesDrama.getUserid());//시청예정에서 삭제
		}else if(watched==0&&watching==0&&wishes==0) {//어느곳에도 없으면
			wishesMapper.insertSelectKey(wishesDrama);//시청예정으로 인서트
		}else {
			log.info("wishesDramaService에서 오류남");
		}
	}
	
	@Override
	public WishesDramaVO detail(Long all_drama_id,String userid) {
		return wishesMapper.detail(all_drama_id,userid);
	}
	
	@Override
	public boolean remove(Long all_drama_id,String userid) {
		return wishesMapper.remove(all_drama_id,userid)==1;
	}
	
	@Override
	public int checkWishesTable(Long all_drama_id,String userid) {
		return wishesMapper.checkWishesTable(all_drama_id,userid);
	}


}
