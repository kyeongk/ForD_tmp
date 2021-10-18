<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>
<sec:authentication property="principal" var="pinfo"/>

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12 recordListHeaderDiv">
        <h1 class="page-header recordListTitle">기록하기</h1>
        <sec:authorize access="isAuthenticated()">
	    <c:if test="${pinfo.authorities eq '[ROLE_ADMIN]'}">
        <!-- <input type="checkbox" id='checkAll'> -->
        <!-- <div class='pageHeaderBtnDiv'> -->
        	<!-- <button id='recordRemoveBtn' data-oper='remove' class="btn btn-sm btn-danger pull-right">삭제</button> -->
        	<button class="btn btn-sm" id='recordRegBtn' type='button'>등록</button>
    	<!-- </div> -->
        </c:if></sec:authorize>
        
        <a class='recordListOrder'>정렬하기 <i class="fas fa-chevron-down"></i></a>
		<ul class="dropdown-menu recordListOrderUl">
			<li><a href="/record/list?order=title">가나다순</a></li>
			<li><a href="/record/list?order=date">최근방영순</a></li>
			<li><a href="/record/list">랜덤정렬</a></li>
		</ul>
        
    	<hr>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<form class='registerForm' action='/watched/registerRecord' method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type='hidden' name='avgScore'>
<input type='hidden' name='all_drama_id' id='allid'>
<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'/>
<input type='hidden' name='amount' value='${pageMaker.cri.amount }'/>
<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
<sec:authorize access="isAuthenticated()">
<input type='hidden' name='userid' value='<sec:authentication property="principal.username"/>'>
</sec:authorize>
<sec:authorize access="isAnonymous()">
<input type='hidden' name='userid' value=''>
</sec:authorize>

</form>
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <div class='recordListDiv'>
			<ul class='list-inline recordUl'>
				<c:forEach items="${list }" var="board">
					<li class=' list-inline-item recordListLi'>
					
						<div class='col-lg-3 col-md-3 col-sm-3 recordImgDiv'>
							<a class='move' href='<c:out value="${board.id }"/>'>
							<c:if test="${board.posterUrl ==null||board.posterUrl==''}">
								<img src='../../resources/img/noImage.jpg' class='posterDiv'>
							</c:if>
							<c:if test="${board.posterUrl !=null&&board.posterUrl.length()>3}">
								<img src='/display?fileName=<c:out value="${board.posterUrl }"/>' class='posterDiv'>
							</c:if>
							</a>
						</div>
						<div class='col-lg-9 col-md-9 col-sm-9'>
							<h3 class='recordTitle'><a class='move' href='<c:out value="${board.id }"/>'><c:out value="${board.title }"/></a>
							<sec:authorize access="isAuthenticated()">
	            			<c:if test="${pinfo.authorities eq '[ROLE_ADMIN]'}">
							<%-- <input type="checkbox" class='idCheckBox' name='id' value="<c:out value='${board.id }'/>"> --%>
							</c:if></sec:authorize></h3>
							<div class='recordDetailTd'><fmt:formatDate pattern="yyyy" value="${board.startDate }"/> ・ <c:out value="${board.broadcastingName }"/> ・ <c:out value="${board.state }"/> </div>
							<div class='recordRatingDiv'>
								<select class="recordRating">
								  <option value></option>
								  <option value="1">1</option>
								  <option value="2">2</option>
								  <option value="3">3</option>
								  <option value="4">4</option>
								  <option value="5">5</option>
								</select>
								<input type='hidden' name="all_drama_id" value='${board.id }'>
								<div class='icons'>
									<i class="far fa-eye watchingIcon" data-id='<c:out value="${board.id }"/>'>
										<span class='tooltiptext watchingText'>시청중</span>
									</i>
									<i class="far fa-heart wishesIcon" data-id='<c:out value="${board.id }"/>'>
										<span class='tooltiptext wishesText'>시청예정</span></i>
								</div>
							</div>
							
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- pagination -->
<div class='b-pagination center-block'>
	<ul class="pagination">
		<c:if test="${pageMaker.prev }">
			<li class="paginate_button previous"><a href="${pageMaker.startPage-1 }">Previous</a></li>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
			<li class="paginate_button ${pageMaker.cri.pageNum==num ? "active" : "" }"><a href="${num }">${num}</a></li>
		</c:forEach>
		<c:if test="${pageMaker.next }">
			<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
		</c:if>
	</ul>
</div>
<form id='actionForm' action="/record/list" method="get">
	
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'/>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'/>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
	<input type='hidden' name='order' value='<c:out value="${pageMaker.cri.order }"/>'/>
</form>
<!-- end Pagination -->
<div class='topDiv'>TOP</div>
<script type="text/javascript" src="/resources/js/recordList.js"></script>
<%@include file="../includes/footer.jsp" %>

