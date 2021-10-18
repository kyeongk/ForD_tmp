<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <h1 class="page-header">드라마 등록하기</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
   <div class="col-lg-12 col-md-12 col-sm-12">
       <div class="panel panel-default">
           <div class="panel-heading">
              	 드라마 정보 입력
           </div>
           <!-- /.panel-heading -->
           <div class="panel-body">
           	<form role="form" action="/record/register" method="post">
           		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
           		<input type='hidden' name='posterUrl' value=''>
           		<div class='col-lg-2 col-md-2 col-sm-2'>
           			<div class="form-group">
	           			<label>드라마 제목</label><input class="form-control" name='title' autofocus autocomplete="off">
	           		</div>
           		</div>
           		<div class='col-lg-3 col-md-3 col-sm-3'>
           			<div class="form-group">
           				<label class='recordRegLabel'>방영요일</label><br>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='mon'>월
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='tue'>화
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='wed'>수
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='thu'>목
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='fri'>금
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='sat'>토
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='sun'>일
                        </label>
           			</div>
           		</div>
           		<div class='col-lg-3 col-md-3 col-sm-3 stateDiv'>
           			<div class="form-group">
                       <label class='recordRegLabel'>상태</label><br>
                       <label class="radio-inline">
                           <input type="radio" name="state" id="optionsRadiosInline1" value="방영예정">방영예정
                       </label>
                       <label class="radio-inline">
                           <input type="radio" name="state" id="optionsRadiosInline2" value="방영중">방영중
                       </label>
                       <label class="radio-inline">
                           <input type="radio" name="state" id="optionsRadiosInline3" value="방영종료">방영종료
                       </label>
                       <label class="radio-inline">
                           <input type="radio" name="state" id="optionsRadiosInline4" value="상시방영중">상시방영중
                       </label>
                	</div>
           		</div>
           		<div class='col-lg-1 col-md-1 col-sm-1 totalEpiDiv'>
           			<div class="form-group">
           			<label>총 회차</label><input class="form-control" name='totalEpisode'>
           		</div>
           		</div>
           		<div class='col-lg-1 col-md-1 col-sm-1 broadDiv'>
           			<div class="form-group">
	           			<label>방송사</label>
	           			<select class="form-control" name='broadcastingName'>
	           				<option value="KBS2">KBS2</option>
	           				<option value="MBC">MBC</option>
	           				<option value="SBS">SBS</option>
	           				<option value="tvN">tvN</option>
	           				<option value="JTBC">JTBC</option>
	           				<option value="OCN">OCN</option>
	           				<option value="NETFLIX">NETFLIX</option>
	           				<option value="WATCHA">WATCHA</option>
	           				<option value="KBS1">KBS1</option>
	           				<option value="TVING">TVING</option>
	           				<option value="TV조선">TV조선</option>
	           				<option value="MBN">MBN</option>
	           				<option value="채널A">채널A</option>
	           				<option value="MBC드라마넷">MBC드라마넷</option>
	           				<option value="DRAMAcube">DRAMAcube</option>
	           				<option value="SBS플러스">SBS플러스</option>
	           				<option value="투니버스">투니버스</option>
	           				<option value="Mnet">Mnet</option>
	           				<option value="OCN Movies">OCN Movies</option>
	           				<option value="MBC every1">MBC every1</option>
	           				<option value="네이버 TV">네이버 TV</option>
	           				<option value="OCN Thrills">OCN Thrills</option>
	           				<option value="E채널">E채널</option>
	           				<option value="Olive">Olive</option>
	           				<option value="MBC QueeN">MBC QueeN</option>
	           				<option value="KBS Drama">KBS Drama</option>
	           				<option value="OBS 경인TV">OBS 경인TV</option>
	           				<option value="MBC M">MBC M</option>
	           				<option value="드라맥스">드라맥스</option>
	           				<option value="미정">미정</option>
	           				<option value=""></option>
	           			</select>
	           		</div>
           		</div>
           		<div class='col-lg-1 col-md-1 col-sm-1 dateDiv'>
           			<div class="form-group">
	           			<label>방영시작날짜</label><input class="form-control datepicker" name='startDate' readonly>
	           		</div>
           		</div>
           		<div class='col-lg-1 col-md-1 col-sm-1 dateDiv'>
           			<div class="form-group">
	           			<label>방영종료날짜</label><input class="form-control datepicker" name='endDate' readonly>
	           		</div>
           		</div>
           		
           		<div class='col-lg-12 col-md-12 col-sm-12'>
           			
           			<button type="reset" class="btn pull-right btn-default">다시 작성</button>
           			<button type="submit" class="btn pull-right btn-default recordRegisterRegBtn">등록하기</button>
           			<button class="btn pull-right btn-danger dramaDupliConfirmBtn">중복데이터 확인</button>
           		</div>
           	</form>
           </div>
           <!-- /.panel-body -->
       </div>
       <!-- /.panel -->
   </div>
   <!-- /.col-lg-6 -->
