<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>
<sec:authentication property="principal" var="pinfo"/>

<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12 wListHeaderDiv">
        <h1 class="page-header listHeader">시청중
        </h1>
        <a class='wListOrder'>정렬하기 <i class="fas fa-chevron-down"></i></a>
		<ul class="dropdown-menu wListOrderUl">
			<li><a href="/watching/list?order=title">가나다순</a></li>
			<li><a href="/watching/list?order=date">최근방영순</a></li>
			<li><a href="/watching/list">랜덤정렬</a></li>
		</ul>
        <div class='watchedListDiv'>
        	<form id='searchForm' action='/watched/list' method='get'>
	        	<div class="form-group input-group searchDiv">
		            <input type="text" class="form-control" name='keyword' placeholder="검색어를 입력하세요.">
		            <span class="input-group-btn">
		                <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
		            </span>
		        </div>
		        <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>'/>
                <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount }"/>'/>
                <input type='hidden' name='order' value='<c:out value="${pageMaker.cri.order }"/>'/>
	        </form>
    	</div>
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
				
					<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.userid }">
					<li class=' list-inline-item'>
						<div class='col-lg-12 col-md-12 col-sm-12 watchedList'>
							<div class='imgDiv'>
								<a class='move' href='<c:out value="${board.all_drama_id }"/>'>
								<c:if test="${board.allDramaVO.posterUrl ==null||board.allDramaVO.posterUrl ==''}">
									<img src='../../resources/img/noImage.jpg'>
								</c:if>
								<c:if test="${board.allDramaVO.posterUrl !=null&&board.allDramaVO.posterUrl.length()>3}">
									<img src='/display?fileName=<c:out value="${board.allDramaVO.posterUrl }"/>'>
								</c:if>
								</a>
							</div>
							<div class='titleDiv'><a class='move' href='<c:out value="${board.all_drama_id }"/>'><c:out value="${board.allDramaVO.title }"/></a></div>
							<div class='scoreDiv'><c:out value="${board.allDramaVO.totalEpisode }"/>회 중 <c:if test="${board.replayCount>0 }"><c:out value="${board.replayCount }"/>회 정주행 중</c:if><c:if test="${board.replayCount==0 }"><c:out value="${board.watchedEpiNumber }"/>회 시청중</c:if></div>
						</div>
					</li>
					</c:if>
					</sec:authorize>
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
<form id='actionForm' action="/watching/list" method="get">
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'/>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'/>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
	<input type='hidden' name='order' value='<c:out value="${pageMaker.cri.order }"/>'/>
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
	
	
	var searchForm=$("#searchForm");
	$("#searchForm button").on("click",function(e){
		if(!searchForm.find("input[name='keyword']").val()){
			alert("검색어를 입력하세요");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
	$(".wListOrder").on("click",function(){
		$(this).find("i").toggleClass("fa-flip-vertical");
		$(".wListHeaderDiv").toggleClass("open");
	});
  
      
   
	

})

</script>