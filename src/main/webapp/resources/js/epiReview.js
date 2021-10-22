/**
 * 
 */



var epiReviewService=(function(){ //함수들이 epiReviewService에 저장됨
	function insert(epiReview, callback, error){
		$.ajax({
			type:'post', 
			url:'/epireview/new', 
			data:JSON.stringify(epiReview), 
			contentType:"application/json; charset=utf-8",
			success:function(result,status,xhr){ 
				
				if(callback){
					if(result=="success"){
					} 
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		})
	}
	function getList(param,callback,error){
		var all_drama_id=param.all_drama_id;
		var page=param.page||1;
		var userid=param.userid;
		
		$.getJSON("/epireview/pages/"+all_drama_id+"/"+page+"/"+userid+".JSON",
			function(data){
				if(callback){
					callback(data.epiReviewCnt, data.list); //회차별 리뷰 숫자와 목록을 가져오는 경우
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
		});
	}
	//시큐리티 어노테이션 적용
	/*function getList(epiReview,callback,error){
		
		$.ajax({
			type:'get',
			url:"/epireview/pages/"+epiReview.all_drama_id+"/"+epiReview.page+"/"+epiReview.userid,
			data:JSON.stringify(epiReview),
			contentType:"application/json; charset=utf-8",
			success:function(data){
				if(callback){
					callback(data.epiReviewCnt, data.list); 
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}*/
	
	function modifyScore(epiReview, callback, error){
		$.ajax({
			type:'put',
			url:'/epireview/score/'+epiReview.id,
			data:JSON.stringify(epiReview),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function modify(epiReview, callback, error){
		$.ajax({
			type:'put',
			url:'/epireview/'+epiReview.id,
			data:JSON.stringify(epiReview),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function modifyViewState(epiReview, callback, error){
		$.ajax({
			type:'put',
			url:'/epireview/viewState/'+epiReview.id,
			data:JSON.stringify(epiReview),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function modifyViewStateAll(epiReview, callback, error){
		$.ajax({
			type:'put',
			url:'/epireview/viewState/'+epiReview.all_drama_id+"/"+epiReview.userid,
			data:JSON.stringify(epiReview),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function detail(id, userid,callback, error){
		$.get("/epireview/"+id+"/"+userid+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	/*function detail(epiReview, callback, error){
		$.ajax({
			type:'get',
			url:'/epireview/'+epiReview.id,
			data:JSON.stringify(epiReview),
			contentType:"application/json; charset=utf-8",
			success:function(result){
				if(callback){
					callback(result);
				}
			}
		});
	}*/
	
	function remove(id,userid,callback,error){
		$.ajax({
			type:'delete',
			url:'/epireview/'+id+'/'+userid,
			data:JSON.stringify({id:id,userid:userid}),
			contentType:"application/json; charset=utf-8",
			success:function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function removeAll(param,callback,error){
		var all_drama_id=param.all_drama_id;
		var userid=param.userid;
		$.ajax({
			type:'delete',
			url:'/epireview/removeAll/'+all_drama_id+'/'+userid,
			data:JSON.stringify({all_drama_id:all_drama_id,userid:userid}),
			contentType:"application/json; charset=utf-8",
			success:function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function displayTime(timeValue){
		
		var today=new Date();
		var gap=today.getTime()-timeValue;
		var dateObj=new Date(timeValue);
		var str="";
		if(timeValue==null){
			return " ";
		}else{
			var yy=dateObj.getFullYear();
			var mm=dateObj.getMonth()+1;
			var dd=dateObj.getDate();
			
			return [yy,'/', (mm>9?'':'0')+mm,'/',(dd>9?'':'0')+dd].join(''); 
		}
	};
	
	function displayTimeAjax(timeValue){
		
		var today=new Date();
		var gap=today.getTime()-timeValue;
		var dateObj=new Date(timeValue);
		var str="";
		if(timeValue==null){
			return " ";
		}else{
			var yy=dateObj.getFullYear();
			var mm=dateObj.getMonth()+1;
			var dd=dateObj.getDate();
			
			return [yy,'-', (mm>9?'':'0')+mm,'-',(dd>9?'':'0')+dd].join(''); 
		}
	};
	
	function epiReviewFormat(epiReview){
		if(epiReview==null){
			return " ";
		}else{
			return epiReview;
		}
		
	};
	return {
		insert:insert,
		getList:getList,
		modifyScore:modifyScore,
		modify:modify,
		modifyViewState:modifyViewState,
		modifyViewStateAll:modifyViewStateAll,
		detail:detail,
		remove:remove,
		removeAll:removeAll,
		epiReviewFormat:epiReviewFormat,
		displayTime:displayTime,
		displayTimeAjax:displayTimeAjax};
})();
