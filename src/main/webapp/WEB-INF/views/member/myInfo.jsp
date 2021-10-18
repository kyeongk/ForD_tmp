<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-md-4 col-md-offset-4">
    	<h1 class="loginTitle">회원정보</h1>
        <div class="panel panel-default">
            
                <form role="form" action="/member/modifyByUser" method="POST" class='myInfoForm'>
	            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	            	<div class="table-responsive table-bordered">
                   		<table class="table myInfoTable">
                   			<tr>
                   				<td>아이디</td>
                   				<td><input class="form-control joinInput" name='userid' placeholder="ID" readonly value='<c:out value="${member.userid }"/>'></td>
                   				<td></td>
                   			</tr>
                   			<tr>
                   				<td>닉네임</td>
                   				<td>
	                   				<input class="form-control joinInput" name='uname' placeholder="Name" value='<c:out value="${member.uname }"/>' data-id='Y'>
	                   				<p class="help-block" id='namecheck'></p>
                   				</td>
                   				<td></td>
                   			</tr>
                   			<tr>
                   				<td>비밀번호</td>
                   				<td>
	                  				<input class="form-control joinInput" type='password' name='userpw' placeholder="Password" data-id='N'>
	                  				<p class="help-block" id='pwcheck'></p>
                   				</td>
                   				<td></td>
                   			</tr>
                   			<tr>
                   				<td>비밀번호 확인</td>
                   				<td>
	                   				<input class="form-control joinInput" type='password' id='pwcheckInput' placeholder="Password Check" data-id='N'>
	                   				<p class="help-block" id='pwcheckcheck'></p>
	                   			</td>
                   				<td><button class="btn myInfoBtn" id='modifyPwBtn'>변경하기</button></td>
                   			</tr>
                   			<tr>
                   				<td>이메일</td>
                   				<td>
	                   				<input class="form-control joinInput" type='text' name='userEmail' placeholder="Email" value='<c:out value="${member.userEmail }"/>' data-id='Y'>
	                   				<p class="help-block" id='emailcheck'></p>
                   				</td>
                   				<td><button class="btn myInfoBtn" value='Y' id='emailDupliBtn'>중복확인</button></td>
                   			</tr>
                   			<tr>
                   				<td></td>
                   				<td class='myInfoBtnTd'>
	                   				<button class="btn myInfoBtn" id='memberModifyBtn'>회원 수정</button>
	                   				<button class="btn myInfoRemoveBtn" id='memberRemoveBtn'>회원 탈퇴</button>
                   				</td>
                   				<td></td>
                   			</tr>
                   		</table>
                   	</div>
	            </form>
            
        </div>
    </div>
</div>
      
