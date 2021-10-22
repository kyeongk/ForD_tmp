/**
 * 
 */

$(document).ready(function(){
	var operForm=$("#operForm");
	
	var totalScore="<c:out value='${watchedBoard.avgScore }'/>";
	var recordBoardId="<c:out value='${board.id }'/>"
	var watchedDetailId="<c:out value='${watchedBoard.id }'/>";
	var watchedBoardCheck="<c:out value='${checkWatchedTable }'/>";
	var watchingBoardCheck="<c:out value='${checkWatchingTable }'/>";
	var totalEpisode="<c:out value='${board.totalEpisode }'/>";
	var epiRatingModalScore=0;
	$("input[name='avgScore']").val(totalScore);
	operForm.find($("input[name='id']")).val(watchedDetailId);
	$(function() {
		   $('.totalScore').barrating('show',{
		        theme: 'fontawesome-stars-o',
		        
		        showSelectedRating: true,
		        initialRating : totalScore,
		        //allowEmpty: true,
		       // emptyValue: '-- no rating selected --',
		        onSelect: function(value, text) {
		        	//var formObj=$("#operForm");
	        		var allDid=$(".getIdValue").parent().siblings("input").val();
	        		
	        		$("#allid").val(allDid);
	        		if(value==''){
	        			$("input[name='avgScore']").val(0);
	        			if($("input[name='avgScore']").val()==0){
	        				var chk=confirm("점수가 0점이면 시청완료 목록에서 삭제됩니다. 계속하시겠습니까?");
	        				if(chk==true){
			        			operForm.attr("action","/watched/remove");
			        			operForm.submit();
			        		}else{
			        			//$('.totalScore').barrating('set',totalScore);
			        			return;
			        		}
	        			}
		        	}else{
		        		$("input[name='avgScore']").val(value);
		        		operForm.submit();
		        	}
		        }
		    });
	});
	var actionForm=$("#actionForm");
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	//데이트피커
	$( ".datepicker" ).datepicker({
		changeMonth: true,
	      changeYear: true,
	      dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
	      monthNames:[ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	      monthNamesShort:[ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	      dateFormat: "yy/mm/dd"
	});
	
	//데이트피커(ajax)
	$( ".datepickerAjax" ).datepicker({
		changeMonth: true,
	      changeYear: true,
	      dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
	      monthNames:[ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	      monthNamesShort:[ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	      dateFormat: "yy-mm-dd"
	});
	//버튼 클릭하면 회차별 리뷰 모달창 띄우기
	var epiReviewModal=$("#epiReviewModal");
	var epiReviewModalInputEpiNumber=operForm.find("input[name='epiNumber']");
	var epiReviewModalInputWatchedDate=operForm.find("input[name='watchedDate']");
	var epiReviewModalInputScore=operForm.find("input[name='score']");
	var epiReviewModalInputEpiReview=operForm.find("input[name='epiReview']");
	var epiReviewModalInputAllDramaId=operForm.find("input[name='all_drama_id']");
	var epiReviewModalInputUseridId=operForm.find("input[name='userid']");
	var totalReviewModal=$("#totalReviewModal");
	$("#addEpiReview").on("click",function(e){
		//초기화
		
		$("#epiReviewModalSelect").attr("class","recordRatingModal");
		$('.recordRatingModal').barrating('show',{
	        theme: 'fontawesome-stars-o',
	        showSelectedRating: true,
	        initialRating : 0,
	        onSelect: function(value, text) {
				var allDid=$(".getIdValue").parent().siblings("input").val();
        		
        		$("#epiId").val(allDid);
        		if(value==''){
	        		$("input[name='score']").val(0);
	        		//operForm.attr("action","/watched/remove");
	        	}else{
	        		$("input[name='score']").val(value);
	        	}
	        }
	    });
		$("#epiModalModBtn").hide();
		$("#epiModalRemoveBtn").hide();
		$("#epiModalRegisterBtn").show();
		$("#epiReviewModal").modal("show");
	});
	//버튼 클릭하면 종합 리뷰 모달창 띄우기
	$("#addTotalReview").on("click",function(e){
		/* 모달창 별점 */
	   $('.totalScoreModal').barrating('show',{
	        theme: 'fontawesome-stars-o',
	        
	        showSelectedRating: true,
	        initialRating : totalScore,
	        //allowEmpty: true,
	       // emptyValue: '-- no rating selected --',
	        onSelect: function(value, text) {
	        	//var formObj=$("#operForm");
        		var allDid=$(".getIdValue").parent().siblings("input").val();
        		
        		$("#allid").val(allDid);
        		if(value==''){
	        		$("input[name='avgScore']").val(0);
	        		
	        	}else{
	        		$("input[name='avgScore']").val(value);
	        	}
        		
	        }
	    });
		$("#epiNumberModal").val("");
		$("#totalReviewtextModal").val($("#totalReviewtextModal").val().replace(/<br>/gi,'\r\n'));
		$("#totalReviewModal").modal("show");
	});
	//종합리뷰 모달창 수정버튼 눌렀을때
	$("#totalModalModBtn").on("click",function(e){
		e.preventDefault();
		if($("#totalReviewtextModal").val().length>1000){
			alert("감상평은 1000자를 넘을 수 없습니다.");
			return;
		}
		if($("input[name='avgScore']").val()==0){
			var chk=confirm("점수가 0점이면 시청중 목록에서 삭제됩니다. 계속하시겠습니까?");
			if(chk==true){
				operForm.attr("action","/watched/remove");
				operForm.attr("method","post");
			}else{
				return;
			}
		}else{
			operForm.find("input[name='watchedStartDate']").val($("#watchedStartDateModal").val());
			operForm.find("input[name='watchedEndDate']").val($("#watchedEndDateModal").val());
			operForm.find("input[name='totalReview']").val($("#totalReviewtextModal").val());
			operForm.attr("action","/watched/modify");
			operForm.attr("method","post");
			operForm.submit();
		}
		
	});
	//모달창 hide될때 실행됨(별점 초기화)
	$('.modal').on('hidden.bs.modal', function (e) {
		$('.recordRatingModal').barrating('destroy');
		$("#epiReviewModalSelect").barrating('destroy');
		$('.totalScoreModal').barrating('destroy');
		$("#epiNumberModal").val("");
		$("#watchedDateModal").val("");
		$("#epiReviewTextModal").val("");
		
	});
	
	//아이콘 hover이벤트
	$(".icons>i.wishesIcon").hover(function(){
		$(this).removeClass("far");
		$(this).addClass("fas");
		$(this).addClass("iconHover");
	},function(){
		if($(this).hasClass("iconSelected")==1){
			$(this).removeClass("far");
			$(this).addClass("fas");
		}else{
			$(this).removeClass("fas").addClass("far");
		};
		
		$(this).removeClass("iconHover");
	});
	$(".icons>i.watchingIcon").hover(function(){
		$(this).removeClass("far");
		$(this).addClass("fas");
		$(this).addClass("iconHover");
	},function(){
		if($(this).hasClass("iconSelected")==1){
			$(this).removeClass("far");
			$(this).addClass("fas");
		}else{
			$(this).removeClass("fas").addClass("far");
		};
		
		$(this).removeClass("iconHover");
	});
	$(".icons>i.watchedIcon").hover(function(){
		$(this).removeClass("far");
		$(this).addClass("fas");
		$(this).addClass("iconHover");
	},function(){
		if($(this).hasClass("iconSelected")==1){
			$(this).removeClass("far");
			$(this).addClass("fas");
		}else{
			$(this).removeClass("fas").addClass("far");
		};
		$(this).removeClass("iconHover");
	});
	
	
	
	
	
	//왼쪽에 있는 아이콘들 누르면 각 페이지로 인서트, 삭제
	$(".icons>i.watchedIcon").on("click",function(){
		if($(this).hasClass("iconSelected")==1){
			if($(".icons>i.watchingIcon").hasClass("iconSelected")==1){ //시청완료&시청중에 들어있는데 시청완료 아이콘 눌렀을때
				$(".icons>i.watchedIcon").removeClass("iconSelected");
				$(".icons>i.watchedIcon").removeClass("fas");
				$(".icons>i.watchedIcon").addClass("far");
				operForm.attr("action","/watched/remove");
			}else{
				var chk=confirm("시청완료 목록에서 삭제되면 종합리뷰와 회차별 리뷰가 모두 삭제됩니다. 계속하시겠습니까?");
				if(chk==true){
					$(this).removeClass("iconSelected");
					$(this).removeClass("fas");
					$(this).addClass("far");
					epiReviewService.removeAll({all_drama_id:epiReviewModalInputAllDramaId.val(),userid:epiReviewModalInputUseridId.val()},function(result){
						showEpiReview(pageNum);
					});
					operForm.attr("action","/watched/remove");
				}else{
					return;
				}
			}
		}else{
			$(this).addClass("iconSelected");
			$(this).removeClass("far");
			$(this).addClass("fas");
			operForm.attr("action","/watched/register");
			operForm.find("input[name='id']").remove();
			$("input[name='avgScore']").val(5);
		}
		operForm.submit();
	});
	$(".icons>i.watchingIcon").on("click",function(){
		if($(this).hasClass("iconSelected")==1){
			if($(".icons>i.watchedIcon").hasClass("iconSelected")==1){//시청완료&시청중에 들어있음. 시청중 아이콘 누름
				$(".icons>i.watchingIcon").removeClass("iconSelected");
				$(".icons>i.watchingIcon").removeClass("fas");
				$(".icons>i.watchingIcon").addClass("far");
				var epiReview={all_drama_id:all_drama_id,viewState:"watched",userid:epiReviewModalInputUseridId.val()};
				epiReviewService.modifyViewStateAll(epiReview,function(result){
					showEpiReview(pageNum);
				});
				operForm.attr("action","/watching/remove");
			}else{//시청중에만 들어있음
				var chk=confirm("회차별 리뷰가 모두 삭제됩니다. 계속하시겠습니까?");
				if(chk==true){
					$(this).removeClass("iconSelected");
					$(this).removeClass("fas");
					$(this).addClass("far");
					epiReviewService.removeAll({all_drama_id:epiReviewModalInputAllDramaId.val(),userid:epiReviewModalInputUseridId.val()},function(result){
						showEpiReview(pageNum);
					});
					operForm.attr("action","/watching/remove");
				}else{
					return;
				}
			}
		}else{
			$(this).addClass("iconSelected");
			$(this).removeClass("far");
			$(this).addClass("fas");
			operForm.attr("action","/watching/register");
			operForm.find("input[name='id']").remove();
		}
		operForm.submit();
	});
	$(".icons>i.wishesIcon").on("click",function(){
		if($(this).hasClass("iconSelected")==1){
			$(this).removeClass("iconSelected");
			$(this).removeClass("fas");
			$(this).addClass("far");
			operForm.attr("action","/wishes/remove");
		}else{
			$(this).addClass("iconSelected");
			$(this).removeClass("far");
			$(this).addClass("fas");
			operForm.attr("action","/wishes/register");
			operForm.find("input[name='id']").remove();
		}
		operForm.submit();
	});
	//썸네일 이미지 주소를 원본 주소로 바꾸기
	var getPosterUrl=$(".getPosterImg").attr("src");
	getPosterUrl=getPosterUrl.replace(/%2Fs_/g,"%2F");
	$(".getPosterImg").attr("src",getPosterUrl);
	
	
	
//회차별 리뷰 관련 js 시작
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	//Ajax spring security header...
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});
	

	var all_drama_id='<c:out value="${board.id}"/>';
	var epiUl=$(".epiUl");
	showEpiReview(1)
	//회차별 리뷰 목록
	function showEpiReview(page){
		if($("input[name='userid']").val()!=''){
			epiReviewService.getList({all_drama_id:all_drama_id,page:page||1,userid:epiReviewModalInputUseridId.val()},function(epiReviewCnt,list){
				if(page==-1){
					pageNum=Math.ceil(epiReviewCnt/20.0);
					showEpiReview(pageNum);
					return;
				}
				var str="";
				var viewStateChk=" ";
				var viewStateVal="";
				var disabled=" disabled";
				if(list==null||list.length==0){
					str+="<p class='noneEpiReview'>작성된 리뷰가 없습니다.<br>작성된 회차별 리뷰가 없을 경우 여러개의 리뷰를 한번에 등록할 수 있습니다.</p>";
				}else{
					for(var i=0, len=list.length||0; i<len; i++){
						if(list[i].viewState=="replay"){
							viewStateChk="checked";
							viewStateVal="replay";
						}else if(list[i].viewState==null){
							viewStateChk=" ";
						}
						if(watchedBoardCheck==1&&watchingBoardCheck==1){
							disabled=" ";
						}else{
							disabled=" disabled";
						}
						var userid=list[i].userid;
						str+="<div class='replayCheck'><input type='checkbox' class='viewStateCheckBox' name='viewState' value='"+viewStateVal+"' data-id='"+list[i].id+"' ";
						str+=viewStateChk+disabled+"><span class='replayCheckText'>정주행 체크</span></div><li data-id='"+list[i].id+"'><table class='episodeTbl'><tr><td class='episodeNumTd'>";
						str+=list[i].epiNumber+"화</td><td class='scoreTd'><select id='recordRating"+i+"'><option value>";
						str+="</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option>";
						str+="</select><script type='text/javascript'>$(function(){$('#recordRating"+i+"').barrating";
						str+="('show',{theme: 'fontawesome-stars-o',showSelectedRating: false,initialRating :"+list[i].score+",onSelect:";
						str+="function(value,text){if(value==''){var id="+list[i].id+";var userid="+list[i].userid+";var chk=confirm('리뷰를 삭제하시겠습니까?');if(chk==true)";
						str+="{epiReviewService.remove(id,userid,function(result){alert('삭제되었습니다.');});}else{$('#recordRating"+i+"').barrating('set',"+list[i].score+");return;}";
						str+="}else{var epiReview={id:"+list[i].id+",score:value}; ";
						str+="epiReviewService.modifyScore(epiReview);}}});});</script";
						str+="></td><td rowspan='2' class='episodeReviewTd'>"+epiReviewService.epiReviewFormat(list[i].epiReview)+"</td></tr><tr>";
						str+="<td colspan='2' class='watchedDateTd'>시청날짜:"+epiReviewService.displayTime(list[i].watchedDate)+"</td></tr></table></li>";
						
						/*스크립트 부분 보기좋게 
						$(function(){$('#recordRating'+i).barrating('show',{
							theme: 'fontawesome-stars-o',
							showSelectedRating: false,
							initialRating :"+list[i].score+",
							onSelect:function(value,text){
								if(value==''){
									var id="+list[i].id+";
									var userid="+list[i].userid+";
									var chk=confirm('리뷰를 삭제하시겠습니까?');
									if(chk==true){
										epiReviewService.remove(id,userid,function(result){
											alert('삭제되었습니다.');
										});
									}else{
										$('#recordRating'+i).barrating('set',list[i].score);
										return;
									}
									
								}else{
									var epiReview={id:"+list[i].id+",score:value,userid:"+list[i].userid+"}; 
									epiReviewService.modifyScore(epiReview);
								}
							}
						});
						}) */
					}
				}
				epiUl.html(str);
				showEpiReviewPage(epiReviewCnt);
			});
		}
	}
	
	//페이지네이션
	var pageNum=1;
	var epiReviewPagination=$(".paginationDiv");
	function showEpiReviewPage(epiReviewCnt){
		var endNum=Math.ceil(pageNum/10.0)*10;
		var startNum=endNum-9;
		
		var prev=startNum !=1;
		var next=false;
		if(endNum*20>=epiReviewCnt){
			endNum=Math.ceil(epiReviewCnt/20.0);
		}
		if(endNum*20<epiReviewCnt){
			next=true;
		}
		var str="<ul class='pagination pull-right'>";
		if(prev){
			str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
		}
		for (var i=startNum;i<=endNum;i++){
			var active=pageNum==i?"active":"";
			str+="<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		if(next){
			str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
		}
		str+="</ul></div>";
		epiReviewPagination.html(str);
	}
	epiReviewPagination.on("click","li a",function(e){
		e.preventDefault();
		var targetPageNum=$(this).attr("href");
		pageNum=targetPageNum;
		showEpiReview(pageNum);
	});
	
	//회차별 리뷰 등록
	$("#epiModalRegisterBtn").on("click",function(e){
		
		operForm.find("input[name='watchedDate']").val($("#watchedDateModal").val());
		operForm.find("input[name='epiNumber']").val($("#epiNumberModal").val());
		var id=$(".watchingIcon").data("id");
		if($(".watchingIcon").data("id")==null){
			id=$(".watchedIcon").data("id");
		}
		var epiReview={
				all_drama_id:epiReviewModalInputAllDramaId.val(),
				score:epiReviewModalInputScore.val(),
				epiNumber:epiReviewModalInputEpiNumber.val(),
				epiReview:$("#epiReviewTextModal").val().replace(/(?:\r\n|\r|\n)/g, '<br>'),
				watchedDate:$("#watchedDateModal").val(),
				userid:epiReviewModalInputUseridId.val(),
				id:id
			};
		if($("#epiReviewTextModal").val().length>1000){
			alert("감상평은 1000자를 넘을 수 없습니다.");
			return $("#epiReviewTextModal").focus();
		}
		if($("#epiNumberModal").val().indexOf('-')<=-1){ //입력값에 -가 없음
			if(isNumeric($("#epiNumberModal").val(),5)==false){ //"문자" 형식
				$(".epiNumberHelpText").html("회차에는 숫자만 입력할 수 있습니다.");
				return $("#epiNumberModal").focus();
			}else{ //"n"형식
				epiReviewService.insert(epiReview,function(result){
					$("#epiReviewModal").find("input").val("");
					$("#epiReviewModal").modal("hide");
					
					showEpiReview(-1);
				});
			}
		}else{ //입력값에 -가 있음
			if($("input[name='userid']").val()!=''){
				epiReviewService.getList({all_drama_id:all_drama_id,page:1,userid:epiReviewModalInputUseridId.val()},function(epiReviewCnt,list){
					if(list==null||list.length==0){ //회차별 리뷰가 하나도 없으면
						var arr=$("#epiNumberModal").val().split('-');
						var firstNum=Number(arr[0]);
						var secondNum=Number(arr[1]);
						if(arr.length==2){
							if(firstNum<secondNum&&secondNum<=totalEpisode&&firstNum!=0){
								for(var i=firstNum;i<=secondNum;i++){
									epiReview={
											all_drama_id:epiReviewModalInputAllDramaId.val(),
											score:epiReviewModalInputScore.val(),
											epiNumber:i,
											epiReview:$("#epiReviewTextModal").val().replace(/(?:\r\n|\r|\n)/g, '<br>'),
											watchedDate:$("#watchedDateModal").val(),
											userid:epiReviewModalInputUseridId.val()
									}
									epiReviewService.insert(epiReview,function(result){
										$("#epiReviewModal").find("input").val("");
										$("#epiReviewModal").modal("hide");
										showEpiReview(-1);
									});
								}
							}else if(firstNum>=secondNum){
								$(".epiNumberHelpText").html("첫번째 숫자는 두번째 숫자를 초과할 수 없습니다.");
								$(".epiNumberHelpText").css({"font-size":"11px","color":"red"});
								return $("#epiNumberModal").focus();
							}else if(secondNum>totalEpisode){
								$(".epiNumberHelpText").html("총 회차수를 초과할 수 없습니다.");
								$(".epiNumberHelpText").css({"font-size":"11px","color":"red"});
								return $("#epiNumberModal").focus();
							}else if(firstNum==0||secondNum==0){
								$(".epiNumberHelpText").html("0회차는 입력할 수 없습니다.");
								$(".epiNumberHelpText").css({"font-size":"11px","color":"red"});
								return $("#epiNumberModal").focus();
							}
						}else{
							$(".epiNumberHelpText").html("'숫자-숫자'형식으로 정확하게 입력하세요.");
							$(".epiNumberHelpText").css({"font-size":"11px","color":"red"});
							return $("#epiNumberModal").focus();
						}
					}else{ //회차별 리뷰가 하나라도 있으면
						$(".epiNumberHelpText").html("회차별 리뷰가 있으면 연속입력기능을 사용할 수 없습니다.");
						$(".epiNumberHelpText").css({"font-size":"11px","color":"red"});
						return $("#epiNumberModal").focus();
					}
				});
			}
		}
	});
	
	
	
	
	
	//댓글 조회 클릭 이벤트
	$(".epiUl").on("click","li",function(e){
		var id=$(this).data("id");
		var userid=epiReviewModalInputUseridId.val();
		epiReviewService.detail(id,userid,function(epiReview){
			
			$("#epiNumberModal").val(epiReview.epiNumber);
			$("#watchedDateModal").val(epiReviewService.displayTimeAjax(epiReview.watchedDate));
			$("#epiReviewTextModal").val(epiReviewService.epiReviewFormat(epiReview.epiReview).replace(/<br>/gi,'\r\n'));
			
			
			$("#epiReviewModal").data("id",epiReview.id);
			$("#epiModalModBtn").show();
			$("#epiModalRemoveBtn").show();
			$("#epiModalRegisterBtn").hide();
			$("#epiReviewModal").modal("show");
			$("#epiReviewModalSelect").attr("class", "epiReviewModalScore"+epiReview.id);
			epiRatingModalScore=epiReview.score;
			epiReviewModalInputScore.val(epiRatingModalScore);
			$(".epiReviewModalScore"+epiReview.id).barrating('show',{
		        theme: 'fontawesome-stars-o',
		        showSelectedRating: true,
		        initialRating : epiRatingModalScore,
		        onSelect: function(value, text) {
		        	var allDid=$(".getIdValue").parent().siblings("input").val();
	        		
	        		$("#epiId").val(allDid);
	        		if(value==''){
		        		$("input[name='score']").val(0);
		        		//operForm.attr("action","/watched/remove");
		        	}else{
		        		$("input[name='score']").val(value);
		        	}
		        }
		    });
			//모달창 hide될때 실행됨
			$('#epiReviewModal').on('hidden.bs.modal', function (e) {
				$(".epiReviewModalScore"+epiReview.id).barrating('destroy');
				$("#epiNumberModal").val("");
			});
		});
		
	});
	
	//회차별 리뷰 수정(점수가 0점이면 삭제할건지 물어봄)
	$("#epiModalModBtn").on("click", function(e){
		
		var epiReview={
				id:epiReviewModal.data("id"),
				epiReview:$("#epiReviewTextModal").val().replace(/(?:\r\n|\r|\n)/g, '<br>'),
				epiNumber:$("#epiNumberModal").val(),
				watchedDate:$("#watchedDateModal").val(),
				score:epiReviewModalInputScore.val(),
				userid:epiReviewModalInputUseridId.val()
		};
		if($("#epiReviewTextModal").val().length>1000){
			alert("감상평은 1000자를 넘을 수 없습니다.");
			return;
		}
		if(epiReviewModalInputScore.val()==0){
			var chk=confirm("점수가 0점이면 리뷰가 삭제됩니다. 삭제하시겠습니까?");
			if(chk==true){
				var id=epiReviewModal.data("id");
				var userid=epiReviewModalInputUseridId.val();
				epiReviewService.remove(id,userid,function(result){
					alert("삭제되었습니다.");
					$("#epiReviewModal").modal("hide");
					showEpiReview(pageNum);
				});
			}else{
				return;
			}
		}else{
			if(isNumeric($("#epiNumberModal").val(),5)==false){
				alert("회차에는 숫자만 입력할 수 있습니다.");
				return $("#epiNumberModal").focus();
			}else{
				
				epiReviewService.modify(epiReview,function(result){
					alert("수정되었습니다.");
					$("#epiReviewModal").modal("hide");
					showEpiReview(pageNum);
				});
			}
		}
		
		
	});
	
	
	
	
	//정주행 체크
	$(".epiUl").on("click",".viewStateCheckBox",function(e){
		var id=$(this).data("id");
		if($(this).is(":checked")){
			
			var epiReview={id:id,viewState:"replay",userid:epiReviewModalInputUseridId.val()};
		}else{
			
			var epiReview={id:id,viewState:"watched",userid:epiReviewModalInputUseridId.val()};
		} 
		epiReviewService.modifyViewState(epiReview,function(result){
			showEpiReview(pageNum);
		});
	});
	//모달창에서 회차별 리뷰 삭제
	$("#epiModalRemoveBtn").on("click",function(e){
		var id=$("#epiReviewModal").data("id");
		var userid=epiReviewModalInputUseridId.val()
		var chk=confirm("리뷰를 삭제하시겠습니까?");
		if(chk==true){
			epiReviewService.remove(id,userid,function(result){
				alert("삭제되었습니다.");
				$("#epiReviewModal").modal("hide");
				showEpiReview(pageNum);
			});
		}else{
			return;
		}
	});
	//회차별 리뷰 목록에서 점수만 수정
	/* $(".epiUl").on("click",".viewStateCheckBox",function(e){
		var id=$(this).data("id");
		if($(this).is(":checked")){
			
			var epiReview={id:id,viewState:$(this).val(),userid:epiReviewModalInputUseridId.val()};
		}else{
			
			var epiReview={id:id,viewState:"watched",userid:epiReviewModalInputUseridId.val()};
		} 
		epiReviewService.modifyViewState(epiReview,function(result){
			showEpiReview(pageNum);
		});
	}); */
	
	
	//관리자 전용
	//드라마 데이터 삭제와 수정 버튼(관리자만 가능함)
	$("button[data-oper='modify']").on("click",function(e){
		operForm.find($("input[name='id']")).val(recordBoardId);
		operForm.attr("action","/record/modify");
		operForm.attr("method","get");
		operForm.submit();
	});
	$("button[data-oper='remove']").on("click",function(e){
		var removeConfirm=confirm("글을 삭제하시겠습니까?");
		if(removeConfirm==true){
			operForm.find($("input[name='id']")).val(recordBoardId);
			operForm.attr("action","/record/remove").attr("method","post");
			operForm.submit();
		}else{
			alert("취소하였습니다");
		}
	});
	
	
	//입력값이 숫자인지 확인
	function isNumeric(num,opt){
		num=String(num).replace(/^\s+|\s+$/g, "");
		
		if(typeof opt == "undefined" || opt == "1"){
		    // 모든 10진수 (부호 선택, 자릿수구분기호 선택, 소수점 선택)
		    var regex = /^[+\-]?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
		  }else if(opt == "2"){
		    // 부호 미사용, 자릿수구분기호 선택, 소수점 선택
		    var regex = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
		  }else if(opt == "3"){
		    // 부호 미사용, 자릿수구분기호 미사용, 소수점 선택
		    var regex = /^[0-9]+(\.[0-9]+)?$/g;
		  }else if(opt=="4"){
			  var regex = /^[0-9]$/g;
		  }else{
		    // only 숫자만(부호 미사용, 자릿수구분기호 미사용, 소수점 미사용)
		    var regex = /^[0-9]{0,3}$/g;
		  }
		 
		  if( regex.test(num) ){
		    num = num.replace(/,/g, "");
		    return isNaN(num) ? false : true;
		  }else{ return false;  }
	}
});