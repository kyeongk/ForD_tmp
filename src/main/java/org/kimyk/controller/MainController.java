package org.kimyk.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.kimyk.service.AllDramaService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class MainController {
	private AllDramaService service;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String getOnAirList(Model model,HttpServletRequest request) {
		//오늘 요일
		model.addAttribute("todayOfWeek", service.getTodayOfWeek());
		String dayOfWeek=service.getTodayOfWeek();
		
		Principal principal = request.getUserPrincipal();
		if(request.getUserPrincipal()!=null) {
			String userid=principal.getName();
			model.addAttribute("watchingList", service.getWatchingList(userid));
		}
		model.addAttribute("onAirList", service.getOnAirList(dayOfWeek));
		model.addAttribute("expectedList", service.getExpectedList());
		
		
		return "index";
	}
}
