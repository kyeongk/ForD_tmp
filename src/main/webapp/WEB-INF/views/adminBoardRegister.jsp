<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp" %>


<div class="row">
    <div class="col-md-6 col-md-offset-3">
    	<h1 class="footerTitle">관리자 게시판 게시글 등록</h1>
        <div class="panel panel-default">
            <div class="panel-body">
                <form role="form" action="/adminBoardRegister" method='post'>
                    <fieldset>
                    	<div class="form-group">
		           			<label>카테고리</label>
		           			<select class="form-control" name='category'>
		           				<option value="공지사항">공지사항</option>
		           				<option value="이벤트">이벤트</option>
		           				<option value="FAQ">FAQ</option>
		           			</select>
		           		</div>
                        <div class="form-group">
                            <input class="form-control" placeholder="제목" name="subject" type="text" autofocus>
                        </div>
                        <div class="form-group">
                            <textarea class="form-control" rows='6' placeholder="내용" name="content"></textarea>
                        </div>
                        <div class="panel panel-default">
				            <div class="panel-heading">
				                File Attach(대표 이미지 하나만 첨부해주세요)
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
                        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                        <!-- Change this to a button or input when using this as a form -->
                        <button type='submit' class="btn btn-lg btn-block loginSubmitBtn">등록하기</button>
                    </fieldset>
                </form>
            </div>
            
        </div>
    </div>
    
</div>
<%@include file="includes/footer.jsp" %>
<script>
$(document).ready(function(){
	var formObj=$("form[role='form']");
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
		formObj.append(str).submit();
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
					var fileCallPathO=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					//var originPath=obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
					//originPath=originPath.replace(new RegExp(/\\/g),"/");
					str+="<li data-path='"+obj.uploadPath+"'";
					str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
					str+="<span> "+obj.fileName+" </span>";
					str+="<button type='button' data-file=\'"+fileCallPath+"\'";
					str+=" data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str+="<img src='/display?fileName="+fileCallPath+"'></div></li>";
					str+="<input type='hidden' name='imgUrl' value='"+fileCallPathO+"'>";
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
		$("input[name='imgUrl']").val("");
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
})
</script>