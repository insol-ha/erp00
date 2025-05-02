<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>
<style>
tbody tr:hover {
	background-color: lightgray;
}

.profile-img img {
	width: 150px !important;
	height: 250px !important;
	object-fit: cover !important;
}

.up {
	position: relative;
	bottom: 100px;
}
</style>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - 사원정보</title>

<!-- Custom fonts for this template -->
<link href="a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="a00_com/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="a00_com/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<script src="a00_com/vendor/jquery/jquery.min.js"></script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<c:import url="/WEB-INF/views/sidebar.jsp" />

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<c:import url="/WEB-INF/views/header.jsp" />
					<!-- Topbar Search -->

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid" id="vueCon">


					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">사원프로필</h1>
					<div class="container emp-profile">
						<form method="post">
							<div class="row">
								<div class="col-md-4">
									<div class="profile-img">
										<!-- 이미지 표시 영역 -->
										<img id="preview"
											src="http://192.168.0.106:2222/upload/empno_${param.empno}.png"
											alt="프로필 이미지" />

										<!-- 파일 업로드 버튼 -->
										<div class="file btn btn-lg btn-primary">
											사진 변경 <input id="fileInput" type="file" name="file"
												accept="image/*" />
										</div>
									</div>
									<script>
										var empno = "${param.empno}"
										document.getElementById("fileInput").addEventListener("change", function(event) {
										    const file = event.target.files[0]; // 선택한 파일 가져오기
										
										    if (file) {
										        const reader = new FileReader(); // 파일을 읽을 FileReader 객체 생성
										        reader.onload = function(e) {
										            document.getElementById("preview").src = e.target.result; // 미리보기 업데이트
										        };
										        reader.readAsDataURL(file); // 파일을 Base64 URL로 변환하여 미리보기
										
										        // 📌 서버로 파일 즉시 업로드
										        const formData = new FormData();
										        formData.append("file", file);
										        formData.append("customFileName", "empno_" + empno + ".png"); // 새로운 파일명 지정
										
										        fetch("http://192.168.0.106:2222/pngUpload", {
										            method: "POST",
										            body: formData
										        })
										        .then(response => response.text()) // 서버 응답 받기
										        .then(data => {
										            console.log("서버 응답:", data);
										        })
										        .catch(error => {
										            console.error("업로드 오류:", error);
										        });
										    }
										});
									</script>
								</div>
								<div class="col-md-6">
									<div class="profile-head">
										<h5>${emp.ename}</h5>
										<h6>부서 : ${emp.dname}</h6>
										<h6>직급 : ${emp.jname}</h6>
										<ul class="nav nav-tabs" id="myTab" role="tablist">
											<li class="nav-item"><a class="nav-link active"
												id="home-tab" data-toggle="tab" href="#home" role="tab"
												aria-controls="home" aria-selected="true">프로필</a></li>
											<li class="nav-item"><a class="nav-link"
												id="profile-tab" data-toggle="tab" href="#profile"
												role="tab" aria-controls="profile" aria-selected="false">세부
													프로필</a></li>
										</ul>
									</div>
								</div>
								<div class="col-md-2">
								</div>
							</div>
							<div class="row up">
								<div class="col-md-4">
									<div class="profile-work">
										<!-- 개인 SNS, 작업물 등등 링크 -->
									</div>
								</div>
								<div class="col-md-8">
									<div class="tab-content profile-tab" id="myTabContent">
										<div class="tab-pane fade show active" id="home"
											role="tabpanel" aria-labelledby="home-tab">
											<div class="row">
												<div class="col-md-6">
													<label>사원번호</label>
												</div>
												<div class="col-md-6">
													<input name="empno" class="form-control"
														value="${emp.empno}" />
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<label>사원명</label>
												</div>
												<div class="col-md-6">
													<input name="ename" class="form-control"
														value="${emp.ename}" />
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<label>이메일</label>
												</div>
												<div class="col-md-6">
													<input name="email" class="form-control"
														value="${emp.email}" />
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<label>전화번호</label>
												</div>
												<div class="col-md-6">
													<input name="pnum" class="form-control" value="${emp.pnum}" />
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<label>부서</label>
												</div>
												<div class="col-md-6">
													<input name="job" class="form-control" value="${emp.dname}" />
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<label>직책</label>
												</div>
												<div class="col-md-6">
													<input name="job" class="form-control" value="${emp.jname}" />
												</div>
											</div>
										</div>
										<div class="tab-pane fade" id="profile" role="tabpanel"
											aria-labelledby="profile-tab">
											<div class="row">
												<div class="col-md-6">
													<label>주민등록번호</label>
												</div>
												<div class="col-md-6">
													<input name="rrn" class="form-control" value="" />
												</div>
											</div>

											<div class="row">
												<div class="col-md-6">
													<label>주소</label>
												</div>
												<div class="col-md-6">
													<input name="address" class="form-control"
														value="${detail.address}" />
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<label>연봉</label>
												</div>
												<div class="col-md-6">
													<input name="sal" class="form-control"
														value='<fmt:formatNumber value="${detail.sal}" type="number" pattern="#,###.##"/>' />
												</div>
											</div>
											<div class="row">
												<div class="col-md-6">
													<label>보너스</label>
												</div>
												<div class="col-md-6">
													<input name="comm" class="form-control"
														value="${detail.comm }" />
												</div>
											</div>
											<label>근무이력</label>
											<c:forEach var="eh" items="${emphistory}">
												<div class="row">
													<div class="col-md-6">
														<label> ${eh.startdate } ~ <c:choose>
																<c:when test="${not empty eh.enddate }">
																${eh.enddate}
															</c:when>
																<c:when test="${empty eh.enddate }">
																현재
															</c:when>
															</c:choose>
														</label>
													</div>
													<div class="col-md-6">
														<h6>${eh.dname} ${eh.jname}</h6>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<!-- DataTales Example -->
				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2020</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>
	<script type="text/javascript">
		$(document).ready(function() {
			$("input").attr("readonly", true);
			$("#file").attr("readonly", false);
			var empno = "${emp.empno}"
			var sesNo = "${sesEmp.empno}"
			var auth = Number("${sesEmp.auth}")
			console.log(empno)
			console.log(sesNo)
			console.log(auth)
			if (auth > 4 || empno === sesNo) {
				$("#profile-tab").show();
			} else if (auth < 3 || empno !== sesNo || auth == null) {
				$("#profile-tab").css("display", "none");
				$("#editBtn").css("display", "none");
			}
			var rrn = "${detail.rrn}"
			var rrnFront = rrn.substr(0, 6);
			var rrnEnd = rrn.substr(6);
			$("[name=rrn]").val(rrnFront + "-" + rrnEnd);
			
		})
	</script>
	<!-- Logout Modal-->
	<!-- Bootstrap core JavaScript-->
	<script src="a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="a00_com/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="a00_com/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="a00_com/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="a00_com/js/demo/datatables-demo.js"></script>
	<script src="https://unpkg.com/vue" type="text/javascript"></script>
	<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</body>

</html>