<%@include file="../includes/footer.jsp" %>
<script>
$(document).ready(function(e){
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	//Ajax spring security header...
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});
	var formObj=$(".myInfoForm");
	var originalUserEmail='<c:out value="${member.userEmail }"/>';
	var modifyResult='<c:out value="${modifyResult }"/>';
	$("#memberModifyBtn").on("click",function(e){
		e.preventDefault();
		var userpw=$("input[name='userpw']").data("id");
		var pwcheckInput=$("#pwcheckInput").data("id");
		var userEmail=$("input[name='userEmail']").data("id");
		var uname=$("input[name='uname']").data("id");
		var emailDupli=$("#emailDupliBtn").val();
		var inputPw=$("input[name='userpw']").val();
		if(userpw=="Y"&&pwcheckInput=="Y"&&userEmail=="Y"&&uname=="Y"&&emailDupli=="Y"){
			$.ajax({
				url:"/member/checkPwRemoveMember",
				type:"post",
				contentType:"text/html; charset=utf-8;",
				data:inputPw,
				success:function(data){
					if(data=="true"){
						$(".myInfoForm").submit();
					}else if(data=="false"){
						alert("비밀번호가 일치하지 않습니다.");
					}
				}
			});
		}else{
			alert("회원정보를 정확하게 입력해주세요.");
		}
	});
	if(modifyResult=='success'){
		alert("변경되었습니다.");
		$(".myPageForm").submit();
	}
	//비밀번호만 변경
	$("#modifyPwBtn").on("click",function(e){
		e.preventDefault();
		var userpw=$("input[name='userpw']").data("id");
		var pwcheckInput=$("#pwcheckInput").data("id");
		if(userpw=="Y"&&pwcheckInput=="Y"){
			formObj.attr("action","/member/modifyPwByUser").submit();
		}else{
			alert("비밀번호 양식에 맞게 입력해주세요.");
		}
	});
	//회원탈퇴
	$("#memberRemoveBtn").on("click",function(e){
		e.preventDefault();
		var userpw=$("input[name='userpw']").data("id");
		var pwcheckInput=$("#pwcheckInput").data("id");
		var inputPw=$("input[name='userpw']").val();
		if(userpw=="Y"&&pwcheckInput=="Y"){
			$.ajax({
				url:"/member/checkPwRemoveMember",
				type:"post",
				contentType:"text/html; charset=utf-8;",
				data:inputPw,
				success:function(data){
					if(data=="true"){
						var chk=confirm("탈퇴시 작성된 리뷰가 모두 삭제됩니다. 계속하시겠습니까?");
						if(chk==true){
							$(".myInfoForm").attr("action","/member/removeByUser");
							$(".myInfoForm").submit();
						}else{
							return;
						}
					}else if(data=="false"){
						alert("비밀번호를 정확히 입력해야 탈퇴가 가능합니다.");
					}
				}
			});
		}else{
			alert("비밀번호 양식에 맞게 입력해주세요.");
		}
	});
	
	
	var empC=/\s/g;
	
	var pwC=/^(?=.*[a-z])(?=.*[0-9])(?=.*[#?!@$%^&-_]).{8,16}$/;
	var nameC=/^[가-힣A-Za-z0-9]{1,10}$/;
	var emailC=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	$("input[name='userpw']").on("keyup",function(){
		$("input[name='userpw']").attr("data-id","N");
		if($("input[name='userpw']").val()==""){
			$("#pwcheck").html("공백은 입력하실 수 없습니다.");
			$("input[name='userpw']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
		}else{
			if(pwC.test($("input[name='userpw']").val())){
				$("#pwcheck").html("사용가능한 비밀번호입니다.");
				$("input[name='userpw']").attr("data-id","Y");
				$("input[name='userpw']").css({"border-color":"#008000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(1 222 1 / 60%)"});
			}else{
				$("#pwcheck").html("8~16자 사이의 소문자와 숫자,특수문자를 모두 입력해주세요.");
				$("input[name='userpw']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
			}
		}
	});
	$("#pwcheckInput").on("keyup",function(){
		$("#pwcheckInput").attr("data-id","N");
		if($("input[name='userpw']").val()==$("#pwcheckInput").val()){
			$("#pwcheckcheck").html("비밀번호를 맞게 입력하셨습니다.");
			$("#pwcheckInput").attr("data-id","Y");
			$("#pwcheckInput").css({"border-color":"#008000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(1 222 1 / 60%)"});
		}else{
			$("#pwcheckcheck").html("비밀번호를 정확하게 입력해주세요.");
			$("#pwcheckInput").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
		}
	});
	$("input[name='userEmail']").on("keyup",function(){
		$("input[name='userEmail']").attr("data-id","N");
		$("#emailDupliBtn").attr("value","N");
		$("#emailDupliBtn").html("중복확인");
		$("#emailDupliBtn").css({"background-color":"white","color":"black"});
		if($("input[name='userEmail']").val()==""){
			$("#emailcheck").html("공백은 입력하실 수 없습니다.");
			$("input[name='userEmail']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
		}else{
			if(emailC.test($("input[name='userEmail']").val())){
				$("#emailcheck").html("사용가능한 이메일입니다.");
				$("input[name='userEmail']").attr("data-id","Y");
				$("input[name='userEmail']").css({"border-color":"#008000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(1 222 1 / 60%)"});
			}else{
				$("#emailcheck").html("이메일 주소를 정확하게 입력해주세요.");
				$("input[name='userEmail']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
			}
		}
		if(originalUserEmail==$("input[name='userEmail']").val()){
			$("input[name='userEmail']").attr("data-id","Y");
			$("#emailDupliBtn").attr("value","Y");
		}
	});
	$("input[name='uname']").on("keyup",function(){
		$("input[name='uname']").attr("data-id","N");
		if($("input[name='uname']").val()==""){
			$("#namecheck").html("공백은 입력하실 수 없습니다.");
			$("input[name='uname']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
		}else{
			if(nameC.test($("input[name='uname']").val())){
				$("#namecheck").html("사용가능한 닉네임입니다.");
				$("input[name='uname']").attr("data-id","Y");
				$("input[name='uname']").css({"border-color":"#008000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(1 222 1 / 60%)"});
			}else{
				$("#namecheck").html("닉네임을 정확하게 입력해주세요.");
				$("input[name='uname']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
			}
		}
	});
	
	//이메일 중복체크
	$("#emailDupliBtn").on("click",function(e){
		e.preventDefault();
		if($("input[name='userEmail']").data("id")=="Y"){
			$.ajax({
				url:"/member/emailDupliChk",
				type:"post",
				dataType:"json",
				data:{"userEmail":$("input[name='userEmail']").val()},
				success:function(data){
					if(data==1){
						if($("input[name='userEmail']").val()==originalUserEmail){
							$("#emailDupliBtn").attr("value","Y");
							$("#emailDupliBtn").html("중복확인 완료");
							$("#emailDupliBtn").css({"background-color":"#c184ff","color":"white"});
						}else{
							alert("중복된 이메일 입니다.");
						}
					}else if(data==0){
						$("#emailDupliBtn").attr("value","Y");
						$("#emailDupliBtn").html("중복확인 완료");
						$("#emailDupliBtn").css({"background-color":"#c184ff","color":"white"});
					}
				}
			});
		}else{
			alert("이메일 양식에 맞게 입력해주세요.")
		}
		
	});
	
});
</script>