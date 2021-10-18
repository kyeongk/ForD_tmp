package org.kimyk.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.kimyk.domain.Criteria;
import org.kimyk.domain.PageDTO;
import org.kimyk.domain.WatchedDramaVO;
import org.kimyk.domain.WatchingDramaVO;
import org.kimyk.domain.WishesDramaVO;
import org.kimyk.service.AllDramaService;
import org.kimyk.service.WatchedDramaService;
import org.kimyk.service.WatchingDramaService;
import org.kimyk.service.WishesDramaService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class UserOnlyDramaController {
	private WatchingDramaService watchingService;
	private WishesDramaService wishesService;
	private WatchedDramaService watchedService;
	private AllDramaService allService;
	
	@GetMapping("/watched/list")
	@PreAuthorize("isAuthenticated()")
	public void list(Criteria cri, Model model,HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		cri.setUserid(principal.getName());
		int total=watchedService.getTotalCount(cri);
		cri.setAmount(33);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
		model.addAttribute("list", watchedService.getList(cri));
	}
	
	@GetMapping("/watching/list")
	@PreAuthorize("isAuthenticated()")
	public void watchingList(Criteria cri,Model model,HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		cri.setUserid(principal.getName());
		int total=watchingService.getTotalCount(cri);
		cri.setAmount(33);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
		model.addAttribute("list", watchingService.getList(cri));
	}
	
	@GetMapping("/wishes/list")
	@PreAuthorize("isAuthenticated()")
	public void wishesList(Criteria cri,Model model,HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		cri.setUserid(principal.getName());
		int total=wishesService.getTotalCount(cri);
		cri.setAmount(33);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
		model.addAttribute("list", wishesService.getList(cri));
	}
	
	
	//record-get 페이지에서 '시청완료'목록으로 인서트
	@PostMapping("/watched/register")
	@PreAuthorize("isAuthenticated()")
	public String insert(WatchedDramaVO watchedDrama, @ModelAttribute("cri") Criteria cri) {
		watchedService.insert(watchedDrama);
		watchedService.modifyAvgScore(watchedDrama.getAll_drama_id());
		watchedService.modifyViewCount(watchedDrama.getAll_drama_id());
		return "redirect:/record/get"+cri.getListLink()+"&all_drama_id="+watchedDrama.getAll_drama_id();
	}
	
	//record-get 페이지에서 '시청중'으로 인서트
	@PostMapping("/watching/register")
	@PreAuthorize("isAuthenticated()")
	public String insert(WatchingDramaVO watchingDrama, @ModelAttribute("cri") Criteria cri) {
		watchingService.insert(watchingDrama);
		return "redirect:/record/get"+cri.getListLink()+"&all_drama_id="+watchingDrama.getAll_drama_id();
	}
	
	//record-get 페이지에서 '시청예정'으로 인서트
	@PostMapping("/wishes/register")
	@PreAuthorize("isAuthenticated()")
	public String insert(WishesDramaVO wishesDrama, @ModelAttribute("cri") Criteria cri) {
		wishesService.insert(wishesDrama);
		return "redirect:/record/get"+cri.getListLink()+"&all_drama_id="+wishesDrama.getAll_drama_id();
	}
	
	
	//record-list 페이지에서 평점과 함께 '시청완료'목록으로 인서트
	@PostMapping("/watched/registerRecord")
	@PreAuthorize("isAuthenticated()")
	public String insertRecord(WatchedDramaVO watchedDrama, @ModelAttribute("cri") Criteria cri) {
		watchedService.insert(watchedDrama);
		//해당 드라마의 평균 평점 업데이트
		watchedService.modifyAvgScore(watchedDrama.getAll_drama_id());
		//해당 드라마의 시청완료 수 업데이트
		watchedService.modifyViewCount(watchedDrama.getAll_drama_id());
		return "redirect:/record/list"+cri.getListLink();
	}
	
	//record-list 페이지에서 '시청중'으로 인서트
	@PostMapping("/watching/registerRecord")
	@PreAuthorize("isAuthenticated()")
	public String insertRecord(WatchingDramaVO watchingDrama, @ModelAttribute("cri") Criteria cri) {
		watchingService.insert(watchingDrama);
		return "redirect:/record/list"+cri.getListLink();
	}
	
	//record-list 페이지에서 '시청예정'으로 인서트
	@PostMapping("/wishes/registerRecord")
	@PreAuthorize("isAuthenticated()")
	public String insertRecord(WishesDramaVO wishesDrama, @ModelAttribute("cri") Criteria cri) {
		wishesService.insert(wishesDrama);
		return "redirect:/record/list"+cri.getListLink();
	}
	
	//record-get페이지
	@GetMapping("/record/get")
	public void detail(@RequestParam("all_drama_id") Long all_drama_id,@ModelAttribute("cri") Criteria cri, Model model,HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		String userid="";
		if(request.getUserPrincipal()!=null) {
			userid=principal.getName();
		}else {
			userid="";
		}
		model.addAttribute("checkWatchedTable", watchedService.checkWatchedTable(all_drama_id,userid));
		model.addAttribute("checkWatchingTable", watchingService.checkWatchingTable(all_drama_id,userid));
		model.addAttribute("checkWishesTable", wishesService.checkWishesTable(all_drama_id,userid));
		model.addAttribute("board", allService.detail(all_drama_id));
		model.addAttribute("watchedBoard", watchedService.detail(all_drama_id,userid));
		model.addAttribute("watchingBoard", watchingService.detail(all_drama_id,userid));
		model.addAttribute("wishesBoard", wishesService.detail(all_drama_id,userid));
	}
	
	
	
	//'시청완료'에서 삭제
	@PostMapping("/watched/remove")
	@PreAuthorize("isAuthenticated()")
	public String removeWatched(@RequestParam("all_drama_id") Long all_drama_id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		String userid="";
		if(request.getUserPrincipal()!=null) {
			userid=principal.getName();
		}else {
			userid="";
		}
		if(watchedService.remove(all_drama_id,userid)) {
			rttr.addFlashAttribute("result", "success");
		}
		watchedService.modifyAvgScore(all_drama_id);
		watchedService.modifyViewCount(all_drama_id);
		return "redirect:/record/get"+cri.getListLink()+"&all_drama_id="+all_drama_id;
	}
	
	//'시청중'에서 삭제
	@PostMapping("/watching/remove")
	@PreAuthorize("isAuthenticated()")
	public String removeWatching(@RequestParam("all_drama_id") Long all_drama_id,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		String userid="";
		if(request.getUserPrincipal()!=null) {
			userid=principal.getName();
		}else {
			userid="";
		}
		if(watchingService.remove(all_drama_id,userid)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/record/get"+cri.getListLink()+"&all_drama_id="+all_drama_id;
	}
	
	//'시청예정'에서 삭제
	@RequestMapping(value="/wishes/remove",method=RequestMethod.POST)
	@PreAuthorize("isAuthenticated()")
	public String removeWishes(@RequestParam("all_drama_id") Long all_drama_id,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		String userid="";
		if(request.getUserPrincipal()!=null) {
			userid=principal.getName();
		}else {
			userid="";
		}
		if(watchingService.remove(all_drama_id,userid)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/record/get"+cri.getListLink()+"&all_drama_id="+all_drama_id;
	}
	
	//시청완료 평점 수정
	@PostMapping("/watched/modify")
	@PreAuthorize("isAuthenticated()")
	public String modify(WatchedDramaVO watchedDrama, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		try {
			if(watchedService.modify(watchedDrama)) {
				rttr.addFlashAttribute("result", "success");
			}
		}catch(Exception e) {
			e.getMessage();
		}
		watchedService.modifyAvgScore(watchedDrama.getAll_drama_id());
		return "redirect:/record/get"+cri.getListLink()+"&all_drama_id="+watchedDrama.getAll_drama_id();
	}
	
	
	//나의 편성표 일단 화면 이동만
	@GetMapping("/mySchedule")
	public void mySchedule() {
		
	}
	

}
