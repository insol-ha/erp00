<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
<script type="text/javascript">
	var msg = "<c:out value='${msg}' />";
	var empno = "${sesEmp.empno}"
	var ename = "${sesEmp.ename}"
	if (msg) {
		alert("사원번호"+empno+"\n"+ename+"님"+msg);
		if (msg === "로그인성공")
			window.location.href = "<c:url value='/main' />";
	}
</script>
<style type="text/css">
.bg-gradient-primary {
	background-color: #a85c00 !important;
	background-image: linear-gradient(180deg, #F0E68C, #7B3F00) !important;
	background-size: cover !important;
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
										<h1 class="h4 text-gray-900 mb-4">(주)커피하우스 로그인</h1>
									</div>
									<form class="user" method="post">
										<div class="form-group">
											<input type="text" class="form-control form-control-user"
												id="exampleInputEmail" aria-describedby="emailHelp"
												name="empno" placeholder="사원번호를 입력하세요">
										</div>
										<div class="form-group">
											<input type="password" class="form-control form-control-user"
												name="pwd" id="exampleInputPassword"
												placeholder="비밀번호를 입력하세요">
										</div>
										<div class="form-group">
											<div class="custom-control custom-checkbox small">
												<input type="checkbox" class="custom-control-input"
													id="customCheck"> <label
													class="custom-control-label" for="customCheck">Remember
													Me</label>
											</div>
										</div>
										<a href="javascript:login()"
											class="btn btn-primary btn-user btn-block"> Login </a>

									</form>
									<hr>
									<div class="text-center">
										<a class="small" href="forgot-password.html">Forgot
											Password?</a>
									</div>
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
			function login() {
				$("form").submit();
			}

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
