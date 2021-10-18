<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">회원관리</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Member List Page
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<!-- 회원관리폼 -->
                        	<form role="form" id='memberAdmin' action="/member/modify" method='post'>
                        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                        	<div class='row'>
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
                            </div>
                            
                            <table width="100%" class="table table-striped table-bordered table-hover" style="margin-top:20px">
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" id='checkAll'></th>
                                        
                                        <th>ID</th>
                                        <th>이름</th>
                                        <th>이메일</th>
                                        <th>가입일</th>
                                        <th>회원정보수정일</th>
                                        <th>등급</th>
                                        
                                    </tr>
                                </thead>
                                
                               <c:forEach items="${list }" var="member">
                               		
                               	<tr>
                               		<td><input type="checkbox" name="userid" class='memberCb' value="<c:out value='${member.userid }'/>"></td>
                               		
                               		<td><c:out value="${member.userid }"/></td>
                               		<td><c:out value="${member.uname }"/></td>
                               		<td><c:out value="${member.userEmail }"/></td>
                               		<td><fmt:formatDate pattern="yyyy.MM.dd kk:mm:ss" value="${member.regDate }"/></td>
                               		<td><fmt:formatDate pattern="yyyy.MM.dd kk:mm:ss" value="${member.updateDate }"/></td>
                               		<td><c:out value="${member.authvo.auth }"/></td>
                               		
                               	</tr>
                               </c:forEach>
                            </table>
                            </form>
                            
                            <!-- 회원검색 폼 -->
                            <div class='row'>
                            	<div class="col-lg-12 col-md-12 col-sm-12">
                            		<form id='searchForm' class='memberSearchForm' action="/member/memberList" method='get'>
                            			<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>'/>
                            			<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount }"/>'/>
                            			<div class="form-group memberSearchSelect">
                            				<select class="form-control" name='type'>
                            					<option value="" <c:out value="${pageMaker.cri.type==null?'selected':'' }"/>>회원 검색</option>
	                            				<option value="I" <c:out value="${pageMaker.cri.type eq 'I'?'selected':'' }"/>>아이디</option>
	                            				<option value="N" <c:out value="${pageMaker.cri.type eq 'N'?'selected':'' }"/>>닉네임</option>
	                            				<option value="A" <c:out value="${pageMaker.cri.type eq 'A'?'selected':'' }"/>>등급</option>
	                            				<option value="IN" <c:out value="${pageMaker.cri.type eq 'IN'?'selected':'' }"/>>아이디 or 닉네임</option>
	                            				<option value="IA" <c:out value="${pageMaker.cri.type eq 'IA'?'selected':'' }"/>>아이디 or 등급</option>
	                            				<option value="IAN" <c:out value="${pageMaker.cri.type eq 'IAN'?'selected':'' }"/>>아이디 or 등급 or 닉네임</option>
                            				</select>
                            			</div>
                            			<div class="form-group input-group searchDiv">
								            <input type="text" class="form-control" name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>' placeholder="검색어를 입력하세요.">
								            <span class="input-group-btn">
								                <button class="btn btn-default" id='memberSearchBtn' type="button"><i class="fa fa-search"></i></button>
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
                            <form id='actionForm' action="/member/memberList" method="get">
                            	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'/>
                            	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'/>
                            	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'/>
                            	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
                            </form>
                            <!-- end Pagination -->
                           <!-- 모달추가 -->
                           
                           <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                           aria-labelledby="myModalLabel" aria-hidden="true">
           					 <div class="modal-dialog">
                				<div class="modal-content">
                    				<div class="modal-header">
				                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
				                            <span>&times;</span>
				                        </button>
				                        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                    				</div>
				                    <div class="modal-body">
				                        <p>처리가 완료되었습니다.</p>
				                    </div>
				                    <div class="modal-footer">
				                    	<button type="button" class="btn btn-primary">작성한 글 확인</button>
				                        <button type="button" class="btn btn-default" data-dismiss="modal">목록보기</button>
				                    </div>
				                </div>
				                <!-- /.modal-comtent -->
				            </div>
				            <!-- /.modal-dialog -->
				        </div>
				        <!-- /.modal -->
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
	//Ajax spring security header...
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});
	var href=window.location;
	var origin=window.location.origin;
	var search=window.location.search;
	var pathname=window.location.pathname;
	var url=pathname+search;
	
	//체크박스 전체선택,해제
	$("#checkAll").on("click",function(){
		if($("#checkAll").prop("checked")){
			$(".memberCb").prop("checked",true);
		}else{
			$(".memberCb").prop("checked",false);
		}
	});
	//pagination 숫자누르면 해당 페이지로 감
	var actionForm=$("#actionForm");
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	//검색
	var searchForm=$("#searchForm");
	$("#memberSearchBtn").on("click",function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요");
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()){
			alert("검색어를 입력하세요");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
	var formObj=$("#memberAdmin");
	//멤버 등급 수정, 삭제버튼
	$('.btn-xs').on("click",function(e){
		e.preventDefault();
		var operation=$(this).data("oper");
		
		if(operation==='remove'){
			var removeConfirm=confirm("회원정보를 삭제하시겠습니까?");
			if(removeConfirm==true){
				deleteMember();
			}else{
				alert("취소하였습니다");
			}
			/* var pageNumTag=$("input[name='pageNum']").clone();
			var amountTag=$("input[name='amount']").clone();
			var keywordTag=$("input[name='keyword']").clone();
			var typeTag=$("input[name='type']").clone();
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag); */
			//alert("삭제버튼");
		}else if(operation==='modify'){
			var selectCheck=$("select[name='auth']").val();
			if(selectCheck==null){
				alert("변경할 등급을 선택해주세요.")
			}else{
				var modifyConfirm=confirm("회원정보를 수정하시겠습니까?");
				if(modifyConfirm==true){
					
					modifyMember();
					
					
				}else{
					alert("취소하였습니다");
				}
			}
		}
		
	});
	
	$(".memberCb").on("click",function(){
		var userid=$(this).val();
		$(this).addClass("cb_checked");
	});
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	//여러개 삭제
	function deleteMember(){
		var useridArr=new Array();
		var userid=$(".memberCb");
		for(var i=0;i<userid.length;i++){
			if(userid[i].checked){
				useridArr.push(userid[i].value);
			}
		}
		if(useridArr.length==0){
			alert("선택된 회원이 없습니다.");
		}else{
			var chk=confirm("정말 삭제하시겠습니까?");
			$.ajax({
				url:'/member/remove',
				type:'POST',
				traditional:true,
				data:{
					useridArr:useridArr
				},
				success:function(jdata){
					if(jdata=1){
						alert("회원이 삭제되었습니다.");
						self.location=url;
						//마지막 페이지에 있는 회원을 모두 삭제했을때 목록 갯수 세서 0이면 해당 pageNum-1 페이지로 가게 해야함
					}else{
						alert("회원삭제에 실패했습니다.");
					}
				}
			});
		}
	};
	//회원 등급 수정 여러개
	function modifyMember(){
		var useridArr=[];
		var auth=$("select[name='auth']").val();
		$("input[name='userid']:checked").each(function(i){
			useridArr.push($(this).val());
		});
		var memberInfo={"auth":auth, "useridArr":useridArr};
		
		var objParams={
				"useridArr":useridArr,
				"auth":$("select[name='auth']").val()
		};
		if(useridArr.length==0){
			alert("선택된 회원이 없습니다.");
		}else{
			var chk=confirm("정말 수정하시겠습니까?");
			if(chk){
				$.ajax({
					url:'/member/modify',
					type:'POST',
					traditional:true,
					data:{
						useridArr:useridArr,
						auth:auth
					},
					success:function(jdata){
						if(jdata=1){
							alert("성공");
							self.location=url;
						}else{
							alert("실패");
						}
					}
				});
			}
			
		}
	};
	
});
</script>