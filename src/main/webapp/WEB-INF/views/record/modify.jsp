<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <h1 class="page-header">드라마 수정하기</h1>
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
           	<form role="form" action="/record/modify" method="post">
           		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
           		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
           		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
           		<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'/>
           		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'/>
           		<input type='hidden' name='id' value='<c:out value="${board.id }"/>'/>
           		<input type='hidden' name='posterUrl' value='<c:out value="${board.posterUrl }"/>'>
           		<div class='col-lg-2 col-md-2 col-sm-2'>
           			<div class="form-group">
	           			<label>드라마 제목</label><input class="form-control" name='title' value='<c:out value="${board.title }"/>' autofocus>
	           		</div>
           		</div>
           		<div class='col-lg-3 col-md-3 col-sm-3'>
           			<div class="form-group">
           				<label class='recordRegLabel'>방영요일</label><br>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='mon' <c:out value="${board.dayOfWeek.indexOf('mon')>-1?'checked':'' }"/>>월
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='tue' <c:out value="${board.dayOfWeek.indexOf('tue')>-1?'checked':'' }"/>>화
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='wed' <c:out value="${board.dayOfWeek.indexOf('wed')>-1?'checked':'' }"/>>수
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='thu' <c:out value="${board.dayOfWeek.indexOf('thu')>-1?'checked':'' }"/>>목
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='fri' <c:out value="${board.dayOfWeek.indexOf('fri')>-1?'checked':'' }"/>>금
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='sat' <c:out value="${board.dayOfWeek.indexOf('sat')>-1?'checked':'' }"/>>토
                        </label>
                        <label class="checkbox-inline">
                           <input type="checkbox" name='dayOfWeek' value='sun' <c:out value="${board.dayOfWeek.indexOf('sun')>-1?'checked':'' }"/>>일
                        </label>
           			</div>
           		</div>
           		<div class='col-lg-3 col-md-3 col-sm-3 stateDiv'>
           			<div class="form-group">
                       <label class='recordRegLabel'>상태</label><br>
                       <label class="radio-inline">
                           <input type="radio" name="state" id="optionsRadiosInline1" value="방영예정" <c:out value="${board.state eq '방영예정'?'checked':'' }"/>>방영예정
                       </label>
                       <label class="radio-inline">
                           <input type="radio" name="state" id="optionsRadiosInline2" value="방영중" <c:out value="${board.state eq '방영중'?'checked':'' }"/>>방영중
                       </label>
                       <label class="radio-inline">
                           <input type="radio" name="state" id="optionsRadiosInline3" value="방영종료" <c:out value="${board.state eq '방영종료'?'checked':'' }"/>>방영종료
                       </label>
                       <label class="radio-inline">
                           <input type="radio" name="state" id="optionsRadiosInline4" value="상시방영중" <c:out value="${board.state eq '상시방영중'?'checked':'' }"/>>상시방영중
                       </label>
                	</div>
           		</div>
           		<div class='col-lg-1 col-md-1 col-sm-1 totalEpiDiv'>
           			<div class="form-group">
           			<label>총 회차</label><input class="form-control" name='totalEpisode' value='<c:out value="${board.totalEpisode }"/>'>
           		</div>
           		</div>
           		<div class='col-lg-1 col-md-1 col-sm-1 broadDiv'>
           			<div class="form-group">
	           			<label>방송사</label><%-- <input class="form-control" name='broadcastingName' value='<c:out value="${board.broadcastingName }"/>'> --%>
	           			<select class="form-control" name='broadcastingName'>
	           				<option value="KBS2" <c:out value="${board.broadcastingName eq 'KBS2'?'selected':'' }"/>>KBS2</option>
	           				<option value="MBC" <c:out value="${board.broadcastingName eq 'MBC'?'selected':'' }"/>>MBC</option>
	           				<option value="SBS" <c:out value="${board.broadcastingName eq 'SBS'?'selected':'' }"/>>SBS</option>
	           				<option value="tvN" <c:out value="${board.broadcastingName eq 'tvN'?'selected':'' }"/>>tvN</option>
	           				<option value="JTBC" <c:out value="${board.broadcastingName eq 'JTBC'?'selected':'' }"/>>JTBC</option>
	           				<option value="OCN" <c:out value="${board.broadcastingName eq 'OCN'?'selected':'' }"/>>OCN</option>
	           				<option value="NETFLIX" <c:out value="${board.broadcastingName eq 'NETFLIX'?'selected':'' }"/>>NETFLIX</option>
	           				<option value="WATCHA" <c:out value="${board.broadcastingName eq 'WATCHA'?'selected':'' }"/>>WATCHA</option>
	           				<option value="KBS1" <c:out value="${board.broadcastingName eq 'KBS1'?'selected':'' }"/>>KBS1</option>
	           				<option value="TVING" <c:out value="${board.broadcastingName eq 'TVING'?'selected':'' }"/>>TVING</option>
	           				<option value="TV조선" <c:out value="${board.broadcastingName eq 'TV조선'?'selected':'' }"/>>TV조선</option>
	           				<option value="MBN" <c:out value="${board.broadcastingName eq 'MBN'?'selected':'' }"/>>MBN</option>
	           				<option value="채널A" <c:out value="${board.broadcastingName eq '채널A'?'selected':'' }"/>>채널A</option>
	           				<option value="MBC드라마넷" <c:out value="${board.broadcastingName eq 'MBC드라마넷'?'selected':'' }"/>>MBC드라마넷</option>
	           				<option value="DRAMAcube" <c:out value="${board.broadcastingName eq 'DRAMAcube'?'selected':'' }"/>>DRAMAcube</option>
	           				<option value="SBS플러스" <c:out value="${board.broadcastingName eq 'SBS플러스'?'selected':'' }"/>>SBS플러스</option>
	           				<option value="투니버스" <c:out value="${board.broadcastingName eq '투니버스'?'selected':'' }"/>>투니버스</option>
	           				<option value="Mnet" <c:out value="${board.broadcastingName eq 'Mnet'?'selected':'' }"/>>Mnet</option>
	           				<option value="OCN Movies" <c:out value="${board.broadcastingName eq 'OCN Movies'?'selected':'' }"/>>OCN Movies</option>
	           				<option value="MBC every1" <c:out value="${board.broadcastingName eq 'MBC every1'?'selected':'' }"/>>MBC every1</option>
	           				<option value="네이버TV" <c:out value="${board.broadcastingName eq '네이버TV'?'selected':'' }"/>>네이버TV</option>
	           				<option value="OCN Thrills" <c:out value="${board.broadcastingName eq 'OCN Thrills'?'selected':'' }"/>>OCN Thrills</option>
	           				<option value="E채널" <c:out value="${board.broadcastingName eq 'E채널'?'selected':'' }"/>>E채널</option>
	           				<option value="Olive" <c:out value="${board.broadcastingName eq 'Olive'?'selected':'' }"/>>Olive</option>
	           				<option value="MBC QueeN" <c:out value="${board.broadcastingName eq 'MBC QueeN'?'selected':'' }"/>>MBC QueeN</option>
	           				<option value="KBS Drama" <c:out value="${board.broadcastingName eq 'KBS Drama'?'selected':'' }"/>>KBS Drama</option>
	           				<option value="OBS 경인TV" <c:out value="${board.broadcastingName eq 'OBS 경인TV'?'selected':'' }"/>>OBS 경인TV</option>
	           				<option value="MBC M" <c:out value="${board.broadcastingName eq 'MBC M'?'selected':'' }"/>>MBC M</option>
	           				<option value="드라맥스" <c:out value="${board.broadcastingName eq '드라맥스'?'selected':'' }"/>>드라맥스</option>
	           				<option value="미정" <c:out value="${board.broadcastingName eq '미정'?'selected':'' }"/>>미정</option>
	           				<option value="" <c:out value="${board.broadcastingName==null?'selected':'' }"/>></option>
	           			</select>
	           		</div>
           		</div>
           		<div class='col-lg-1 col-md-1 col-sm-1 dateDiv'>
           			<div class="form-group">
	           			<label>방영시작날짜</label><input class="form-control datepicker" name='startDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.startDate }"/>' readonly>
	           		</div>
           		</div>
           		<div class='col-lg-1 col-md-1 col-sm-1 dateDiv'>
           			<div class="form-group">
	           			<label>방영종료날짜</label><input class="form-control datepicker" name='endDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.endDate }"/>' readonly>
	           		</div>
           		</div>
           		
           		<div class='col-lg-12 col-md-12 col-sm-12' style="text-align:right">
	           		<button type="submit" data-oper='list' class="btn pull-right btn-info">뒤로가기</button>
	           		<button type="submit" data-oper='modify' class="btn pull-right btn-default recordRegisterRegBtn">수정하기</button>
           		</div>
           		<div class='col-lg-12 col-md-12 col-sm-12 posterUrlDiv'>
           		
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
<!-- 첨부파일목록 -->
<div class='bigPictureWrapper'>
	<div class='bigPicture'> </div>
