/**
 * 
 */

$(document).ready(function(){
	var formObj=$(".registerForm");
	var useridValue=formObj.find("input[name='userid']").val();
	//시청완료로 점수와 함께 인서트
	$(function() { //평점 플러그인
		   $('.recordRating').barrating('show',{
		        theme: 'fontawesome-stars-o',
		        showSelectedRating: false,
		        initialRating : null,
		        triggerChange:true,
		        onSelect: function(value, text) {
		        	//해당 드라마의 아이디 값을 찾아서 input태그 value에 set
	        		var allDid=$(".getIdValue").parent().siblings("input").val();
	        		$("#allid").val(allDid);
	        		
	        		if(useridValue==''){
	        			alert("로그인을 해주세요");
	        			self.location="/customLogin";
	        		}else{
	        			if(value==''){
		        			$("input[name='avgScore']").val(0);
		        			//점수가 0점이면 삭제
		        			formObj.attr("action","/watched/remove");
			        	}else{
			        		$("input[name='avgScore']").val(value);
			        	}
	        			formObj.submit();
	        		}
		        }
		    });
	 });
	
	//시청중,시청예정으로 인서트(로그인했을때만)
	$(".icons>i.wishesIcon").on("click",function(){
		if(useridValue==''){
			alert("로그인을 해주세요.");
			self.location="/customLogin";
		}else{
			if($(this).hasClass("iconSelected")==1){
				$(this).removeClass("iconSelected");
				$(this).removeClass("fas");
				$(this).addClass("far");
			}else{
				$(this).addClass("iconSelected");
				$(this).removeClass("far");
				$(this).addClass("fas");
			}
			formObj.attr("action","/wishes/registerRecord");
			$("#allid").val($(this).data("id"));
			formObj.submit();
		}
		
	});
	
	$(".icons>i.watchingIcon").on("click",function(){
		if(useridValue==''){
			alert("로그인을 해주세요.");
			self.location="/customLogin";
		}else{
			if($(this).hasClass("iconSelected")==1){
				$(this).removeClass("iconSelected");
				$(this).removeClass("fas");
				$(this).addClass("far");
			}else{
				$(this).addClass("iconSelected");
				$(this).removeClass("far");
				$(this).addClass("fas");
			}
			formObj.attr("action","/watching/registerRecord");
			$("#allid").val($(this).data("id"));
			formObj.submit();
		}
		
	});
	
	
	
	//페이지네이션 숫자 누르면 그 페이지로 감
	var actionForm=$("#actionForm");
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	//드라마 누르면 상세페이지로 감
	$(".move").on("click",function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='all_drama_id' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action","/record/get");
		actionForm.submit();
	});
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	var search=window.location.search;
	var pathname=window.location.pathname;
	var url=pathname+search;
	
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
	
	
	
	
	//여러 데이터 한번에 삭제하는 함수(근데 아직 안됨)
	function deleteDrama(){
		var dramaArr=new Array();
		var dramaid=$(".idCheckBox").val();
		$("input[name='id']:checked").each(function(i){
			dramaArr.push($(this).val());
		});
		var test=[5,4];
		if(dramaArr.length==0){
			alert("선택된 드라마가 없습니다.");
		}else{
			var chk=confirm("정말 삭제하시겠습니까?");
			$.ajax({
				url:'/record/removeAll',
				type:'POST',
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				}, 
				traditional:true,
				data:{dramaArr:dramaArr},
				success:function(jdata){
					if(jdata=1){
						alert("삭제되었습니다.");
						self.location=url;
						//마지막 페이지에 있는 데이터를 모두 삭제했을때 목록 갯수 세서 0이면 해당 pageNum-1 페이지로 가게 해야함
					}else{
						alert("삭제 실패하였습니다.");
					}
				},error:function(xhr,status,er){
					alert('실패'+status+"-"+er);
				}
			});
		}
		
	};
	
	
	
  
	
	
	
	//맨위로 버튼
	$(".topDiv").hide();
	$(window).scroll(function(){
		if($(this).scrollTop()>120){
			$(".topDiv").fadeIn();
		}else{
			$(".topDiv").fadeOut();
		}
	});
	$(".topDiv").on("click",function(){
		$("body,html").animate({
			scrollTop:0
		},500);
		return false;
	});
	
	//정렬하기 버튼
	$(".recordListOrder").on("click",function(){
		$(this).find("i").toggleClass("fa-flip-vertical");
		$(".recordListHeaderDiv").toggleClass("open");
	});
	
    //관리자 전용
	$("#recordRegBtn").on("click",function(){
		self.location="/record/register";
	});
	//체크박스 전체선택,해제
	/* $("#checkAll").on("click",function(){
		if($("#checkAll").prop("checked")){
			$(".idCheckBox").prop("checked",true);
		}else{
			$(".idCheckBox").prop("checked",false);
		}
	});
	$("#recordRemoveBtn").on("click", function(e){
		e.preventDefault();
		var removeConfirm=confirm("드라마를 삭제하시겠습니까?");
		if(removeConfirm==true){
			deleteDrama();
		}else{
			alert("취소하였습니다.");
		}
	}); */
	//중복된 데이터가 있어서 인서트에 실패했을때
	var result='<c:out value="${result}"/>';
	if(result=="insertFail"){
		alert("이미 등록된 드라마입니다.");
	};
	
	
	

});