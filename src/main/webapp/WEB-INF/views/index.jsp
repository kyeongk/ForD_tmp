<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="includes/header.jsp" %>
<sec:authentication property="principal" var="pinfo"/>

<div class="row">
<form action="/record/get" method="get">
	<sec:authorize access="isAuthenticated()">
	
    <c:if test="${watchingList.size()>0 }">
    <%-- <c:if test="${pinfo.username eq watchingList.userid}"> --%>
	    <div class="col-lg-12 mainDiv2">
	        <div class='slideDiv'>
	        	<h3 class='mainDiv2Title'>지금 시청중인 드라마</h3>
	        	<ul class='list-inline mainUl slide3'>
	        	
	        		<c:forEach items="${watchingList }" var="board">
	        		
	        		<%-- <c:if test="${pinfo.username eq board.userid }"> --%>
		        		<li class='list-inline-item'>
		        			<div class='col-lg-12 mainDiv'>
								<div class='imgDiv'>
									<a class='move' href='<c:out value="${board.id }"/>'>
										<c:if test="${board.posterUrl ==null||board.posterUrl==''}">
											<img src='../../resources/img/noImage.jpg'>
										</c:if>
										<c:if test="${board.posterUrl !=null&&board.posterUrl.length()>3}">
											<img alt='${board.title } 포스터이미지' src='/display?fileName=<c:out value="${board.posterUrl }"/>'>
										</c:if>
									</a>
								</div>
								<div class='titleDiv'><a class='move' href='<c:out value="${board.id }"/>'><c:out value="${board.title }"/></a></div>
								<div class='dramaInfoDiv'><fmt:formatDate pattern="yyyy" value="${board.startDate }"/> ・ <c:out value="${board.broadcastingName }"/> ・ <c:out value="${board.state }"/><c:if test="${board.dayOfWeek.indexOf(todayOfWeek)>-1 && board.state=='방영중'}"> ・ <span class="todayOnAirIcon"><i class="fas fa-bell"></i> Today!</span></c:if> </div>
								<div class='scoreDiv'>
									<c:if test="${board.avgScore==null ||board.avgScore==0.0}"></c:if>
									<c:if test="${board.avgScore!=null &&board.avgScore!=0.0}">평균 <i class='fas fa-star indexStar'></i> <c:out value="${board.avgScore }"/></c:if>
								</div>
							</div>
		        		</li>
		        	<%-- </c:if> --%>
	        		</c:forEach>
	        	</ul>
	        </div>
	    </div>
    <!-- /.col-lg-12 -->
    <%-- </c:if>  --%>
    </c:if>
    <c:if test="${watchingList.size()==0 }"><p> </p></c:if>
    </sec:authorize>
    <div class="col-lg-12 mainDiv1">
        <div class='slideDiv'>
        	<h3 class='mainDiv1Title'>현재 방영중인 드라마</h3>
        	<ul class='slide list-inline mainUl'>
        		<c:forEach items="${onAirList }" var="board">
	        		<li class='list-inline-item'>
	        			<div class='col-lg-12 mainDiv'>
							<div class='imgDiv'>
								<a class='move' href='<c:out value="${board.id }"/>'>
									<c:if test="${board.posterUrl ==null||board.posterUrl==''}">
										<img src='../../resources/img/noImage.jpg'>
									</c:if>
									<c:if test="${board.posterUrl !=null&&board.posterUrl.length()>3}">
										<img alt='${board.title } 포스터이미지' src='/display?fileName=<c:out value="${board.posterUrl }"/>'>
									</c:if>
								</a>
							</div>
							<div class='titleDiv'><a class='move' href='<c:out value="${board.id }"/>'><c:out value="${board.title }"/></a></div>
							<div class='dramaInfoDiv'><fmt:formatDate pattern="yyyy" value="${board.startDate }"/> ・ <c:out value="${board.broadcastingName }"/><c:if test="${board.dayOfWeek.indexOf(todayOfWeek)>-1}"> ・ <span class="todayOnAirIcon"><i class="fas fa-bell"></i> Today!</span></c:if> </div>
							<div class='scoreDiv'>
								<c:if test="${board.avgScore==null ||board.avgScore==0.0}"></c:if>
								<c:if test="${board.avgScore!=null &&board.avgScore!=0.0}">평균 <i class='fas fa-star indexStar'></i> <c:out value="${board.avgScore }"/></c:if>
							</div>
						</div>
	        		</li>
        		</c:forEach>
        	</ul>
        </div>
    </div>
    <!-- /.col-lg-12 -->
    <c:if test="${expectedList.size()>0 }">
	    <div class="col-lg-12 mainDiv2">
	        <div class='slideDiv'>
	        	<h3 class='mainDiv2Title'>방영예정 드라마</h3>
	        	<ul class='list-inline mainUl slide2'>
	        		<c:forEach items="${expectedList }" var="board">
		        		<li class='list-inline-item'>
		        			<div class='col-lg-12 mainDiv'>
								<div class='imgDiv'>
									<a class='move' href='<c:out value="${board.id }"/>'>
										<c:if test="${board.posterUrl ==null||board.posterUrl==''}">
											<img src='../../resources/img/noImage.jpg'>
										</c:if>
										<c:if test="${board.posterUrl !=null&&board.posterUrl.length()>3}">
											<img alt='${board.title } 포스터이미지' src='/display?fileName=<c:out value="${board.posterUrl }"/>'>
										</c:if>
									</a>
								</div>
								<div class='titleDiv'><a class='move' href='<c:out value="${board.id }"/>'><c:out value="${board.title }"/></a></div>
								<div class='dramaInfoDiv'><fmt:formatDate pattern="yyyy" value="${board.startDate }"/> ・ <c:out value="${board.broadcastingName }"/> </div>
								<div class='scoreDiv'>
									<c:if test="${board.avgScore==null ||board.avgScore==0.0}"></c:if>
									<c:if test="${board.avgScore!=null &&board.avgScore!=0.0}">평균 <i class='fas fa-star indexStar'></i> <c:out value="${board.avgScore }"/></c:if>
								</div>
							</div>
		        		</li>
	        		</c:forEach>
	        	</ul>
	        </div>
	    </div>
    <!-- /.col-lg-12 -->
    </c:if>
    <c:if test="${expectedList.size()==0 }"><p></p></c:if>
    
    
