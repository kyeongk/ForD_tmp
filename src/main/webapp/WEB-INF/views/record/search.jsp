<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>
<sec:authentication property="principal" var="pinfo"/>


<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12">
        <h1 class="page-header ">검색결과</h1>
    	<hr>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12 ">
        <div class=''>
			<ul class='list-inline watchedListUl'>
				<c:forEach items="${list }" var="board">
					<li class=' list-inline-item'>
						<div class='col-lg-12 col-md-12 col-sm-12 watchedList'>
							<div class='imgDiv'>
								<a class='move' href='<c:out value="${board.id }"/>'>
								<c:if test="${board.posterUrl ==null}">
									<img src='../../resources/img/recordtestimg.jpg'>
								</c:if>
								<c:if test="${board.posterUrl !=null}">
									<img src='/display?fileName=<c:out value="${board.posterUrl }"/>'>
								</c:if>
								</a>
							</div>
							<div class='titleDiv'><a class='move' href='<c:out value="${board.id }"/>'><c:out value="${board.title }"/></a></div>
							<div class='scoreDiv'>평균 평점 ★ <c:out value="${board.avgScore }"/></div>
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
<form id='actionForm' action="/watched/list" method="get">
	
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'/>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'/>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
	
</form>
<!-- end Pagination -->

<%@include file="../includes/footer.jsp" %>

<script>
$(document).ready(function(){
	
	var actionForm=$("#actionForm");
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	$(".move").on("click",function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='all_drama_id' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action","/record/get");
		actionForm.submit();
	});
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	var search=window.location.search;
	var pathname=window.location.pathname;
	var url=pathname+search;
})

</script>