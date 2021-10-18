<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        </div>
        <!-- /#page-wrapper -->
	<footer>
		<div class="row">
		    <div class="col-lg-12">
		        <div class='footerP'>
					<ul class="footerMenu">
						<li><a href="/notice">공지사항</a></li>
						<li><a href="/FAQ">문의하기</a></li>
						<li><a href="https://forms.gle/UzEVUFFxuS5NBEYM9" target="_blank">DB추가/수정</a></li>
						<sec:authentication property="principal" var="pinfo"/>
						<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.authorities eq '[ROLE_ADMIN]' }">
						<li><a href="/member/memberList">멤버리스트(관리자용)</a></li>
						<li><a href="/record/listForAdmin">드라마리스트(관리자용)</a></li>
						
						
						</c:if>
						</sec:authorize>
					</ul>
				</div>
		    </div>
		    <!-- /.col-lg-12 -->
		</div>
	</footer>
    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <!-- <script src="/resources/vendor/jquery/jquery.min.js"></script> -->

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="/resources/js/jquery.barrating.js"></script>
    <script type="text/javascript" src="/resources/js/jquery-ui.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>

</body>

</html>
