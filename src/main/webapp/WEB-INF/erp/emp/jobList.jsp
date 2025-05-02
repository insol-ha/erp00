<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>
<style>
tbody tr:hover {
	background-color: lightgray;
}
.table-responsive{
	background-image:url("http://192.168.0.106:2222/upload/pyramid.png");
	background-repeat:no-repeat !important;
	background-size:100% 100% !important;
	background-position:-15px center !important;
	height:auto !important;
	width:1000px !important;
	display: flex;
    flex-direction: column; /* 수직 정렬을 위해 추가 */
    justify-content: center; /* 수직 중앙 정렬 */
    align-items: center; /* 수평 중앙 정렬 */
    text-align: center; /* 내부 텍스트 중앙 정렬 */
}
.table-responsive > div {
    display: flex;
    justify-content: center; /* 내부 요소들을 가로 정렬 */
    align-items: -10px center; /* 내부 요소들을 세로 정렬 */
    width: 100%; /* 부모 요소 크기에 맞춤 */
    color:black;
    margin-left:-15px !important;
}
.table-responsive > div >h6 {
	font-weight: bold;
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
					<h1 class="h3 mb-2 text-gray-800">권한체계도</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">직책/권한</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
							<br>
									<c:forEach var="job" items="${jList}">
										<c:choose>
											<c:when test="${job.auth == 1}">
												<div><h6>${job.jname }(권한 ${job.auth})</h6></div><br>
											</c:when>
											<c:when test="${job.auth == 2}">
												<div><h6>${job.jname }(권한 ${job.auth})</h6></div><br>
											</c:when>
											<c:when test="${job.auth == 3}">
												<div><h6>${job.jname }(권한 ${job.auth})</h6></div><br>
											</c:when>
											<c:when test="${job.auth == 4}">
												<div><h6>${job.jname }(권한 ${job.auth})</h6></div><br>
											</c:when>
											<c:when test="${job.auth == 5}">
												<div><h6>${job.jname }(권한 ${job.auth})</h6></div><br>
											</c:when>
											<c:when test="${job.auth == 6}">
												<div><h6>${job.jname }(권한 ${job.auth})</h6></div><br>
											</c:when>
											<c:when test="${job.auth == 7}">
												<div><h6>${job.jname }(권한 ${job.auth})</h6></div><br>
											</c:when>
											<c:when test="${job.auth == 8}">
												<div><h6>${job.jname }(권한 ${job.auth})</h6></div><br>
											</c:when>
											<c:when test="${job.auth == 9}">
												<div><h6 style="background-color:white;">${job.jname }<br>
												(권한 ${job.auth})</h6></div><br>
											</c:when>
										</c:choose>
									</c:forEach>
							</div>
						</div>
					</div>
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