<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>
<style type="text/css">
.input-group-text {
	width: 100%;
	background-color: linen;
	color: black;
	font-weight: bolder;
}
.input-group-prepend {
	width: 20%;
}

</style>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Dashboard</title>

<!-- Custom fonts for this template-->
<link href="a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="a00_com/css/sb-admin-2.min.css" rel="stylesheet">

<script src="a00_com/vendor/jquery/jquery.min.js"></script>
</head>

<body id="page-top">
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
					<h1 class="h3 mb-2 text-gray-800">공지사항 등록</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">공지사항 등록</h6>
						</div>
						<div class="card-body">
							<form method="post" action="boardInsert"
								enctype="multipart/form-data">

								<input type="hidden" name="refno"
									value="${empty re.refno?0:re.refno}" />
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">제목</span>
									</div>
									<input name="subject" class="form-control"
										value="${re.subject}" />
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">작성자</span>
									</div>
									<input name="writer" class="form-control" value="${sesEmp.empno }" readonly/>
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">등록일</span>
									</div>
									<input type="date" name="trgdate" class="form-control" value="" />
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">내용</span>
									</div>
									<textarea name="content" class="form-control" rows="10"
										cols="20" style="resize: none;">${re.content}</textarea>
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">첨부파일</span>
									</div>
									<input type="file" multiple="multiple" name="reports"
										class="form-control" value="" />
								</div>
								<div style="text-align: right;">
									<input type="button" class="btn btn-success" value="등록"
										id="regBtn" /> <input type="button" class="btn btn-info"
										value="조회리스트" id="mainBtn" />
								</div>
							</form>
							<footer class="sticky-footer bg-white">
								<div class="container my-auto">
									<div class="copyright text-center my-auto">
										<span>Copyright &copy; Your Website 2021</span>
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


					<!-- Bootstrap core JavaScript-->
					<script type="text/javascript">
						$(document).ready(function() {
							$("#regBtn").click(function() {
								if($("[name=writer]").val()==null||$("[name=writer]").val() == "" ){
									alert("작성자를 등록하세요")
								}else if($("[name=writer]").val()!=null||$("[name=writer]").val() != "" ){
									if (confirm("등록하시겠습니까?")) {
										$("form").submit()
									}
								}
							})
							$("#mainBtn").click(function() {
								location.href = "boardList"
							})
							var msg = "${msg}"
							if (msg != "")
								alert(msg)
						});
					</script>
					<!-- Bootstrap core JavaScript-->
					<script src="a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

					<!-- Core plugin JavaScript-->
					<script src="a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

					<!-- Custom scripts for all pages-->
					<script src="a00_com/js/sb-admin-2.min.js"></script>

					<!-- Page level plugins -->
					<script src="a00_com/vendor/datatables/jquery.dataTables.min.js"></script>
					<script
						src="a00_com/vendor/datatables/dataTables.bootstrap4.min.js"></script>

					<!-- Page level custom scripts -->
					<script src="a00_com/js/demo/datatables-demo.js"></script>
					<script src="https://unpkg.com/vue" type="text/javascript"></script>
					<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</body>
</html>
