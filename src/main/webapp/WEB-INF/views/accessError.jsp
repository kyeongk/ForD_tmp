<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.*" %>
<%@include file="includes/header.jsp" %>

<h1 class="accessError">이 페이지는 관리자만 접근가능한 페이지입니다.</h1>

<h2 class="accessError"><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage() }"/></h2>
<h2 class="accessError"><c:out value="${msg }"/></h2>

<%@include file="includes/footer.jsp" %>