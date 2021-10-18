<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp" %>


<div class="row">
    <div class="col-md-4 col-md-offset-4">
    	<div class='signUpTextDiv'></div>
    	<h1 class="loginTitle">로그인</h1>
        <div class="panel panel-default">
            <div class="panel-body">
                <form role="form" action="/login" method='post'>
                    <fieldset>
                        <div class="form-group">
                            <input class="form-control loginInput" placeholder="ID" name="username" type="text" data-id="N" autofocus>
                        	<p class="help-block" id='idcheck'></p>
                        </div>
                        <div class="form-group">
                            <input class="form-control loginInput" placeholder="Password" name="password" type="password" data-id="N"value="">
                        	<p class="help-block" id='pwcheck'></p>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input name="remember-me" type="checkbox">로그인 유지
                            </label>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                        <!-- Change this to a button or input when using this as a form -->
                        <a href="#" class="btn btn-lg btn-block loginSubmitBtn">로그인(Login)</a>
                    </fieldset>
                </form>
                <!-- <a class='findPw' href='#'>비밀번호 찾기</a> -->
                
            </div>
        </div>
    </div>
</div>





<%@include file="includes/footer.jsp" %>
<script>
$(document).ready(function(){
	var uid='<c:out value="${result}"/>';
	var errorMsg='<c:out value="${error}"/>';
	if(uid.length>3){
		var str="<p class='useridText'><span class='idText'>"+uid+"<span>님</p><p class='signUpSuccessText'>회원가입을 축하드립니다!</p>";
		$(".signUpTextDiv").html(str);
	}
	$(".loginSubmitBtn").on("click",function(e){
		e.preventDefault();
		var userid=$("input[name='username']").data("id");
		var userpw=$("input[name='password']").data("id");
		if(userid=="Y"&&userpw=="Y"){
			$("form").submit();
		}else{
			alert("아이디와 비밀번호를 양식에 맞게 입력해주세요.");
			if(userid=="N"){
				return $("input[name='username']").focus();
			}else if(userpw=="N"){
				return $("input[name='password']").focus();
			}
		}
		
	});
	var input=$("input[name='password']");
	$("input[name='password']").keydown(function(e){
		if(e.keyCode == 13){
			e.preventDefault();
			$(".loginSubmitBtn").click();
		}
	});
	var empC=/\s/g;
	var idC=/^[a-z0-9]{4,15}$/;
	var pwC=/^(?=.*[a-z])(?=.*[0-9])(?=.*[#?!@$%^&-_]).{8,16}$/;
	
	$("input[name='username']").on("keyup",function(){
		$("input[name='username']").attr("data-id","N");
		if($("input[name='username']").val()==""){
			$("#idcheck").html("공백은 입력하실 수 없습니다.");
			$("input[name='username']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
		}else{
			if(idC.test($("input[name='username']").val())){
				$("#idcheck").html("");
				$("input[name='username']").attr("data-id","Y");
				$("input[name='username']").css({"border-color":"#008000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(1 222 1 / 60%)"});
			}else{
				$("#idcheck").html("4~15자 사이의 소문자와 숫자를 입력해주세요.");
				$("input[name='username']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
			}
		}
	});
	$("input[name='password']").on("keyup",function(){
		$("input[name='password']").attr("data-id","N");
		if($("input[name='password']").val()==""){
			$("#pwcheck").html("공백은 입력하실 수 없습니다.");
			$("input[name='password']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
		}else{
			if(pwC.test($("input[name='password']").val())){
				$("#pwcheck").html("");
				$("input[name='password']").attr("data-id","Y");
				$("input[name='password']").css({"border-color":"#008000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(1 222 1 / 60%)"});
			}else{
				$("#pwcheck").html("");
				$("input[name='password']").css({"border-color":"#ff0000","box-shadow":"inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 5px rgb(255 0 0 / 60%)"});
			}
		}
	});
	//로그인 실패시 뜨는 알러트 창
	if(errorMsg.length>3){
		alert(errorMsg);
	}
	
})

</script>