</div>
<!-- 파일첨부 -->

<div class="row">
    <div class="col-lg-12">
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
$(document).ready(function(){
	
	//데이트피커
	$( ".datepicker" ).datepicker({
		changeMonth: true,
	      changeYear: true,
	      dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
	      monthNames:[ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	      monthNamesShort:[ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	      dateFormat: "yy/mm/dd"
	});
	//기존에 있던 첨부파일목록 출력
	(function(){
		var id='<c:out value="${board.id}"/>';
		
		$.getJSON("/record/getAttachList", {id:id}, function(arr){
			var str="";
			$(arr).each(function(i, attach){
				//image type
				if(attach.fileType){
					var fileCallPath=encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					str+="<li data-path='"+attach.uploadPath+"'";
					str+=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str+="<span> "+attach.fileName+" </span><br>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\'";
					str+=" data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<img src='/display?fileName="+fileCallPath+"'></div></li>";
					//str+="<input type='hidden' name='posterUrl' value='"+fileCallPath+"'>";
					//formObj.find("input[name='posterUrl']").val(fileCallPath);
				}else{
					str+="<li data-path='"+attach.uploadPath+"'";
					str+=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'></div>";
					str+="<span> "+attach.fileName+" </span><br>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'";
					str+=" class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<i class='fas fa-paperclip' style=font-size:50px></i></div></li>";
				}
			});
			$(".uploadResult ul").html(str);
		});//end getjson
	})();//end function
	
	//첨부파일 삭제할지 물어보는 함수
	$(".uploadResult").on("click","button", function(e){
		if(confirm("Remove this file? ")){
			var targetLi=$(this).closest("li");
			targetLi.remove();
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
			data:formData,
			type:'POST',
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			}, 
			dataType:'json',
			success:function(result){
				showUploadResult(result); //업로드 결과 처리 함수
				
			}
		});//$.ajax
	});
	//새로 추가한 첨부파일 목록 보여주기
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr||uploadResultArr.length==0){return;}
		var uploadUL=$(".uploadResult ul");
		var str="";
		//var str2="";
		//var posterUrl=$(".posterUrlDiv");
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
					//str2+="<input type='text' name='posterUrl' value='"+fileCallPath+"'>";
					$("input[name='posterUrl']").val(fileCallPath);
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
		//posterUrl.append(str2);
	}
	
	//수정버튼 눌렀을때 update, back눌렀을때 리스트로 되돌아가는 함수
	var formObj=$("form");
	
	$('button').on("click",function(e){
		e.preventDefault();
		var operation=$(this).data("oper");
		
		if(operation==='list'){
			formObj.attr("action","/record/list").attr("method","get");
			var pageNumTag=$("input[name='pageNum']").clone();
			var amountTag=$("input[name='amount']").clone();
			var keywordTag=$("input[name='keyword']").clone();
			var typeTag=$("input[name='type']").clone();
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}else if(operation==='modify'){
			var str="";
			$(".uploadResult ul li").each(function(i,obj){
				var jobj=$(obj);
				str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});
			formObj.append(str).submit();
			
		}
		formObj.submit();
	});
	
});

</script>