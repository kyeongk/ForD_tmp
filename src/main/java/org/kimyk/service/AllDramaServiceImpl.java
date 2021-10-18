package org.kimyk.service;


import java.util.Calendar;
import java.util.List;

import org.kimyk.domain.AllDramaVO;
import org.kimyk.domain.BoardAttachVO;
import org.kimyk.domain.Criteria;
import org.kimyk.mapper.AllDramaMapper;
import org.kimyk.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;


@Service
@AllArgsConstructor
public class AllDramaServiceImpl implements AllDramaService{
	@Setter(onMethod_=@Autowired)
	private AllDramaMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	
	@Override
	public List<AllDramaVO> getSearchList(Criteria cri){
		return mapper.getSearchList(cri);
	}
	
	
	
	
	@Override
	public List<AllDramaVO> getList(Criteria cri){
		return mapper.getList(cri);
	}
	@Override
	public int getTotalCount(Criteria cri) {
		if(mapper.getTotalCount(cri)>0) {
		}else {
		}
		return mapper.getTotalCount(cri);
	}
	
	
	
	
	
	@Override
	public List<AllDramaVO> getListByUserid(Criteria cri,String userid){
		return mapper.getListByUserid(cri,userid);
	}
	@Override
	public int getTotalCountByUserid(Criteria cri,String userid) {
		if(mapper.getTotalCountByUserid(cri,userid)>0) {
		}else {
		}
		return mapper.getTotalCountByUserid(cri,userid);
	}
	
	
	
	
	
	
	@Transactional
	@Override
	public void insert(AllDramaVO allDrama) {
		if(mapper.checkAllDramaList(allDrama)==0) {
			mapper.insertSelectKey(allDrama);
			if(allDrama.getAttachList()==null||allDrama.getAttachList().size()<=0) {
				return;
			}
			allDrama.getAttachList().forEach(attach->{
				attach.setId(allDrama.getId());
				attachMapper.insert(attach);
			});
		}
	}
	
	@Override
	public AllDramaVO detail(Long id) {
		return mapper.detail(id);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(Long id){
		return attachMapper.findById(id);
	}
	
	@Transactional
	@Override
	public boolean modify (AllDramaVO allDrama) {
		attachMapper.deleteAll(allDrama.getId());
		boolean modifyResult=mapper.modify(allDrama)==1;
		if(modifyResult&&allDrama.getAttachList()!=null&&allDrama.getAttachList().size()>0) {
			allDrama.getAttachList().forEach(attach->{
				attach.setId(allDrama.getId());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Long id) {
		attachMapper.deleteAll(id);
		return mapper.remove(id)==1;
	}
	
	@Transactional
	@Override
	public boolean removeAll(Long id) {
		attachMapper.deleteAll(id);
		return mapper.remove(id)==1;
	}
	@Override
	public int checkAllDramaList(AllDramaVO allDrama) {
		return mapper.checkAllDramaList(allDrama);
	}
	
	@Override
	public List<AllDramaVO> getOnAirList(String dayOfWeek){
		return mapper.getOnAirList(dayOfWeek);
	}
	@Override
	public List<AllDramaVO> getExpectedList(){
		return mapper.getExpectedList();
	}
	@Override
	public List<AllDramaVO> getWatchingList(String userid){
		return mapper.getWatchingList(userid);
	}
	@Override
	public List<AllDramaVO> getWatchingList(){
		return mapper.getWatchingList();
	}
	
	@Override
	public String getTodayOfWeek() {
		Calendar cal=Calendar.getInstance();
		int today=cal.get(Calendar.DAY_OF_WEEK);
		String todayOfWeek="";
		switch(today) {
		case 1:
			todayOfWeek="sun";
			break;
		case 2:
			todayOfWeek="mon";
			break;
		case 3:
			todayOfWeek="tue";
			break;
		case 4:
			todayOfWeek="wed";
			break;
		case 5:
			todayOfWeek="thu";
			break;
		case 6:
			todayOfWeek="fri";
			break;
		case 7:
			todayOfWeek="sat";
			break;
		}
		
		return todayOfWeek;
	}


}