</form>
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12 col-md-12 ">
        
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->



<%@include file="includes/footer.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$(".slide").slick({
		prevArrow : "<i class='slick-prev fas fa-angle-left mainSlide1Prev'></i>", 
		nextArrow : "<i class='slick-next fas fa-angle-right mainSlide1next'></i>",
		arrows:true,
		infinite: false,
		centerPadding:"20px",
		variableWidth:true,
		slidesToShow:6,
		slidesToScroll:6
	});
	$(".slide2").slick({
		prevArrow : "<i class='slick-prev fas fa-angle-left mainSlide1Prev'></i>", 
		nextArrow : "<i class='slick-next fas fa-angle-right mainSlide1next'></i>",
		///arrows:true,
		infinite: false,
		centerPadding:"20px",
		variableWidth:true,
		slidesToShow:6,
		slidesToScroll:6
	});
	$(".slide3").slick({
		prevArrow : "<i class='slick-prev fas fa-angle-left mainSlide1Prev'></i>", 
		nextArrow : "<i class='slick-next fas fa-angle-right mainSlide1next'></i>",
		arrows:true,
		infinite: false,
		centerPadding:"20px",
		variableWidth:true,
		slidesToShow:6,
		slidesToScroll:6
	});
	$(".move").on("click",function(e){
		e.preventDefault();
		$("form").append("<input type='hidden' name='all_drama_id' value='"+$(this).attr("href")+"'>");
		$("form").submit();
	});
});
</script>