<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="includes/header.jsp" %>

        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Logout Page</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" action="/customLogout" method='post'>
                            <fieldset>
                                <!-- Change this to a button or input when using this as a form -->
                                <a href="index.html" class="btn btn-lg btn-success btn-block">Logout</a>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                        </form>
                    </div>
                </div>
            </div>
        </div>


<%@include file="includes/footer.jsp" %>
    <script>
    $(".btn-success").on("click",function(e){
    	e.preventDefault();
    	$("form").submit();
    });
    </script>
<c:if test="${param.logout != null }">
    <script>
    $(document).ready(function(){
    	alert("로그아웃하였습니다.");
    });
    </script>
    	
</c:if>

