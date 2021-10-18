package org.kimyk.mapper;

import java.util.List;

import org.kimyk.domain.BoardAttachVO;

public interface BoardAttachMapper {
	public void insert(BoardAttachVO vo);
	public void delete(String uuid);
	public List<BoardAttachVO> findByBno(Long bno);
	public List<BoardAttachVO> findByDno(Long dno);
	public List<BoardAttachVO> findById(Long all_drama_id);
	//public void deleteAll(Long bno);
	public void deleteAll(Long all_drama_id);
	public List<BoardAttachVO> getOldFiles();
	//public BoardAttachVO findImgPath(Long dno);
	
	public void insertAdmin(BoardAttachVO vo);
	public List<BoardAttachVO> findByAdminId(Long adminId);
	public void deleteAllAdmin(Long adminId);

}
