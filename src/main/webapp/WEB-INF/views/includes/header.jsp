<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>For D - 드라마 기록</title>
    <!-- favicon -->
    <link rel=" shortcut icon" href="/resources/img/favicon.ico">
	<link rel="icon" href="/resources/img/favicon.ico">
    <!-- 폰트 -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Carter+One&family=Nanum+Gothic:wght@400;700;800&family=Do+Hyeon&family=Noto+Sans+KR:wght@100;300;400;700&display=swap" rel="stylesheet">
    <!-- Bootstrap Core CSS -->
    
    <link href="/resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
    

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="../../../resources/css/upload.css"></link>
    <script src="https://kit.fontawesome.com/48245254b4.js" crossorigin="anonymous"></script>
    
	
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/fontawesome-stars.css">
	<link rel="stylesheet" href="/resources/css/fontawesome-stars-o.css">
	
	<link rel="stylesheet" href="/resources/css/slick.css">
	<link rel="stylesheet" href="/resources/css/jquery-ui.css">
	<link rel="stylesheet" href="/resources/css/jquery-ui.theme.css">
	<link rel="stylesheet" href="/resources/css/all.css">
	
	<!-- 내가 만든 css -->
	<link rel="stylesheet" href="/resources/css/recordList.css">
	
	<script type="text/javascript" src="/resources/js/jquery-3.5.1.js"></script>
	
	

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <a class="navbar-brand" href="/">For D</a>
                <sec:authorize access="isAuthenticated()">
                <div class="menu">
					<ul class="firstMenu">
						<li><a href="/watched/list">시청완료</a></li>
						<li><a href="/watching/list">시청중</a></li>
						<li><a href="/wishes/list">시청예정</a></li>
					</ul>
				</div>
				</sec:authorize>
            </div>
            
            <div class='userDiv'>
	            <form class='headerSearchForm' id='headerSearchForm' action='/record/search' method='get'>
		        	<div class="form-group input-group searchDiv">
			            <input type="text" class="form-control" name='keyword' placeholder="검색어를 입력하세요.">
			            <span class="input-group-btn">
			                <button class="btn btn-default" id='headerSearchBtn' type="button"><i class="fa fa-search"></i></button>
			            </span>
			        </div>
		        </form>
				<button class='recordBtn'>기록하기</button>
				<sec:authorize access="isAnonymous()">
					<button class='userBtn loginBtn'>로그인</button>
					<button class='userBtn joinBtn'>회원가입</button>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<a class='userIcon'><i class="far fa-user-circle"></i></a>
					<ul class='dropdown-menu'>
						<li><a class='myInfoA' href="/member/myInfo">마이페이지</a></li>
						<li><a href="/customLogout" class='logoutBtn'>로그아웃</a></li>
					</ul>
					<form class='myPageForm' action='/member/myInfo' method="post">
						<input type='hidden' name='userid' value='<sec:authentication property="principal.username"/>'>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					</form>
				</sec:authorize>
				
				
			</div>
            <!-- /.navbar-header -->

            
            
        </nav>

        <div id="page-wrapper" class='content'>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script type="text/javascript" src="/resources/js/jquery.barrating.js"></script>
        <script type="text/javascript" src="/resources/js/jquery-ui.js"></script>
        <script type="text/javascript" src="/resources/js/slick.js"></script>
        <script>
        $(document).ready(function(){
        	$(".recordBtn").on("click",function(){
        		self.location="/record/list";
        	});
        	$(".loginBtn").on("click",function(){
        		self.location="/customLogin";
        	});
        	$(".joinBtn").on("click",function(){
        		self.location="/member/signUp";
        	});
        	$(".userIcon").on("click",function(){
        		$(".userDiv").toggleClass("open");
        	});
        	$(".myInfoA").on("click",function(e){
        		e.preventDefault();
        		$(".myPageForm").submit();
        	});
        	var csrfHeaderName="${_csrf.headerName}";
        	var csrfTokenValue="${_csrf.token}";
        	$(".logoutBtn").on("click",function(e){
        		e.preventDefault();
        		$(".myPageForm").attr("action","/customLogout").submit();
        		
        	});
        	$("#headerSearchBtn").on("click",function(){
        		$("#headerSearchForm").submit();
        	});
        })
        </script>