</div>
<!-- /.row -->

<!-- 파일첨부 -->

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                File Attach(대표 포스터 하나만 첨부해주세요)
            </div>
            <!-- /.panel-heading -->
           <div class="panel-body">
           	
           		<div class="form-group uploadDiv">
           			<input type='file' name='uploadFile' multiple>
           		</div>
           		<div class='uploadResult'>
           			<ul>
           			
           			</ul>
           		</div>
           	
           </div>
           <!-- /.panel-body -->
       </div>
       <!-- /.panel -->
   </div>
   <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<%@include file="../includes/footer.jsp" %>
<script>
$(document).ready(function(e){
	var formObj=$("form[role='form']");
	var totalEpisode=$("input[name='totalEpisode']").val();
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		var str="";
		$(".uploadResult ul li").each(function(i,obj){
			var jobj=$(obj);
			str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		});
		if($("input[name='title']").val().length==0){
			alert("드라마 제목은 필수값입니다.");
			return $("input[name='title']").focus();
		}
		if(isNaN($("input[name='totalEpisode']").val())==false){
			formObj.append(str).submit();
		}else{
			alert("회차에는 숫자만 입력할 수 있습니다.");
			return $("input[name='totalEpisode']").focus();
		}
		
	});
	
	//첨부파일 사이즈와 확장자 확인
	var regex= new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize=5242880; //5MB
	function checkExtension(fileName,fileSize){
		if(fileSize>=maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	$("input[type='file']").change(function(e){
		var formData=new FormData();
		var inputFile=$("input[name='uploadFile']");
		var files=inputFile[0].files;
		for (var i=0;i<files.length;i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		$.ajax({
			url:'/uploadAjaxAction',
			processData:false,
			contentType:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			data:formData,
			type:'POST',
			dataType:'json',
			success:function(result){
				showUploadResult(result); //업로드 결과 처리 함수
				
			}
		});//$.ajax
	});
	
	//이미 테이블에 들어있는 드라마인지 확인
	$(".dramaDupliConfirmBtn").on("click",function(e){
		e.preventDefault();
		if($("input[name='title']").val()!=""&& $("input[name='startDate']").val()!=""){
			//alert("ghkrdls");
			$.ajax({
				url:"/record/dramaDupliChk",
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				dataType:"json",
				data:{"title":$("input[name='title']").val(),"startDate":$("input[name='startDate']").val()},
				success:function(data){
					if(data==1){
						alert("이미 등록된 드라마입니다.");
					}else{
						$(".dramaDupliConfirmBtn").html("중복확인완료");
					}
				}
			});
		}else{
			alert("드라마 제목과 방영시작날짜를 정확히 입력해주세요");
		}
	});
	
	//첨부파일 목록 보여주기
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr||uploadResultArr.length==0){return;}
		var uploadUL=$(".uploadResult ul");
		var str="";
		$(uploadResultArr).each(
			function(i, obj){
				//image type
				if(obj.image){
					var fileCallPath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					//var originPath=obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
					//originPath=originPath.replace(new RegExp(/\\/g),"/");
					str+="<li data-path='"+obj.uploadPath+"'";
					str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
					str+="<span> "+obj.fileName+" </span>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\'";
					str+=" data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<img src='/display?fileName="+fileCallPath+"'></div></li>";
					//str+="<input type='hidden' name='posterUrl' value='"+fileCallPath+"'>";
					formObj.find("input[name='posterUrl']").val(fileCallPath);
				}else{
					var fileCallPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");
					str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'></div>";
					str+="<span> "+obj.fileName+" </span>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'";
					str+=" class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<i class='fas fa-paperclip' style=font-size:50px></i></div></li>";
				}
		});
		uploadUL.append(str);
	}
	$(".uploadResult").on("click", "button", function(e){
		var targetFile=$(this).data("file");
		var type=$(this).data("type");
		
		var targetLi=$(this).closest("li");
		
		$.ajax({
			url:'/deleteFile',
			data:{fileName:targetFile, type:type},
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			dataType:'text',
			type:'POST',
			success:function(result){
				alert(result);
				targetLi.remove();
			}
		});//$.ajax
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
		  }else{
		    // only 숫자만(부호 미사용, 자릿수구분기호 미사용, 소수점 미사용)
		    var regex = /^[0-9]$/g;
		  }
		 
		  if( regex.test(num) ){
		    num = num.replace(/,/g, "");
		    return isNaN(num) ? false : true;
		  }else{ return false;  }
	}
});
</script>