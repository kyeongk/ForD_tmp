package org.kimyk.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.kimyk.domain.AllDramaVO;
import org.kimyk.domain.BoardAttachVO;
import org.kimyk.domain.Criteria;
import org.kimyk.domain.PageDTO;
import org.kimyk.service.AllDramaService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/record/*")
@AllArgsConstructor
public class AllDramaController {
	private AllDramaService service;
	
	//드라마 리스트
	@GetMapping("/list")
	public void list(Criteria cri, Model model,HttpServletRequest request) {
		cri.setAmount(30);
		int total=0;
		Principal principal = request.getUserPrincipal();
		//로그인 한 경우 watched,watching,wishes에 없는 드라마만 가져옴
		if(request.getUserPrincipal()!=null) {
			String userid=principal.getName();
			total=service.getTotalCountByUserid(cri,userid);
			model.addAttribute("list", service.getListByUserid(cri,userid));
		}else {
			total=service.getTotalCount(cri);
			model.addAttribute("list", service.getList(cri));
		}
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	
	//드라마 전체에서 검색하기
	@GetMapping("/search")
	public void searchList(Criteria cri, Model model) {
		int total=service.getTotalCount(cri);
		cri.setAmount(50);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("list", service.getSearchList(cri));
	}
	
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void insert() {
		
	}
	
	//드라마 등록하기(관리자만 가능)
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String insert(AllDramaVO allDrama, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if(allDrama.getDayOfWeek()!=null) {
			//요일값 받아서 한 문자열로 만들었음
			String[] array=allDrama.getDayOfWeek().split(",");
			String dayOfWeek="";
			for(int i=0;i<array.length;i++) {
				dayOfWeek+=array[i];
			}
			allDrama.setDayOfWeek(dayOfWeek);
		}
		
		if(allDrama.getAttachList()!=null) {
			allDrama.getAttachList().forEach(attach->log.info(attach));
		}
		service.insert(allDrama);
		if(allDrama.getId()==null) {
			rttr.addFlashAttribute("result", "insertFail");
		}else {
			rttr.addFlashAttribute("result", allDrama.getId());
		}
		
		return "redirect:/record/list";
	}
	
	//중복드라마 확인 ajax
	@ResponseBody
	@PostMapping("/dramaDupliChk")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public int dramaDupliChk(AllDramaVO allDrama){
		return service.checkAllDramaList(allDrama);
	}
	
	@GetMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void detail(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.detail(id));
	}
	
	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long id){
		return new ResponseEntity<>(service.getAttachList(id),HttpStatus.OK);
	}
	
	//드라마 수정하기(관리자만 가능)
	@PostMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(AllDramaVO allDrama, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if(allDrama.getDayOfWeek()!=null) {
			//요일값 받아서 한 문자열로 만들었음
			String[] array=allDrama.getDayOfWeek().split(",");
			String dayOfWeek="";
			for(int i=0;i<array.length;i++) {
				dayOfWeek+=array[i];
			}
			allDrama.setDayOfWeek(dayOfWeek);
		}
		
		
		if(service.modify(allDrama)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/record/list"+cri.getListLink();
	}
	
	//드라마 삭제(관리자만 가능)
	@PostMapping("/remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@RequestParam("id") Long id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		List<BoardAttachVO> attachList=service.getAttachList(id);
		if(service.remove(id)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/record/list"+cri.getListLink();
	}
	
	//여러데이터 한번에 삭제(지금 안됨)
	@PostMapping("/removeAll")
	public String removeAll(HttpServletRequest request, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		/*@RequestParam(value="dramaArr[]") Long[] dramaArr,*/
		String[] ajaxMsg=request.getParameterValues("dramaArr");
		for(int i=0;i<ajaxMsg.length;i++) {
			Long id=Long.parseLong(ajaxMsg[i]);
			List<BoardAttachVO> attachList=service.getAttachList(id);
			if(service.removeAll(id)) {
				deleteFiles(attachList);
				rttr.addFlashAttribute("result", "success");
			};
		}
		rttr.addFlashAttribute("criLink", cri.getListLink());
		return "redirect:/record/list"+cri.getListLink();
	} 
	
	//관리자용 드라마 리스트
	@GetMapping("/record/listForAdmin")
	public void listForAdmin(Criteria cri, Model model) {
		if(cri.getDayOfWeek()!=null) {
			//요일값 받아서 한 문자열로 만들었음
			String[] array=cri.getDayOfWeek().split(",");
			String dayOfWeek="";
			for(int i=0;i<array.length;i++) {
				dayOfWeek+=array[i];
			}
			cri.setDayOfWeek(dayOfWeek);
		}
		
		
		cri.setAmount(100);
		int total=0;
		
		total=service.getTotalCount(cri);
		model.addAttribute("list", service.getList(cri));
		
		model.addAttribute("pageMaker", new PageDTO(cri,total));
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
				e.getMessage();
			}
		});
	}

}
