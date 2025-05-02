<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%-- <fmt:requestEncoding value="utf-8" /> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	var msg = "<c:out value='${msg}' />";
	if (msg) {
		alert(msg);
		if (msg === "로그인성공")
			window.location.href = "<c:url value='/main' />";
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#selectLan").val("${param.lang}").change(function() {
			var chVal = $(this).val();
			console.log("선택한 언어:", chVal); // 디버깅용 로그
			if (chVal != '') {
				location.href = "/multilang2?lang=" + chVal;
			}
		});
	});
</script>
<style type="text/css">
.bg-gradient-primary {
	background-color: #a85c00 !important;
	background-image: linear-gradient(180deg, #F0E68C, #7B3F00) !important;
	background-size: cover !important;
}
div.form-group i{
    position: absolute;
    left: 77%;
    bottom: 51%;
}
#numCk {
  font-size: 15px;
  color: red;
  position: absolute;
  bottom:60%
}
</style>
<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-primary">
	<div class="container">
		<!-- Outer Row -->
		<div class="row justify-content-center">
			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body-->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-login-image">
								<img src="http://192.168.0.106:2222/upload/coffeehouse.png" alt="" />
							</div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">
											<spring:message code="Login" />
											<!-- (주)커피하우스 로그인 -->
										</h1>

										<div class="text-right">
											<select id="selectLan">
												<option value=""><spring:message code="chlan" /></option>
												<option value="ko"><spring:message code="ko" /></option>
												<option value="en"><spring:message code="en" /></option>
											</select>
										</div>
									</div>
									<!-- 	<form class="user" method="post" > -->
									<form class="user" method="post" action="prjLogin">

										<div class="form-group">

											<input type="text" class="form-control form-control-user"
												id="exampleInputEmail" aria-describedby="emailHelp"
												name="empno" placeholder='<spring:message code="pen"/>'>
											<span style="font-size: 12px;" id="numCk"></span>
										</div>
										<br>
										<div class="form-group">
											<input type="password" class="form-control form-control-user"
												name="pwd" id="exampleInputPassword"
												placeholder='<spring:message code="epwd"/>'>
												<i class="fa fa-eye fa-lg"></i>
										</div>
										<span style="font-size: 20px;" id="cantLogin"></span>
										<div class="form-group">
											<div class="custom-control custom-checkbox small">
												<input type="checkbox" class="custom-control-input"
													id="customCheck"> <label
													class="custom-control-label" for="customCheck"> <spring:message
														code="rm" /> <!-- Remember Me -->
												</label>
											</div>
										</div>
										<a href="javascript:login()"
											class="btn btn-primary btn-user btn-block"> <spring:message
												code="login2" /> <!-- Login  -->
										</a>
									</form>
									<hr>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/a00_com/vendor/jquery/jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
	       $('.form-group i').on('click',function(){
	           $('input').toggleClass('active');
	           if($('input').hasClass('active')){
	               $(this).attr('class',"fa fa-eye-slash fa-lg")
	               .prev('input').attr('type',"text");
	           }else{
	               $(this).attr('class',"fa fa-eye fa-lg")
	               .prev('input').attr('type','password');
	           }
	       });
	   });
		function login() {
			if ($("#exampleInputEmail").val() != ""
					&& $("#exampleInputPassword").val() != ""
					&& $("#numCk").text() == "") {
				$("form").submit();
			} else {
				$("#cantLogin").text("사원번호와 비밀번호를 확인해주세요!").css("color", "red");
			}
		}

		$("#exampleInputEmail").on("keyup", function() {
			var value = $(this).val();
			if (!/^\d*$/.test(value)) { // 숫자가 아닌 경우
				$("#numCk").text("숫자만 입력해주세요!").css("color", "red");
			} else {
				$("#numCk").text(""); // 정상 입력이면 메시지 삭제
			}
		})

		$("#exampleInputPassword").on("keyup", function(key) {
			if (key.keyCode == 13) {
				login()
			}
		})
	</script>
	<!-- Bootstrap core JavaScript-->
	<script
		src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="${path}/a00_com/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="${path}/a00_com/js/demo/chart-area-demo.js"></script>
	<script src="${path}/a00_com/js/demo/chart-pie-demo.js"></script>
</body>
</html>
