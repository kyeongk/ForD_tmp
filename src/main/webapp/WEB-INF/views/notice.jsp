<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp" %>
<sec:authentication property="principal" var="pinfo"/>

<div class="row">
    <div class="col-md-6 col-md-offset-3">
    	<h1 class="footerTitle">공지사항</h1>
    	<sec:authorize access="isAuthenticated()">
    	<c:if test="${pinfo.authorities eq '[ROLE_ADMIN]' }">
    	<button class='adminBoardRegBtn col-md-offset-11'>등록</button>
    	</c:if></sec:authorize>
        <div class="panel panel-default">
            <div class="panel-body adminBoardDiv">
                <ul>
	                <c:forEach items="${list }" var="board">
	                	<li>
	                		<button class='collapsible'>
	                			<div class='adminBoardTitle'>
	                				<div class='adminBoardTitleText'><strong>[<c:out value="${board.category }"/>] </strong><c:out value="${board.subject }"/></div>
	                				<div class='adminBoardRegDate'><fmt:formatDate pattern="yyyy/MM/dd" value="${board.regDate }"/></div>
	                			</div>
	                			<div class='plusIcon'>
	                				<i class="fas fa-chevron-down"></i>
	                			</div>
	                			
	                		</button>
	                		<sec:authorize access="isAuthenticated()">
	                		<c:if test="${pinfo.authorities eq '[ROLE_ADMIN]' }">
	                		<div class='adminBoardModBtn' data-id='<c:out value="${board.id }"/>'>수정</div>
	                		</c:if></sec:authorize>
	                		<div class='adminContent'>
	                			<article class='contentArticle'><c:if test="${board.imgUrl!=null &&board.imgUrl.length()>3 }"><img class='adminBoardImg' alt="공지사항 이미지" src='/display?fileName=<c:out value="${board.imgUrl }"/>'><br></c:if>${board.content }</article>
	                		</div>
	                	</li>
	                </c:forEach>
                	
                </ul>
            </div>
            
        </div>
    </div>
</div>
<form class='modifyForm' action='/adminBoardModify' method="get">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type='hidden' name='id' id='allid'>
<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'/>
<input type='hidden' name='amount' value='${pageMaker.cri.amount }'/>
<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
</form>




<%@include file="includes/footer.jsp" %>
<script>
$(document).ready(function(){
	/* var registerMove="<c:out value="${result }"/>";
	if(registerMove=="FAQ"){
		self.location="/FAQ";
	} */
	var formObj=$(".modifyForm");
	$(".adminBoardRegBtn").on("click",function(){
		self.location="/adminBoardRegister";
	});
	$(".adminBoardModBtn").on("click",function(){
		$("#allid").val($(this).data("id"));
		formObj.submit();
	});
	var coll=$(".collapsible");
	for (var i=0;i<coll.length;i++){
		coll[i].addEventListener("click",function(){
			$(this).toggleClass("active");
			$(this).find(".fa-chevron-down").toggleClass("fa-flip-vertical");
			var content=$(this).siblings(".adminContent");
			var height=$("article").outerHeight(true)+"px";
			if(content.css("height")==height){
				content.css({"height":"0"});
			}else{
				content.css({"height":height});
			}
		});
	}
})
</script>