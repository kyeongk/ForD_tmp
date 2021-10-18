package org.kimyk.service;

import java.util.List;

import org.kimyk.domain.AdminBoardVO;
import org.kimyk.domain.BoardAttachVO;
import org.kimyk.domain.Criteria;
import org.kimyk.mapper.AdminBoardMapper;
import org.kimyk.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class AdminBoardServiceImpl implements AdminBoardService{
	@Setter(onMethod_=@Autowired)
	private AdminBoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Override
	public List<AdminBoardVO> getNoticeList(Criteria cri){
		return mapper.getNoticeList(cri);
	}
	
	@Override
	public int getNoticeTotalCount(Criteria cri) {
		return mapper.getNoticeTotalCount(cri);
	}
	
	@Override
	public List<AdminBoardVO> getFAQList(Criteria cri){
		return mapper.getFAQList(cri);
	}
	
	@Override
	public int getFAQTotalCount(Criteria cri) {
		return mapper.getFAQTotalCount(cri);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(Long adminId){
		return attachMapper.findByAdminId(adminId);
	}
	
	@Transactional
	@Override
	public void insert(AdminBoardVO adminBoard) {
		String content=adminBoard.getContent();
		content = content.replace("\r\n","<br>");
		adminBoard.setContent(content);
		mapper.insertSelectKey(adminBoard);
		if(adminBoard.getAttachList()==null||adminBoard.getAttachList().size()<=0) {
			return;
		}
		adminBoard.getAttachList().forEach(attach->{
			attach.setAdminId(adminBoard.getId());
			attachMapper.insertAdmin(attach);
		});
	}
	
	@Override
	public AdminBoardVO detail(Long id) {
		return mapper.detail(id);
	}
	
	@Transactional
	@Override
	public boolean modify(AdminBoardVO adminBoard) {
		String content=adminBoard.getContent();
		content = content.replace("\r\n","<br>");
		adminBoard.setContent(content);
		attachMapper.deleteAllAdmin(adminBoard.getId());
		boolean modifyResult=mapper.modify(adminBoard)==1;
		if(modifyResult&&adminBoard.getAttachList()!=null&&adminBoard.getAttachList().size()>0) {
			adminBoard.getAttachList().forEach(attach->{
				attach.setAdminId(adminBoard.getId());
				attachMapper.insertAdmin(attach);
			});
		}
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Long id) {
		attachMapper.deleteAllAdmin(id);
		return mapper.remove(id)==1;
	}
	

}
