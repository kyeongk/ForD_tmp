package org.kimyk.controller;

import org.kimyk.domain.Criteria;
import org.kimyk.domain.EpiReviewPageDTO;
import org.kimyk.domain.EpiReviewVO;
import org.kimyk.service.EpiReviewService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;

@RequestMapping("/epireview/")
@RestController
@AllArgsConstructor
public class EpiReviewController {
	private EpiReviewService service;
	
	//회차별 리뷰 리스트(watched 게시판 번호를 입력받아서 처리)
	@GetMapping(value="/pages/{all_drama_id}/{page}/{userid}", produces= {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	@PreAuthorize("principal.username==#userid")
	public ResponseEntity<EpiReviewPageDTO> getList(@PathVariable("page") int page, @PathVariable("all_drama_id") Long all_drama_id,@PathVariable("userid") String userid){
		Criteria cri=new Criteria(page,20);
		return new ResponseEntity<>(service.getListPage(cri, all_drama_id,userid),HttpStatus.OK);
	}
	
	
	
	//회차별 리뷰 등록
	@PostMapping(value="/new", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("principal.username==#epiReview.userid")
	public ResponseEntity<String> insert(@RequestBody EpiReviewVO epiReview){
		int insertCount=service.insert(epiReview);
		return insertCount==1
				?new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//평점만 간단히 수정
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/score/{id}", consumes="application/json")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> modifyScore(@RequestBody EpiReviewVO epiReview, @PathVariable("id") Long id){
		epiReview.setId(id);
		
		return service.modifyScore(epiReview)==1
				?new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//회차별 리뷰 수정(감상평,시청 날짜까지 업데이트)
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/{id}", consumes="application/json")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> modify(@RequestBody EpiReviewVO epiReview, @PathVariable("id") Long id){
		epiReview.setId(id);
		
		return service.modify(epiReview)==1
				?new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//정주행 체크
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/viewState/{id}", consumes="application/json")
	@PreAuthorize("principal.username==#epiReview.userid")
	public ResponseEntity<String> modifyViewState(@RequestBody EpiReviewVO epiReview, @PathVariable("id") Long id){
		epiReview.setId(id);
		return service.modifyViewState(epiReview)==1
				?new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	//정주행 체크 한번에 하기(시청완료&시청중에 있던 드라마가 시청중에서 삭제되었을때 viewState를 watched로 한꺼번에 바꿈)
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/viewState/{all_drama_id}/{userid}", consumes="application/json")
	@PreAuthorize("principal.username==#userid")
	public ResponseEntity<String> modifyViewStateAll(@RequestBody EpiReviewVO epiReview, @PathVariable("all_drama_id") Long all_drama_id, @PathVariable("userid") String userid){
		epiReview.setAll_drama_id(all_drama_id);
		epiReview.setUserid(userid);
		return service.modifyViewStateAll(epiReview)==1
				?new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	//회차별 리뷰 조회
	@GetMapping(value="/{id}/{userid}", produces= {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	@PreAuthorize("principal.username==#userid")
	public ResponseEntity<EpiReviewVO> detail(@PathVariable("id") Long id,@PathVariable("userid") String userid){
		return new ResponseEntity<>(service.detail(id),HttpStatus.OK);
	}
	
	//회차별 리뷰 삭제
	@DeleteMapping(value="/{id}/{userid}")
	@PreAuthorize("principal.username==#userid")
	public ResponseEntity<String> remove(@RequestBody EpiReviewVO epiReview, @PathVariable("id") Long id,@PathVariable("userid") String userid){
		return service.remove(id)==1
				?new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//회차별 리뷰 전부 삭제(시청완료 또는 시청중에 있던 드라마가 테이블에서 삭제되었을때)
	@DeleteMapping(value="/removeAll/{all_drama_id}/{userid}")
	@PreAuthorize("principal.username==#userid")
	public ResponseEntity<String> removeAll(@RequestBody EpiReviewVO epiReview, @PathVariable("all_drama_id") Long all_drama_id, @PathVariable("userid") String userid){
		return service.removeAll(all_drama_id, userid)==1
				?new ResponseEntity<>("success",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
