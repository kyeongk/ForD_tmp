<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp" %>
<sec:authentication property="principal" var="pinfo"/>

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
    	<h1 class="page-header">나의 편성표</h1>
    	<hr>
    </div>
</div>
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12 ">
    <p style="text-align:center; font-size:40px; margin-top:150px; font-family: 'Noto Sans KR', sans-serif;">현재 개발중인 서비스입니다.</p>
    <%-- fullCalendar 플러그인 사용할것 --%>
    </div>
</div>




<%@include file="includes/footer.jsp" %>