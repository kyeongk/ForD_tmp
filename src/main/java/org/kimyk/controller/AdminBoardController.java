package org.kimyk.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.kimyk.domain.AdminBoardVO;
import org.kimyk.domain.BoardAttachVO;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.PageDTO;
import org.kimyk.service.AdminBoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@AllArgsConstructor
public class AdminBoardController {
	private AdminBoardService service;
	
	@GetMapping(value="/notice")
	public void noticeList(Criteria cri,Model model) {
		int total=service.getNoticeTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("list", service.getNoticeList(cri));
	}
	
	@GetMapping(value="/FAQ")
	public void faqList(Criteria cri,Model model) {
		int total=service.getFAQTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("list", service.getFAQList(cri));
	}
	
	@GetMapping("/adminBoardRegister")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void insert() {
		
	}
	
	@PostMapping("/adminBoardRegister")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String insert(AdminBoardVO adminBoard, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if(adminBoard.getAttachList()!=null) {
			adminBoard.getAttachList().forEach(attach->log.info(attach));
		}
		service.insert(adminBoard);
		if(adminBoard.getCategory().equals("FAQ")) {
			return "redirect:/FAQ";
		}else {
			return "redirect:/notice";
		}
	}
	
	@GetMapping("/adminBoardModify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void detail(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.detail(id));
	}
	
	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long adminId){
		
		return new ResponseEntity<>(service.getAttachList(adminId),HttpStatus.OK);
	}
	
	@PostMapping("/adminBoardModify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(AdminBoardVO adminBoard, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if(service.modify(adminBoard)) {
			rttr.addFlashAttribute("result", "success");
		}
		if(adminBoard.getCategory().equals("FAQ")) {
			return "redirect:/FAQ";
		}else {
			return "redirect:/notice";
		}
	}
	
	@PostMapping("/adminBoardRemove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		List<BoardAttachVO> attachList=service.getAttachList(id);
		if(service.remove(id)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/notice";
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList==null||attachList.size()==0) {
			return;
		}
		attachList.forEach(attach->{
			try {
				Path file=Paths.get("D:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbnail=Paths.get("D:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbnail);
				}
			}catch(Exception e) {
				log.error("첨부파일 삭제 실패"+e.getMessage());
				
			}
		});
	}

}
