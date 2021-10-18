<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-md-4 col-md-offset-4">
    	<h1 class="loginTitle">회원가입</h1>
        <div class="panel panel-default">
            <div class="panel-body">
                <form role="form" action="/member/signUp" method="post">
	            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	            	
                   		<table class="table myInfoTable">
                   			<tr>
                   				<td>아이디</td>
                   				<td><input class="form-control joinInput" type='text' name='userid' placeholder="ID" autofocus data-id='N'><p class="help-block" id='idcheck'></p></td>
                   				<td><button class="btn signUpBtn" value='N' id='idDupliBtn'>중복확인</button></td>
                   			</tr>
                   			<tr>
                   				<td>비밀번호</td>
                   				<td><input class="form-control joinInput" type='password' name='userpw' placeholder="Password" data-id='N'><p class="help-block" id='pwcheck'></p></td>
                   				<td></td>
                   			</tr>
                   			<tr>
                   				<td>비밀번호 확인</td>
                   				<td><input class="form-control joinInput" type='password' id='pwcheckInput' placeholder="Password Check" data-id='N'><p class="help-block" id='pwcheckcheck'></td>
                   				<td></td>
                   			</tr>
                   			<tr>
                   				<td>이메일</td>
                   				<td><input class="form-control joinInput" type='text' name='userEmail' placeholder="Email" data-id='N'><p class="help-block" id='emailcheck'></p></td>
                   				<td><button class="btn signUpBtn" value='N' id='emailDupliBtn'>중복확인</button></td>
                   			</tr>
                   			<tr>
                   				<td>닉네임</td>
                   				<td><input class="form-control joinInput" type='text' name='uname' placeholder="Name" data-id='N'><p class="help-block" id='namecheck'></p></td>
                   				<td></td>
                   			</tr>
                   			<tr>
                   				<td colspan="3"><button type="submit" class="btn btn-lg btn-block joinSubmitBtn">회원가입(Sign Up)</button></td>
                   			</tr>
                   		</table>
	            </form>
            </div>
        </div>
    </div>
</div>
      
<%@include file="../includes/footer.jsp" %>
<script>
$(document).ready(function(e){
	var formObj=$("form[role='form']");
	var signUpFailText='<c:out value="${result}"/>';
	if(signUpFailText.length>5){
		alert(signUpFailText);
	}
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		var userid=$("input[name='userid']").data("id");
		var userpw=$("input[name='userpw']").data("id");
		var pwcheckInput=$("#pwcheckInput").data("id");
		var userEmail=$("input[name='userEmail']").data("id");
		var uname=$("input[name='uname']").data("id");
		var idDupli=$("#idDupliBtn").val();
		var emailDupli=$("#emailDupliBtn").val();
		if(userid=="Y"&&userpw=="Y"&&pwcheckInput=="Y"&&userEmail=="Y"&&uname=="Y"&&idDupli=="Y"&&emailDupli=="Y"){
			formObj.submit();
		}else{
			alert("회원가입 양식을 정확하게 입력해주세요.");
			if(userid=="N"){
				return $("input[name='userid']").focus();
			}else if(userpw=="N"){
				return $("input[name='userpw']").focus();
			}else if(userEmail=="N"){
				return $("input[name='userEmail']").focus();
			}else if(uname=="N"){
				return $("input[name='uname']").focus();
			}else if(idDupli=="N"){
				return $("#idDupliBtn").focus();
			}else if(emailDupli=="N"){
				return $("#emailDupliBtn").focus();
			}
		}
		
	});
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	//Ajax spring security header...
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});
	
	var empC=/\s/g;
	var idC=/^[a-z0-9]{4,15}$/;
	var pwC=/^(?=.*[a-z])(?=.*[0-9])(?=.*[#?!@$%^&-_]).{8,16}$/;
	var nameC=/^[가-힣A-Za-z0-9]{1,10}$/;
	var emailC=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	$("input[name='userid']").on("keyup",function(){
		$("#idDupliBtn").attr("value","N");
		$("input[name='userid']").attr("data-id","N");
		$("#idDupliBtn").html("중복확인");
		$("#idDupliBtn").css({"background-color":"white","color":"black"});
		if($("input[name='userid']").val()==""){
			$("#idcheck").html("공백은 입력하실 수 없습니다.");
			$("input[name='userid']").attr("data-id","N");
			$("input[name='userid']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
		}else{
			if(idC.test($("input[name='userid']").val())){
				$("#idcheck").html("사용가능한 아이디입니다.");
				$("input[name='userid']").attr("data-id","Y");
				$("input[name='userid']").css({"border-color":"#008000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(1 222 1 / 60%)"});
			}else{
				$("#idcheck").html("4~15자 사이의 소문자와 숫자를 입력해주세요.");
				$("input[name='userid']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
			}
		}
	});
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
				$("#pwcheck").html("8~16자 사이의 소문자와 숫자, 특수문자를 모두 입력해주세요.");
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
	
	//아이디,이메일 중복체크
	$("#idDupliBtn").on("click",function(e){
		e.preventDefault();
		if($("input[name='userid']").data("id")=="Y"&&$("input[name='userid']").val()!=""){
			$.ajax({
				url:"/member/idDupliChk",
				type:"post",
				dataType:"json",
				data:{"userid":$("input[name='userid']").val()},
				success:function(data){
					if(data===1){
						alert("중복된 아이디 입니다.");
						$("#idDupliBtn").attr("value","N");
						return;
					}else{
						$("#idDupliBtn").attr("value","Y");
						$("#idDupliBtn").html("중복확인 완료");
						$("#idDupliBtn").css({"background-color":"#c184ff","color":"white"});
					}
				}
			});
		}else{
			alert("아이디를 양식에 맞게 입력해주세요");
		}
	});
	$("#emailDupliBtn").on("click",function(e){
		e.preventDefault();
		if($("input[name='userEmail']").data("id")=="Y"&& $("input[name='userEmail']").val()!=""){
			$.ajax({
				url:"/member/emailDupliChk",
				type:"post",
				dataType:"json",
				data:{"userEmail":$("input[name='userEmail']").val()},
				success:function(data){
					if(data==1){
						alert("중복된 이메일 입니다.");
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