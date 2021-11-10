<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">드라마관리</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Drama List Page
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<!-- 드라마관리폼 -->
                        	<form role="form" id='memberAdmin' action="/member/modify" method='post'>
                        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                        	<%-- <div class='row'>
                            	<div class="col-lg-12 col-md-12 col-sm-12">
                            		<div class="form-group memberSearchSelect">
                           				<select class="form-control" name='auth'>
                           					<option value="" <c:out value="${pageMaker.cri.type==null?'selected':'' }"/>>등급변경</option>
	                           				<option value="A" <c:out value="${pageMaker.cri.type eq 'A'?'selected':'' }"/>>ADMIN</option>
	                           				<option value="M" <c:out value="${pageMaker.cri.type eq 'M'?'selected':'' }"/>>MEMBER</option>
	                           				<option value="U" <c:out value="${pageMaker.cri.type eq 'U'?'selected':'' }"/>>USER</option>
                           				</select>
                            		</div>
                           			<button data-oper='modify' class="btn btn-default btn-xs pull-right memberModifyBtn">회원등급수정</button>
									<button data-oper='remove' class="btn btn-danger btn-xs pull-right membetRemoveBtn">회원 삭제</button>
                            		
                            	</div>
                            </div> --%>
                            
                            <table width="100%" class="table table-striped table-bordered table-hover" style="margin-top:20px">
                                <thead>
                                    <tr class='listForAdminCenter'>
                                        <th><input type="checkbox" id='checkAll'></th>
                                        
                                        <th>ID</th>
                                        <th>제목</th>
                                        <th>방송사</th>
                                        <th>총회차수</th>
                                        <th>
                                        <div class="form-group listForAdminSelect">
                            				<select class="form-control" name='state' id='stateSearch'>
                            					<option value="" <c:out value="${pageMaker.cri.keyword==null?'selected':'' }"/>>방영상태</option>
	                            				<option value="방영중" <c:out value="${pageMaker.cri.keyword eq '방영중'?'selected':'' }"/>>방영중</option>
	                            				<option value="방영종료" <c:out value="${pageMaker.cri.keyword eq '방영종료'?'selected':'' }"/>>방영종료</option>
	                            				<option value="방영예정" <c:out value="${pageMaker.cri.keyword eq '방영예정'?'selected':'' }"/>>방영예정</option>
	                            				<option value="상시방영중" <c:out value="${pageMaker.cri.keyword eq '상시방영중'?'selected':'' }"/>>상시방영중</option>
                            				</select>
                            			</div>
                                        </th>
                                        <th>방영시작일</th>
                                        <th>방영종료일</th>
                                        <th>방영요일</th>
                                        <th>평균점수</th>
                                        <th>시청자수</th>
                                        <th>포스터사진</th>
                                        
                                    </tr>
                                </thead>
                                
                               <c:forEach items="${list }" var="drama">
                               		
                               	<tr>
                               		<td><input type="checkbox" name="id" class='memberCb' value="<c:out value='${drama.id }'/>"></td>
                               		
                               		<td class='listForAdminCenter'><c:out value="${drama.id }"/></td>
                               		<td><c:out value="${drama.title }"/></td>
                               		<td class="listForAdminCenter"><c:out value="${drama.broadcastingName }"/></td>
                               		<td class='listForAdminCenter'><c:out value="${drama.totalEpisode }"/></td>
                               		<td><c:out value="${drama.state }"/></td>
                               		<td class='listForAdminCenter'><fmt:formatDate pattern="yyyy.MM.dd" value="${drama.startDate }"/></td>
                               		<td class='listForAdminCenter'><fmt:formatDate pattern="yyyy.MM.dd" value="${drama.endDate }"/></td>
                               		<td><c:out value="${drama.dayOfWeek }"/></td>
                               		<td class='listForAdminCenter'><c:out value="${drama.avgScore }"/></td>
                               		<td class='listForAdminCenter'><c:out value="${drama.viewCount }"/></td>
                               		<td class='listForAdminCenter'>
                               			<c:if test="${drama.posterUrl.length()>3 }">Y</c:if>
                               			<c:if test="${drama.posterUrl.length()<3 }">N</c:if></td>
                               		
                               	</tr>
                               </c:forEach>
                            </table>
                            </form>
                            
                            <!-- 드라마검색 폼 -->
                            <div class='row'>
                            	<div class="col-lg-12 col-md-12 col-sm-12">
                            		<form id='searchForm' class='memberSearchForm' action="/record/listForAdmin" method='get'>
                            			<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>'/>
                            			<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount }"/>'/>
                            			<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
                            			<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
                            			<div class="form-group stateSearchSelect">
                            				<select class="form-control" name='state'>
                            					<option value="" <c:out value="${pageMaker.cri.type.indexOf('S')>-1&&pageMaker.cri.state==null?'selected':'' }"/>>방영상태</option>
	                            				<option value="방영중" <c:out value="${pageMaker.cri.type.indexOf('S')>-1&&pageMaker.cri.state eq '방영중'?'selected':'' }"/>>방영중</option>
	                            				<option value="방영종료" <c:out value="${pageMaker.cri.type.indexOf('S')>-1&&pageMaker.cri.state eq '방영종료'?'selected':'' }"/>>방영종료</option>
	                            				<option value="방영예정" <c:out value="${pageMaker.cri.type.indexOf('S')>-1&&pageMaker.cri.state eq '방영예정'?'selected':'' }"/>>방영예정</option>
	                            				<option value="상시방영중" <c:out value="${pageMaker.cri.type.indexOf('S')>-1&&pageMaker.cri.state eq '상시방영중'?'selected':'' }"/>>상시방영중</option>
                            				</select>
                            			</div>
                            			<div class="form-group dayOfWeekSearch">
					           				<label class='recordRegLabel'>방영요일 : </label>
					                        <label class="checkbox-inline">
					                           <input type="checkbox" name='dayOfWeek' value='mon' <c:out value="${pageMaker.cri.dayOfWeek.indexOf('mon')>-1?'checked':'' }"/>>월
					                        </label>
					                        <label class="checkbox-inline">
					                           <input type="checkbox" name='dayOfWeek' value='tue' <c:out value="${pageMaker.cri.dayOfWeek.indexOf('tue')>-1?'checked':'' }"/>>화
					                        </label>
					                        <label class="checkbox-inline">
					                           <input type="checkbox" name='dayOfWeek' value='wed' <c:out value="${pageMaker.cri.dayOfWeek.indexOf('wed')>-1?'checked':'' }"/>>수
					                        </label>
					                        <label class="checkbox-inline">
					                           <input type="checkbox" name='dayOfWeek' value='thu' <c:out value="${pageMaker.cri.dayOfWeek.indexOf('thu')>-1?'checked':'' }"/>>목
					                        </label>
					                        <label class="checkbox-inline">
					                           <input type="checkbox" name='dayOfWeek' value='fri' <c:out value="${pageMaker.cri.dayOfWeek.indexOf('fri')>-1?'checked':'' }"/>>금
					                        </label>
					                        <label class="checkbox-inline">
					                           <input type="checkbox" name='dayOfWeek' value='sat' <c:out value="${pageMaker.cri.dayOfWeek.indexOf('sat')>-1?'checked':'' }"/>>토
					                        </label>
					                        <label class="checkbox-inline">
					                           <input type="checkbox" name='dayOfWeek' value='sun' <c:out value="${pageMaker.cri.dayOfWeek.indexOf('sun')>-1?'checked':'' }"/>>일
					                        </label>
					           			</div>
                            			<div class="form-group input-group titleSearch">
								            <input type="text" class="form-control" name='title' value='<c:out value="${pageMaker.cri.title }"/>' placeholder="검색어를 입력하세요.">
								            <span class="input-group-btn">
								                <button class="btn btn-default" id='titleSearchBtn' type="button"><i class="fa fa-search"></i></button>
								            </span>
								        </div>
                            		</form>
                            		
                            	</div>
                            </div>
                            
                            <!-- pagination -->
                            <div class='pull-right'>
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
                            <form id='actionForm' action="/record/listForAdmin" method="get">
                            	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'/>
                            	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'/>
                            	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
                            	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
                            	<input type='hidden' name='state' value='<c:out value="${pageMaker.cri.state }"/>'/>
                            	<input type='hidden' name='title' value='<c:out value="${pageMaker.cri.title }"/>'/>
                            	<input type='hidden' name='dayOfWeek' value='<c:out value="${pageMaker.cri.dayOfWeek }"/>'/>
                            </form>
                            <!-- end Pagination -->
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
<%@include file="../includes/footer.jsp" %>
<script>
$(document).ready(function(){
	var formObj=$("#searchForm");
	$("#stateSearch").on("change",function(){
		if($(this).val()=='방영중'){
			formObj.find("select>option[value='방영중']").attr('selected','');
		}else if($(this).val()=='방영예정'){
			formObj.find("select>option[value='방영예정']").attr('selected','');
		}else if($(this).val()=='방영종료'){
			formObj.find("select>option[value='방영종료']").attr('selected','');
		}else if($(this).val()=='상시방영중'){
			formObj.find("select>option[value='상시방영중']").attr('selected','');
		}else{
			formObj.find("select>option[value='']").attr('selected','');
		}
		formObj.find("input[name='type']").val('S');
		formObj.submit();
		
	});
	$("#titleSearchBtn").on("click",function(e){
		e.preventDefault();
		var typeVal="";
		if(formObj.find("select[name='state']").val()!=""){
			typeVal+="S";
		}
		if(formObj.find("input[name='dayOfWeek']:checked").length!=0){
			typeVal+="D";
		}
		if(formObj.find("input[name='title']").val()!=""){
			typeVal+="T";
		}
		formObj.find("input[name='type']").val(typeVal);
		formObj.submit();
	});
	//pagination 숫자누르면 해당 페이지로 감
	var actionForm=$("#actionForm");
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
})
</script>